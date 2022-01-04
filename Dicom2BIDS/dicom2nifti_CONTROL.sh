#!bin/bash
dir="/Users/apple/Desktop/MRI/CONTROL"



for sub in $dir/*
do
    sub_idx="${sub:(-3)}" #subject number

    #subject별로 Dicom 파일 외의 파일들을 지운다.
    echo $sub
    for files in $sub/*
    do
    if  [ $files != "${sub}/DICOM" ]
    then
        if [ -f $files ]
        then
            rm $files
        else
            rm -r $files
        fi
    fi
    done

    #Dicom 파일들을 nifti로 바꾼다. 그 다음 DICOM 파일을 지운다.
    echo `dcm2niix -o ${sub} -z y "${sub}/DICOM"`
    rm -r  "${sub}/DICOM"


    mkdir "${sub}/anat"
    mkdir "${sub}/dwi"

    for files in $sub/*
    do
    #3D_T1이 이름에 들어가 있는 파일들은 3D_T1 문자열을 T1w로 바꾸고 anat 폴더에 넣어준다. 원래 파일들은 지워준다.
    if [[ "${files}" == *"3D_T1"* ]] && [[ "${files}" == *".json"* ]]
    then
        mv $files "${sub}/anat/sub-${sub_idx}_t1w.json"
        rm $files

    elif [[ "${files}" == *"3D_T1"* ]] && [[ "${files}" == *".nii.gz"* ]]
    then
        mv $files "${sub}/anat/sub-${sub_idx}_t1w.nii.gz"
        rm $files

    #DTI가 이름에 들어가 있는 파일들은 DTI 문자열을 dwi로 바꾸고 dwi 폴더에 넣어준다.
    elif [[ "${files}" == *"DTI"* ]] && [[ "${files}" == *".json"* ]]
    then
        mv $files "${sub}/dwi/sub-${sub_idx}_dwi.json"
        rm $files

    elif [[ "${files}" == *"DTI"* ]] && [[ "${files}" == *".nii.gz"* ]]
    then
        mv $files "${sub}/dwi/sub-${sub_idx}_dwi.nii.gz"
        rm $files

    elif [[ "${files}" == *"DTI"* ]] && [[ "${files}" == *".bval"* ]]
    then
        mv $files "${sub}/dwi/sub-${sub_idx}_dwi.bval"
        rm $files

    elif [[ "${files}" == *"DTI"* ]] && [[ "${files}" == *".bvec"* ]]
    then
        mv $files "${sub}/dwi/sub-${sub_idx}_dwi.bvec"
        rm $files
    
    else
        # 필요하지 않은 파일들은 그냥 삭제해 버린다.
        rm $files
    fi
    done

    #맨 마지막으로 subject 폴더의 이름 변경
    mv $sub "${dir}/sub-${sub_idx}"

done
