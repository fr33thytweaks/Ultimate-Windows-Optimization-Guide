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
# create reg file
$MultilineComment = @"
Windows Registry Editor Version 5.00

; usb overclock with secure boot
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CI\Policy]
"WHQLSettings"=dword:00000001
"@
Set-Content -Path "$env:TEMP\USB Overclock.reg" -Value $MultilineComment -Force
# import reg file
Regedit.exe "$env:TEMP\USB Overclock.reg"
Write-Host "Restart to apply . . ."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    2 {

Clear-Host
# create reg file
$MultilineComment = @"
Windows Registry Editor Version 5.00

; revert usb overclock with secure boot
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CI\Policy]
"WHQLSettings"=-
"@
Set-Content -Path "$env:TEMP\Revert USB Overclock.reg" -Value $MultilineComment -Force
# import reg file
Regedit.exe "$env:TEMP\Revert USB Overclock.reg"
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
Expand-Archive "$env:TEMP\hidusbf.zip" -DestinationPath "$env:USERPROFILE\Downloads\hidusbf" -ErrorAction SilentlyContinue
Clear-Host
Write-Host "Install certificate . . ."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
# start sweetlow.cer
Start-Process "$env:USERPROFILE\Downloads\hidusbf\SweetLow.CER"
Clear-Host
Write-Host "Overclock controller . . ."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
# start hidusbf
Start-Process "$env:USERPROFILE\Downloads\hidusbf\DRIVER\Setup.exe"
exit

      }
    } } else { Write-Host "Invalid input. Please select a valid option (1-3)." } }
