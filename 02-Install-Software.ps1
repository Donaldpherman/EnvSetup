Write-Host @"

*=====================================================================================
 Choco Auto Installer
 This script is for setup new dev machine for mxtao.
 The project is forked from Edi Wang's. The original address is https://github.com/EdiWang/EnvSetup
 Feel free to modify it to fit your own requirements. 
*=====================================================================================

"@

Write-Host "[WARNING] Ma de in China: some software like Google Chrome require the true Internet first" -ForegroundColor Yellow

$apps = @(
    # ---------- language and sdks ----------
    @(".Net Core SDK", "dotnetcore-sdk"),
    @("Python", "python"),
    @("Java SE 8.0.191 SDK", "jdk8"),
    @("Java SE 11.0.1 SDK", "jdk11"),
    @("Scala", "scala"),

    # ---------- normal softwares ----------
    @("7-Zip", "7zip.install"),
    @("Google Chrome", "googlechrome"),
    @("PotPlayer", "potplayer"),
    @("SumatraPDF", "sumatrapdf"),
    @("Tim", "tim"),
    #@("Driver Booster"),

    # ---------- tools for dev ----------
    @("WinSCP", "winscp"),
    @("FileZilla", "filezilla"),
    @("Cmder Mini", "cmdermini"),
    @("Rufus", "rufus"),
    @("Git", "git"),
    @("Docker Desktop", "docker-desktop"),

    # ---------- editor or ide ----------
    @("NotePad++", "notepadplusplus.install"),
    @("Visual Studio Code", @(
        "vscode",
        "vscode-csharp",
        "vscode-icons",
        "vscode-mssql",
        "vscode-powershell",
        "vscode-docker",
        "vscode-gitlens"
    )),
    @("Visual Studio 2017 Enterprise", "visualstudio2017enterprise"),
    @("JetBrains ReSharper", "resharper"),
    @("JetBrains IntelliJ IDEA (Ultimate Edition)", "intellijidea-ultimate")

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