    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
    {Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit}
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
    $Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
    $Host.PrivateData.ProgressForegroundColor = "White"
    Clear-Host

    Write-Host "NVIDIA Highest Performance Power State"
    Write-Host "1. On"
    Write-Host "2. Default"
    while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-2]$') {
    switch ($choice) {
    1 {

Clear-Host
# get gpu driver id
$subkeys = (Get-ChildItem -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}" -Force -ErrorAction SilentlyContinue).Name
foreach($key in $subkeys){
if ($key -notlike '*Configuration'){
# enable p0 state regedit
reg add "$key" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f | Out-Null
}
}
Clear-Host
Write-Host "P0 State: On . . ."
$subkeys = (Get-ChildItem -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}" -Force -ErrorAction SilentlyContinue).Name
foreach($key in $subkeys){
if ($key -notlike '*Configuration'){
# show regedit value
Get-ItemProperty -Path "Registry::$key" -Name 'DisableDynamicPstate'
}
}
Write-Host "Restart to apply . . ."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    2 {

Clear-Host
# get gpu driver id
$subkeys = (Get-ChildItem -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}" -Force -ErrorAction SilentlyContinue).Name
foreach($key in $subkeys){
if ($key -notlike '*Configuration'){
reg add "$key" /v "DisableDynamicPstate" /t REG_DWORD /d "0" /f | Out-Null
# disable p0 state regedit
}
}
Clear-Host
Write-Host "P0 State: Default . . ."
$subkeys = (Get-ChildItem -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}" -Force -ErrorAction SilentlyContinue).Name
foreach($key in $subkeys){
if ($key -notlike '*Configuration'){
# show regedit value
Get-ItemProperty -Path "Registry::$key" -Name 'DisableDynamicPstate'
}
}
Write-Host "Restart to apply . . ."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    } } else { Write-Host "Invalid input. Please select a valid option (1-2)." } }
