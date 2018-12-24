if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

# -----------------------------------------------------------------------------
$computerName = Read-Host 'Enter New Computer Name'
Write-Host "Renaming this computer to: " $computerName  -ForegroundColor Yellow
Rename-Computer -NewName $computerName

# -----------------------------------------------------------------------------
Write-Host ""
Write-Host "Disable Sleep on AC Power..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Powercfg /Change monitor-timeout-ac 20
Powercfg /Change standby-timeout-ac 0

# -----------------------------------------------------------------------------
Write-Host ""
Write-Host "Add 'This PC' Desktop Icon..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
$thisPCIconRegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
$thisPCRegValname = "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" 
$item = Get-ItemProperty -Path $thisPCIconRegPath -Name $thisPCRegValname -ErrorAction SilentlyContinue 
if ($item) { 
    Set-ItemProperty  -Path $thisPCIconRegPath -name $thisPCRegValname -Value 0  
} 
else { 
    New-ItemProperty -Path $thisPCIconRegPath -Name $thisPCRegValname -Value 0 -PropertyType DWORD  | Out-Null  
} 

# -----------------------------------------------------------------------------
Write-Host ""
Write-Host "Removing Edge Desktop Icon..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
$edgeLink = $env:USERPROFILE + "\Desktop\Microsoft Edge.lnk"
Remove-Item $edgeLink

# -----------------------------------------------------------------------------
Write-Host ""
Write-Host "Installing Windows Optional Features..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
$optionalFeatures = @(
    "Microsoft-Hyper-V",
    "Windows-Defender-ApplicationGuard",
    "Microsoft-Windows-Subsystem-Linux"
)
Write-Host "Install $(optionalFeatures.Length)"
foreach ($feature in $optionalFeatures) {
    Write-Host ""
    Write-Host "Installing $feature..." -ForegroundColor Green
    Write-Host ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" -ForegroundColor Green
    Enable-WindowsOptionalFeature -Online -FeatureName $feature -All
    Write-Host "Install $feature Done." -ForegroundColor Green
}

# -----------------------------------------------------------------------------
Write-Host ""
Write-Host "Enable Windows 10 Developer Mode..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

# -----------------------------------------------------------------------------
# Write-Host ""
# Write-Host "Enable Remote Desktop..." -ForegroundColor Green
# Write-Host "------------------------------------" -ForegroundColor Green
# Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\" -Name "fDenyTSConnections" -Value 0
# Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\" -Name "UserAuthentication" -Value 1
# Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# -----------------------------------------------------------------------------
Write-Host ""
Write-Host "Installing Chocolate for Windows..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
$webclient = New-Object System.Net.WebClient
$webclient.Proxy = New-Object System.Net.WebProxy("127.0.0.1", 1080)
Set-ExecutionPolicy Bypass -Scope Process -Force
$webclient.DownloadString('https://chocolatey.org/install.ps1') | Invoke-Expression

# -----------------------------------------------------------------------------
Read-Host -Prompt "Configuration is done, restart is needed, press [ENTER] to restart computer."
Restart-Computer