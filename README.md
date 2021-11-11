# Windows 8.1 Pro with Media Center ISO Creation Tool
 A Tool for creating Windows 8.1 Pro with Media Center Edition ISO from a Home or Pro Edition ISO
 - You can use any Windows 8.1 ISO. Whether it is Single Language, Core or Pro this tool will convert it to ProWMC.
 - This tool can use ISO, DVD or a folder containing Windows 8.1 installation files as source.
 - This tool also enables .Net Framework 3.5 in Windows 8.1 Pro with Media Center ISO after creating it.

**Note:** Please Run this tool as Administrator.

## How to Use?
1. Select your ISO or DVD/folder containing Windows 8.1 installation files.
2. Select where you want to save your Windows 8.1 Pro with Media Center ISO.
3. Select compression type ESD or WIM. ESD is powerful than WIM but it takes a lot of time and resources.
4. Now you can relax all the process is done automatically. You can leave computer because it takes upto an hour depending upon your computer's configuration.

## System Requirments
This Tool Requires Deployment tools from Windows ADK 8.1 to be able run. But, now that ADK 8.1 is no longer available, I'm publishing this version that I made for my personal use so that I can use it without installing Deployment tools every time. This Version includes Deployment tools with it.

There are two files one (**Windows-8.1-Pro-WMC-ISO-Tool-v1.2-DT.zip**) with Deployment tools **included** and one (**Windows-8.1-Pro-WMC-ISO-Tool-v1.2.zip**) in which you'll have to add files from Deployment tools (If you already have it) manually. Here is how:

1. Copy all the files and folders inside **"C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Deployment Tools\amd64\DISM"** to **dism\x64** folder.
2. Copy all the files and folders inside **"C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Deployment Tools\x86\DISM"** to **dism\x86** folder.
3. Copy **oscdimg.exe** inside **"C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg"** to **Oscdimg** folder. And rename it to **oscdimgx64.exe**.
4. Copy **oscdimg.exe** inside **"C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Deployment Tools\x86\Oscdimg"** to **Oscdimg** folder. And rename it to **oscdimgx86.exe**.

If unsure, download [**Windows-8.1-Pro-WMC-ISO-Tool-v1.2-DT.zip**](https://github.com/XaHertz/Windows-8.1-Pro-WMC-ISO-Tool/releases/download/v1.2/Windows-8.1-Pro-WMC-ISO-Tool-v1.2-DT.zip).

## Credits
- **7-zip**<br/>
  This tool includes command line version of 7-zip by **Igor Pavlov**.<br/>
  7-zip can be downloaded from www.7-zip.org.<br/>
  License and Readme of 7-zip are inside 7z folder.

- **Dialog Boxes**<br/>
  This tool includes Dialog Boxes by **Rob van der Woude**.<br/>
  Dialog Boxes can be downloaded from https://www.robvanderwoude.com/dialogboxes.php.
