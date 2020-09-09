# BIOPAC_analysis
A package containing matlab scripts and functions to run on exskeleton data output by BIOPAC EMG hardware/software (AcqKnowledge).

## The file structure of your workspace should be as follows:

```
<your_workspace>
│   README.md    
|
└───output files (This will all be automatically generated) 
│   └───B## (one will be generated for each participant)
│       └───NOEXO
│       └───S## MVC
│       └───WEXO
|
└───participant data (You need to put your files in here!!)
    └───B## (you will create one for each participant)
        └───NOEXO
        └───S## MVC
        └───WEXO
```

You can add more folders if you wish, but do not put any items other than what is expected inside of the required aprticipant data folders. If there are any files with the same extensions as those used during the processing (.xlsx or .txt) inside of those folders, the program will treat them as files that need to be processed and you will get an error.  

In order to start, put the required files into a workspace on your computer and then open up the file *run_EMG_processing.m* and change the *participant_num* and *workspacePath* variables to reflect the number of participants you have data for as well as the full file path to your workspace. An example is provided in the comments. If you wish to start at a participant other than participant 1 (B01) then change the for loop as suggested in the comments.  

You chan change line 22 from:  
```
for k=1:1:participant_num
```
to:  
```
for k=5:1:participant_num
```
In order to start from participant 5 (B05) instead of starting from participant 1 (B01). In the same way, you can alter which participant you finish processing, however the proper way to do that is to change your *participant_num* value instead so as to not create confusion.  
