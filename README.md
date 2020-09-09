# BIOPAC_analysis
A package containing matlab scripts and functions to run on exskeleton data output by BIOPAC EMG hardware/software (AcqKnowledge).

## The file structure of your workspace should be as follows:

```
<your_workspace>
│   README.md    
|
└───output files (*this will all be automatically generated*) 
│   └───B## (one will be generated for each participant)
│       └───NOEXO
│       └───S## MVC
│       └───WEXO
|
└───participant data (**You need to put your files in here!!**)
│   └───B## (you will create one for each participant)
│       └───NOEXO
│       └───S## MVC
│       └───WEXO
```

You can add more folders if you wish, but do not put any items other than what is expected inside of the required aprticipant data folders. If there are any files with the same extensions as those used during the processing (.xlsx or .txt) inside of those folders, the program will treat them as files that need to be processed and you will get an error.  
