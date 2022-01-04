# Description of Codes
These codes contain processes of **DICOM -> NIFTI** and **NIFTI -> BIDS format**.   
Base directory of bash script is **case subjects** and **control subjects**.  
Before running the code **case subjects and control subjects must be listed in different folders**. 

# File Structure of Original Data

```
|--DATA
    |-- SUBJECT
    |-- DICOM

```

# File Structure of Transformed BIDS Data

```
|--DATA
    |-- CASE
        |-- anat
        |-- dwi
    |-- CONTROL
        |-- anat
        |-- dwi

```
