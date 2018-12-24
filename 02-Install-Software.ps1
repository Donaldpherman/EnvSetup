Write-Host @"

*=====================================================================================
 Choco Auto Installer
 This script is for setup new dev machine for mxtao.
 The project is forked from Edi Wang's. The original address is https://github.com/EdiWang/EnvSetup
 Feel free to modify it to fit your own requirements. 
*=====================================================================================

"@

Write-Host "[WARNING] Ma de in China: some software like Google Chrome require the true Internet first" -ForegroundColor Yellow

# todo: add other apps

# dotnet, idea, scala, python

# winscp filezilla sumatrapdf cmder docker rufus driverboost

# tim 

$apps = @(
    @("7-Zip", "7zip.install"),
    @("Google Chrome", "googlechrome"),
    @("PotPlayer", "potplayer"),
    @("NotePad++", "notepadplusplus.install"),
    @("Visual Studio Code", @(
        "vscode",
        "vscode-csharp",
        "vscode-icons",
        "vscode-mssql"
    )),
    @("Git", "git")
)

function ChocoInstall($appName, $packageName) {
    Write-Host ""
    Write-Host "------------------------------------"
    Write-Host "Installing $appName..."
    Write-Host ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    if ($packageName -is [array]) {
        foreach ($package in $packageName) {
            choco install $package -y
        }
    }
    else {
        choco install $packageName -y
    }
    Write-Host "------------------------------------"
    Write-Host ""
}

Write-Host "setting proxy for choco, you can unset it anytime" -BackgroundColor Yellow
choco config set proxy 127.0.0.1:1080

Write-Host "now start install apps"

ChocoInstall $apps