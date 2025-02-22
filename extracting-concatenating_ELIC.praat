# File for processing Istria corpus data
# Peggy Renwick mrenwick@uga.edu 
# September 2022 adapted from DASS processing script
# February 2025 edited by Keith Langston langston@uga.edu  
# This script cuts longs files into chunks according to a TextGrid's markings, and saves each piece individually (both TextGrid and audio). 

# read in data - INDICATE HERE WHERE THE FILES LIVE 
# Files will be written to the same directory 
form Directory
	sentence directory /Users/username/Desktop/folder-name/
endform

# Tell it to apply to all (.wav) files in the selected directory
Create Strings as file list... fileList 'directory$'*.wav
Sort

# Define the variable number_of_files
numberOfFiles = Get number of strings

# make a for loop that loops over all long sounds for a speaker 
for a from 1 to numberOfFiles
	select Strings fileList
	soundfile$ = Get string... 'a'
	Open long sound file... 'directory$''soundfile$'
	object_name$ = selected$("LongSound")

	# read in the associated TextGrid
	Read from file... 'directory$''object_name$'.TextGrid
	object_text$ = selected$("TextGrid") 

	# get number of intervals in Tier 1 ("segments") 
	select TextGrid 'object_text$'
	number_of_intervals = Get number of intervals... 1 

	# find intervals that are labeled 
	for b from 1 to number_of_intervals
		select TextGrid 'object_text$'
		segment$ = Get label of interval... 1 'b'

		# if segments tier is not empty (i.e., is labeled) for that interval 
		if segment$ <>""

			# then, get start and end points of that interval 
			begin_segment = Get start point... 1 'b'
			end_segment = Get end point... 1 'b'

			# extract the TextGrid corresponding to that part & save it 
			# NOTE that extraction does NOT preserve times. To preserve times, change "no" to "yes" 
			select TextGrid 'object_text$'
			Extract part... begin_segment end_segment "yes"
			Save as text file... 'directory$'/'object_name$'_'b'.TextGrid

			# now select the matching sound and extract the same piece & save it  
			# NOTE that extraction does NOT preserve times. To preserve times, change "no" to "yes" 
			select LongSound 'object_name$'
			Extract part... begin_segment end_segment "yes"
			Save as WAV file... 'directory$'/'object_name$'_'b'.wav

		# end if for the segments tier 
		endif 

	# end the loop that finds intervals 
	endfor

	# Remove all temporary objects 
	select all
	minus Strings fileList
	Remove

# repeat with next file 
select Strings fileList

# end the loop that goes through all the wav files in the folder 
endfor 
clearinfo
select all 
Remove
print That's it! 

#####