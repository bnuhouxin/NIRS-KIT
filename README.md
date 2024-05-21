# MRI Parameters Report for Siemens


![](https://img.shields.io/badge/updata-2023/08/15-orange.svg)
![](https://img.shields.io/badge/version-v3.0-brightgreen.svg)
![](https://img.shields.io/badge/release-2019/11/15-green.svg)
![](https://img.shields.io/badge/licese-GPLV3.0-blue.svg)
------

## [Introduction:]
**This is a ***[Matlab-based]()*** toolbox to automatically report the MRI scanning parameters information.**

Please report any bugs, comments and/or suggestions to: Xin Hou, [houxin195776@mail.bnu.edu.cn]().

## [Note]()
- **Now, it only works well for Siemens or GE scaner ([3D T1 && Functional Images]()) parameter report.**
- **Here, the reported slice order information for following [slice timing]() functional MRI data was generated by ([dcm2niix](https://github.com/rordenlab/dcm2niix)), so we recommend you to convert your raw dicom data to nifti format. To get more detailed information, please see [Slice Time Correction](https://www.mccauslandcenter.sc.edu/crnl/tools/stc).**

><b>Siemens Image Numbering</b><br>
The Siemens scanner allows you to reverse the image numbering, as described in the white paper below. Specifically, for axial acquisitions you can open the exam explorer and go to the 'System' tab's 'Miscellaneous' page and set the Transversal Image Numbering to H>>F (instead of the default F>>H). Doing this will flip the order images are displayed in the mosaics (with the upper left being the most superior rather than most inferior slice). There is some confusion regarding whether this option changes merely the image storage or the image acquisition.<br>

## [Installing The Toolbox:]

- **Download and unzip MRI_Parameters_Report.zip**
- **Start Matlab**
- **Add the [MRI_Parameters_Report]() directory to the matlab search path (in [*Matlab’s File->Set Path->Add with Subfolders*]() )**
- **Please ensure the dcm2niix.exe in the matlab search path; you can tape ```>> which dcm2niix.exe ``` in matlab command window to check it**  
- **Click [Save]() and then [Close]()**

The [MRI_Parameters_Report]() is now at the beginning of the MATLAB search path.
## [Requirements:]

- [**SPM12**](https://www.fil.ion.ucl.ac.uk/spm/software/spm12/)

## [To Start The Toolbox:]

- **On the Matlab command window, type:**
``` matlab
  >> MRI_Parameters_Report_GUI
```

- **If your Matlab version is above R2016, we recommend you use mlapp. To start it, On the Matlab command window, type:** 
``` matlab
  >> MRI_Parameters_Report
```
## [User Guide:]
- **Step1:** Click the pushbutton in the upper right corner to add the [***Raw DCM/IMG Folder***]().

  [**Note**]：The folder you add must be a single one that contains all raw *.dcm/*.img files scanned within a single run. That is, you can select a folder including all the 3D T1 images or a folder including all your functional images during one task/rest scanning run.

- **Step2:** Click the [**Report**]() pushbutton, then a graphical marquee interface pops up, now you need to select file path to store the reported information file ([*.mat]()) that will be produced. 

  Then about one minute later, all the works will be done. The output information will be printed on the GUI interface, and a mat file that contains all the output information will saved to your predefined file path.


<img src="https://github.com/bnuhouxin/MRI_Parameter_Report/blob/master/exam.png" width="500" />