@echo off
SET BATDIR=%~dp0
cd /d %BATDIR% 
color a
Title Windows 8.1 Pro with Media Center ISO Creation Tool
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::                                                                       ::::
echo ::::         Windows 8.1 Pro with Media Center ISO Creation Tool           ::::
echo ::::                                                                       ::::
echo ::::                                                     -By Xahertz       ::::
echo ::::                                                                       ::::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
FOR /F "tokens=*" %%A IN ('dialog-boxes\DropDownBox.exe "Select what you have:\n- You have a Windows 8.1 ISO\n- You have a Windows 8.1 DVD\n- Your Windows 8.1 Installation Files are in a Folder" "Windows 8.1 Installation Files" /W:330 /H:140 /F:dialog-boxes\1.txt /C:40 ^|^| ECHO Error^& IF ERRORLEVEL 2 ECHO Cancel') DO SET var=%%A
cls
if %var%==ISO goto :1
if %var%==DVD goto :2
if %var%==Folder goto :2

:1
FOR /F "tokens=*" %%A IN ('dialog-boxes\OpenFileBox.exe "Disc Image File (*.iso)|*.iso" "%USERPROFILE%\Desktop" "Select Your Windows 8.1 ISO" ^|^| ECHO Error^& IF ERRORLEVEL 2 ECHO Cancel') DO SET ISOpath=%%A
cls
goto :7

:2
FOR /F "tokens=*" %%A IN ('dialog-boxes\OpenFolderBox.exe "%USERPROFILE%\Desktop" "Select your Windows 8.1  DVD or Folder Containing Installation Files" /MD ^|^| ECHO Error^& IF ERRORLEVEL 2 ECHO Cancel') DO SET ISOpath=%%A
cls
goto :7

:7
FOR /F "tokens=*" %%A IN ('dialog-boxes\SaveFileBox.exe "Disc Image File (*.iso)|*.iso" "%USERPROFILE%\Desktop" "Where you want to Save Your Windows 8.1 Pro with Media Center ISO" ^|^| ECHO Error^& IF ERRORLEVEL 2 ECHO Cancel') DO SET fiso=%%A
md Temporary
SET var2=Temporary
cls
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::                                                                       ::::
echo ::::                       Select Compression Type                         ::::
echo ::::                                                                       ::::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
FOR /F "tokens=*" %%A IN ('dialog-boxes\DropDownBox.exe "Select What you want ESD or WIM Compression:\nESD  - High compression\n         - ISO size is around 3.2 GB\n         - Takes lots of time\n         - It has taken about 2hrs in my pc\nWIM  - Normal compression\n         - ISO size is around 3.8 GB\n         - Takes not so much time\n         - It has taken about 1hrs in my pc" "Select Compression Type" /W:320 /H:205 /F:dialog-boxes\2.txt /C:40 ^|^| ECHO Error^& IF ERRORLEVEL 2 ECHO Cancel') DO SET type=%%A
cls
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::                                                                       ::::
echo ::::            This can take upto an hour depending upon your             ::::
echo ::::                       Computer's Configuration                        ::::
echo ::::                                                                       ::::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo Are you sure you want to continue. . .
echo.
pause
cls
if %var%==ISO goto :11
if %var%==DVD goto :22
if %var%==Folder goto :22

:11
7z\7z.exe x "%ISOpath%" -o"%var2%\ISO"
cls
goto :77

:22
xcopy "%ISOpath%" "%var2%\ISO\" /e /y
cls
goto :77

:77
IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)
:64bit
set dism="%ProgramFiles(x86)%\Windows Kits\8.1\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe"
set oscdimg="%ProgramFiles(x86)%\Windows Kits\8.1\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\oscdimg.exe"
set imagex="%ProgramFiles(x86)%\Windows Kits\8.1\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\imagex.exe"
goto :install

:32bit
set dism="%ProgramFiles%\Windows Kits\8.1\Assessment and Deployment Kit\Deployment Tools\x86\DISM\dism.exe"
set oscdimg="%ProgramFiles%\Windows Kits\8.1\Assessment and Deployment Kit\Deployment Tools\x86\Oscdimg\oscdimg.exe"
set imagex="%ProgramFiles%\Windows Kits\8.1\Assessment and Deployment Kit\Deployment Tools\x86\DISM\imagex.exe"
goto :install

:install
if exist "%var2%\ISO\sources\install.wim" goto :wim
if exist "%var2%\ISO\sources\install.esd" goto :esd

:wim
md %var2%\mount
%dism% /Mount-Wim /WimFile:"%var2%\ISO\sources\install.wim" /index:1 /mountdir:"%var2%\mount"
%dism% /Image:"%var2%\mount" /Set-Edition:ProfessionalWMC
%dism% /Image:"%var2%\mount" /enable-feature /featurename:NetFX3 /source:"%var2%\ISO\sources\sxs" /LimitAccess
%dism% /Unmount-Wim /MountDir:"%var2%\mount" /commit
cls
goto :imagex

:esd
md %var2%\mount
md %var2%\tempwim
%dism% /export-image /SourceImageFile:"%var2%\ISO\sources\install.esd" /SourceIndex:1 /DestinationImageFile:"%var2%\tempwim\install.wim" /Compress:max /CheckIntegrity
%dism% /Mount-Wim /WimFile:"%var2%\tempwim\install.wim" /index:1 /mountdir:"%var2%\mount"
%dism% /Image:"%var2%\mount" /Set-Edition:ProfessionalWMC
%dism% /Image:"%var2%\mount" /enable-feature /featurename:NetFX3 /source:"%var2%\ISO\sources\sxs" /LimitAccess
%dism% /Unmount-Wim /MountDir:"%var2%\mount" /commit
move /y "%var2%\tempwim\install.wim" "%var2%\ISO\sources\"
del "%var2%\ISO\sources\install.esd"
cls
goto :imagex

:imagex
%imagex% /flags "ProfessionalWMC"  /info "%var2%\ISO\sources\install.wim" 1 "Windows 8.1 Pro with Media Center" "Windows 8.1 Pro with Media Center"
ren "%var2%\ISO\sources\install.wim" install2.wim
if %type%==ESD goto :esd1
if %type%==WIM goto :wim1

:esd1
%dism% /export-image /SourceImageFile:"%var2%\ISO\sources\install2.wim" /SourceIndex:1 /DestinationImageFile:"%var2%\ISO\sources\install.esd" /Compress:recovery /CheckIntegrity
del "%var2%\ISO\sources\install2.wim"
cls
goto :ISO

:wim1
%dism% /export-image /SourceImageFile:"%var2%\ISO\sources\install2.wim" /SourceIndex:1 /DestinationImageFile:"%var2%\ISO\sources\install.wim" /Compress:max /CheckIntegrity
del "%var2%\ISO\sources\install2.wim"
cls
goto :ISO

:ISO
%oscdimg% -m -o -u2 -lESD-ISO -udfver102 -bootdata:2#p0,e,b"%var2%\ISO\boot\etfsboot.com"#pEF,e,b"%var2%\ISO\efi\microsoft\boot\efisys.bin" "%var2%\ISO" "%fiso%"
goto :end

:end
rd /s /q "%var2%"
cls
echo.
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::                                                                       ::::
echo ::::           Your Windows 8.1 Pro with Media Center ISO has              ::::
echo ::::                       been created sucessfully                        ::::
echo ::::                                                                       ::::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
pause
