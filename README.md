# Windows 10 Developer Machine Setup

This is the script for mxtao to setup a new dev box. You can modify the scripts to fit your own requirements.

The project is forked from Edi Wang's. The original address is [here](https://github.com/EdiWang/EnvSetup)

## Prerequisites

- A clean install of Windows 10 Pro v1809 en-us.
- If you are in China: a stable "Internet" connection.

*This script has not been tested on other version of Windows, please be careful if you are using it on other Windows versions.*

## How to Use

Run the following scripts in order.

### (Optional)

Import "Add_PS1_Run_as_administrator.reg" to your registry to enable context menu on the powershell files to run as Administrator.

### 01-Prepare-Windows.ps1

- Set a New Computer Name
- Disable Sleep on AC Power
- Add 'This PC' Desktop Icon (need refresh desktop)
- Remove "Microsoft Edge" desktop shortcut icon
- Install Windows Optional Feature
  - Hyper-V
  - Windows Defender Application Guard
  - Windows Subsystem Linux
- Enable Developer Mode (for UWP Development)
- Install Chocolate for Windows
- Restart Windows

### 02-Install-Software.ps1

Use choco to install softwares.

- language and sdks
  - .Net Core SDK
  - Python
  - Java SE 8
  - Java SE 11
  - Scala
- normal softwares
  - 7-Zip
  - Google Chrome
  - PotPlayer
  - Tim
  - SumatraPDF
- tools for dev
  - WinSCP
  - FileZilla
  - Cmder Mini
  - Rufus
  - Git
  - Docker Desktop
- editor or ide
  - NotPad++
  - Visual Studio Code
    - C#
    - vscode-icons
    - mssq
    - PowerShell
    - Docker
    - GitLens
  - Visual Studio 2017 Enterprise
    - JetBrains ReSharper
  - JetBrains IntelliJ IDEA (Ultimate Edition)

*To find more software, like Node.js, Firefox, etc. Go to https://chocolatey.org/packages*

### 03-RemovePreInstalledUwp.ps1

Remove a few pre-installed UWP applications

- Messaging
- CandyCrush
- Bing News
- Solitaire
- People
- Feedback Hub
- Your Phone
- My Office
- FitbitCoach
- Netflix