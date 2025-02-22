# Praat-segmentation
Praat script to segment long audio files based on intervals in a corresponding TextGrid. This script can be used for a single Sound/TextGrid file pairing or to batch process a set of files. The Sound and TextGrid files must have the same names with the appropriate extension: .wav or .TextGrid).

In Praat, select a .wav file and choose Annotate > To TextGrid. Create one interval tier, named "segments". Place interval boundaries at the points where you would like to divide the audio. Intervals can be named as appropriate for your project (e.g., by topic, by segment number, etc.). Save the .TextGrid file with the same name as the corresponding .wav file.

Place all files to be processed in the same folder and run the Praat script. The individual segments of the audio file and the corresponding TextGrid files will be numbered consecutively (with numbers appended to the original file names) and saved to the same directory. 


