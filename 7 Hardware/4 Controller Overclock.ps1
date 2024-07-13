    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
    {Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit}
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
    $Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
    $Host.PrivateData.ProgressForegroundColor = "White"
    Clear-Host

    function Get-FileFromWeb {
    param ([Parameter(Mandatory)][string]$URL, [Parameter(Mandatory)][string]$File)
    function Show-Progress {
    param ([Parameter(Mandatory)][Single]$TotalValue, [Parameter(Mandatory)][Single]$CurrentValue, [Parameter(Mandatory)][string]$ProgressText, [Parameter()][int]$BarSize = 10, [Parameter()][switch]$Complete)
    $percent = $CurrentValue / $TotalValue
    $percentComplete = $percent * 100
    if ($psISE) { Write-Progress "$ProgressText" -id 0 -percentComplete $percentComplete }
    else { Write-Host -NoNewLine "`r$ProgressText $(''.PadRight($BarSize * $percent, [char]9608).PadRight($BarSize, [char]9617)) $($percentComplete.ToString('##0.00').PadLeft(6)) % " }
    }
    try {
    $request = [System.Net.HttpWebRequest]::Create($URL)
    $response = $request.GetResponse()
    if ($response.StatusCode -eq 401 -or $response.StatusCode -eq 403 -or $response.StatusCode -eq 404) { throw "Remote file either doesn't exist, is unauthorized, or is forbidden for '$URL'." }
    if ($File -match '^\.\\') { $File = Join-Path (Get-Location -PSProvider 'FileSystem') ($File -Split '^\.')[1] }
    if ($File -and !(Split-Path $File)) { $File = Join-Path (Get-Location -PSProvider 'FileSystem') $File }
    if ($File) { $fileDirectory = $([System.IO.Path]::GetDirectoryName($File)); if (!(Test-Path($fileDirectory))) { [System.IO.Directory]::CreateDirectory($fileDirectory) | Out-Null } }
    [long]$fullSize = $response.ContentLength
    [byte[]]$buffer = new-object byte[] 1048576
    [long]$total = [long]$count = 0
    $reader = $response.GetResponseStream()
    $writer = new-object System.IO.FileStream $File, 'Create'
    do {
    $count = $reader.Read($buffer, 0, $buffer.Length)
    $writer.Write($buffer, 0, $count)
    $total += $count
    if ($fullSize -gt 0) { Show-Progress -TotalValue $fullSize -CurrentValue $total -ProgressText " $($File.Name)" }
    } while ($count -gt 0)
    }
    finally {
    $reader.Close()
    $writer.Close()
    }
    }

    Write-Host "1. Registry: USB overclock with Secure Boot"
    Write-Host "2. Registry: Default"
	Write-Host "3. Overclock Controller"

    while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-3]$') {
    switch ($choice) {
    1 {

Clear-Host
# usb overclock with secure boot regedit
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy" /v "WHQLSettings" /t REG_DWORD /d "1" /f | Out-Null
Write-Host "Restart to apply . . ."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    2 {

Clear-Host
# revert usb overclock with secure boot
cmd.exe /c "reg delete `"HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy`" /v `"WHQLSettings`" /f >nul 2>&1"
Write-Host "Restart to apply . . ."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    3 {

Clear-Host
Write-Host "If not using Option 1, disable Secure Boot in BIOS and delete Secure Boot keys . . ."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Clear-Host
Write-Host "Installing: hidusbf . . ."
# download hidusbf
Get-FileFromWeb -URL "https://raw.githubusercontent.com/LordOfMice/hidusbf/master/hidusbf.zip" -File "$env:TEMP\hidusbf.zip"
# extract files
Expand-Archive "$env:TEMP\hidusbf.zip" -DestinationPath "$env:USERPROFILE\Desktop\hidusbf" -ErrorAction SilentlyContinue                                            
Clear-Host
# install sweetlow.cer
$rootCertPath = "$env:USERPROFILE\Desktop\hidusbf\sweetlow.cer"
$rootCert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
$rootCert.Import($rootCertPath)
$certStore = New-Object System.Security.Cryptography.X509Certificates.X509Store('Root', 'LocalMachine')
$certStore.Open('ReadWrite')
$certStore.Add($rootCert)
$certStore.Close()
# create ddu shortcut desktop
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$Home\Desktop\Setup.lnk")
$Shortcut.TargetPath = "$env:USERPROFILE\Desktop\hidusbf\DRIVER\Setup.exe"
$Shortcut.Save()
exit

      }
    } } else { Write-Host "Invalid input. Please select a valid option (1-3)." } }
