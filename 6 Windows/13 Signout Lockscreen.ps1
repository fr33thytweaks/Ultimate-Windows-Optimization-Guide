    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
    {Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit}
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
    $Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
    $Host.PrivateData.ProgressForegroundColor = "White"
    Clear-Host

    Write-Host "1. SignOut & LockScreen: Black (Recommended)"
    Write-Host "2. SignOut & LockScreen: Default"
    while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-2]$') {
    switch ($choice) {
    1 {

Clear-Host
# takeownership
cmd /c "takeown.exe /f `"C:\Windows\Web\Screen`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\Screen`" /grant *S-1-3-4:F /t /q >nul 2>&1"
# takeownership
cmd /c "takeown.exe /f `"C:\Windows\Web\Screen\img100.jpg`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\Screen\img100.jpg`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\Windows\Web\Screen\img101.jpg`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\Screen\img101.jpg`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\Windows\Web\Screen\img101.png`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\Screen\img101.png`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\Windows\Web\Screen\img102.jpg`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\Screen\img102.jpg`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\Windows\Web\Screen\img103.jpg`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\Screen\img103.jpg`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\Windows\Web\Screen\img103.png`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\Screen\img103.png`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\Windows\Web\Screen\img104.jpg`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\Screen\img104.jpg`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\Windows\Web\Screen\img105.jpg`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\Screen\img105.jpg`" /grant *S-1-3-4:F /t /q >nul 2>&1"
# backup sign-out images
Move-Item -Path "$env:C:\Windows\Web\Screen\img100.jpg" -Destination "$env:C:\Windows\Web" -ErrorAction SilentlyContinue | Out-Null
Move-Item -Path "$env:C:\Windows\Web\Screen\img101.jpg" -Destination "$env:C:\Windows\Web" -ErrorAction SilentlyContinue | Out-Null
Move-Item -Path "$env:C:\Windows\Web\Screen\img101.png" -Destination "$env:C:\Windows\Web" -ErrorAction SilentlyContinue | Out-Null
Move-Item -Path "$env:C:\Windows\Web\Screen\img102.jpg" -Destination "$env:C:\Windows\Web" -ErrorAction SilentlyContinue | Out-Null
Move-Item -Path "$env:C:\Windows\Web\Screen\img103.jpg" -Destination "$env:C:\Windows\Web" -ErrorAction SilentlyContinue | Out-Null
Move-Item -Path "$env:C:\Windows\Web\Screen\img103.png" -Destination "$env:C:\Windows\Web" -ErrorAction SilentlyContinue | Out-Null
Move-Item -Path "$env:C:\Windows\Web\Screen\img104.jpg" -Destination "$env:C:\Windows\Web" -ErrorAction SilentlyContinue | Out-Null
Move-Item -Path "$env:C:\Windows\Web\Screen\img105.jpg" -Destination "$env:C:\Windows\Web" -ErrorAction SilentlyContinue | Out-Null
# create new sign-out images
Add-Type -AssemblyName System.Drawing
$file = "$env:C:\Windows\Web\Screen\img100.jpg"
$edit = New-Object System.Drawing.Bitmap 3840,2160
$color = [System.Drawing.Brushes]::Black
$graphics = [System.Drawing.Graphics]::FromImage($edit)
$graphics.FillRectangle($color, 0, 0, $edit.Width, $edit.Height)
$graphics.Dispose()
$edit.Save($file)
Add-Type -AssemblyName System.Drawing
$file = "$env:C:\Windows\Web\Screen\img101.jpg"
$edit = New-Object System.Drawing.Bitmap 3840,2400
$color = [System.Drawing.Brushes]::Black
$graphics = [System.Drawing.Graphics]::FromImage($edit)
$graphics.FillRectangle($color, 0, 0, $edit.Width, $edit.Height)
$graphics.Dispose()
$edit.Save($file)
Clear-Host
Add-Type -AssemblyName System.Drawing
$file = "$env:C:\Windows\Web\Screen\img101.png"
$edit = New-Object System.Drawing.Bitmap 3840,2400
$color = [System.Drawing.Brushes]::Black
$graphics = [System.Drawing.Graphics]::FromImage($edit)
$graphics.FillRectangle($color, 0, 0, $edit.Width, $edit.Height)
$graphics.Dispose()
$edit.Save($file)
Clear-Host
Add-Type -AssemblyName System.Drawing
$file = "$env:C:\Windows\Web\Screen\img102.jpg"
$edit = New-Object System.Drawing.Bitmap 6400,4000
$color = [System.Drawing.Brushes]::Black
$graphics = [System.Drawing.Graphics]::FromImage($edit)
$graphics.FillRectangle($color, 0, 0, $edit.Width, $edit.Height)
$graphics.Dispose()
$edit.Save($file)
Add-Type -AssemblyName System.Drawing
$file = "$env:C:\Windows\Web\Screen\img103.jpg"
$edit = New-Object System.Drawing.Bitmap 3839,2400
$color = [System.Drawing.Brushes]::Black
$graphics = [System.Drawing.Graphics]::FromImage($edit)
$graphics.FillRectangle($color, 0, 0, $edit.Width, $edit.Height)
$graphics.Dispose()
$edit.Save($file)
Clear-Host
Add-Type -AssemblyName System.Drawing
$file = "$env:C:\Windows\Web\Screen\img103.png"
$edit = New-Object System.Drawing.Bitmap 3839,2400
$color = [System.Drawing.Brushes]::Black
$graphics = [System.Drawing.Graphics]::FromImage($edit)
$graphics.FillRectangle($color, 0, 0, $edit.Width, $edit.Height)
$graphics.Dispose()
$edit.Save($file)
Clear-Host
Add-Type -AssemblyName System.Drawing
$file = "$env:C:\Windows\Web\Screen\img104.jpg"
$edit = New-Object System.Drawing.Bitmap 3840,2400
$color = [System.Drawing.Brushes]::Black
$graphics = [System.Drawing.Graphics]::FromImage($edit)
$graphics.FillRectangle($color, 0, 0, $edit.Width, $edit.Height)
$graphics.Dispose()
$edit.Save($file)
Add-Type -AssemblyName System.Drawing
$file = "$env:C:\Windows\Web\Screen\img105.jpg"
$edit = New-Object System.Drawing.Bitmap 1920,1200
$color = [System.Drawing.Brushes]::Black
$graphics = [System.Drawing.Graphics]::FromImage($edit)
$graphics.FillRectangle($color, 0, 0, $edit.Width, $edit.Height)
$graphics.Dispose()
$edit.Save($file)
# takeownership
cmd /c "takeown.exe /f `"C:\ProgramData\Microsoft\Windows\SystemData`" >nul 2>&1"
cmd /c "icacls.exe `"C:\ProgramData\Microsoft\Windows\SystemData`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\ProgramData\Microsoft\Windows\SystemData\S-1-5-18`" >nul 2>&1"
cmd /c "icacls.exe `"C:\ProgramData\Microsoft\Windows\SystemData\S-1-5-18`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\ProgramData\Microsoft\Windows\SystemData\S-1-5-18\ReadOnly`" >nul 2>&1"
cmd /c "icacls.exe `"C:\ProgramData\Microsoft\Windows\SystemData\S-1-5-18\ReadOnly`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\ProgramData\Microsoft\Windows\SystemData\S-1-5-18\ReadOnly\LockScreen_Z`" >nul 2>&1"
cmd /c "icacls.exe `"C:\ProgramData\Microsoft\Windows\SystemData\S-1-5-18\ReadOnly\LockScreen_Z`" /grant *S-1-3-4:F /t /q >nul 2>&1"
# delete lock screen images
cmd /c "rd /s /q `"C:\ProgramData\Microsoft\Windows\SystemData\S-1-5-18`" >nul 2>&1"
# find folder
$findFolder = "C:\ProgramData\Microsoft\Windows\SystemData"
$matchingFolder = Get-ChildItem -Recurse -Directory -Force $findFolder -ErrorAction SilentlyContinue | Where-Object { $_.Name -like "S-*" }
$matchingFolder = $($matchingFolder.Name)
$directoryPath = "C:\ProgramData\Microsoft\Windows\SystemData"
$fullFolderPath = Join-Path -Path $directoryPath -ChildPath $matchingFolder
# takeownership folders
takeown.exe /f $fullFolderPath | Out-Null
icacls.exe $fullFolderPath /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly | Out-Null
icacls.exe $fullFolderPath\ReadOnly /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_A | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_A /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_B | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_B /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_C | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_C /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_D | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_D /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_E | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_E /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_F | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_F /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_G | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_G /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_H | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_H /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_I | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_I /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_J | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_J /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_K | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_K /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_L | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_L /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_M | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_M /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_N | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_N /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_O | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_O /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_P | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_P /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_Q | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_Q /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_R | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_R /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_S | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_S /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_T | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_T /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_U | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_U /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_V | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_V /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_W | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_W /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_R | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_R /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_X | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_X /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_Y | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_Y /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_Z | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_Z /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
# delete lock screen images
cmd /c "rd /s /q `"C:\ProgramData\Microsoft\Windows\SystemData`" >nul 2>&1"
# set lock screen settings to picture
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d "0" /f | Out-Null
Write-Host "Restart to apply . . ."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    2 {

Clear-Host
# takeownership
cmd /c "takeown.exe /f `"C:\Windows\Web\Screen`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\Screen`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\Windows\Web\img100.jpg`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\img100.jpg`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\Windows\Web\img101.jpg`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\img101.jpg`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\Windows\Web\img101.png`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\img101.png`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\Windows\Web\img102.jpg`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\img102.jpg`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\Windows\Web\img103.jpg`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\img103.jpg`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\Windows\Web\img103.png`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\img103.png`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\Windows\Web\img104.jpg`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\img104.jpg`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\Windows\Web\img105.jpg`" >nul 2>&1"
cmd /c "icacls.exe `"C:\Windows\Web\img105.jpg`" /grant *S-1-3-4:F /t /q >nul 2>&1"
# restore sign-out images
cmd /c "move /y `"C:\Windows\Web\img100.jpg`" `"C:\Windows\Web\Screen`" >nul 2>&1"
cmd /c "move /y `"C:\Windows\Web\img101.jpg`" `"C:\Windows\Web\Screen`" >nul 2>&1"
cmd /c "move /y `"C:\Windows\Web\img101.png`" `"C:\Windows\Web\Screen`" >nul 2>&1"
cmd /c "move /y `"C:\Windows\Web\img102.jpg`" `"C:\Windows\Web\Screen`" >nul 2>&1"
cmd /c "move /y `"C:\Windows\Web\img103.jpg`" `"C:\Windows\Web\Screen`" >nul 2>&1"
cmd /c "move /y `"C:\Windows\Web\img103.png`" `"C:\Windows\Web\Screen`" >nul 2>&1"
cmd /c "move /y `"C:\Windows\Web\img104.jpg`" `"C:\Windows\Web\Screen`" >nul 2>&1"
cmd /c "move /y `"C:\Windows\Web\img105.jpg`" `"C:\Windows\Web\Screen`" >nul 2>&1"
# takeownership
cmd /c "takeown.exe /f `"C:\ProgramData\Microsoft\Windows\SystemData`" >nul 2>&1"
cmd /c "icacls.exe `"C:\ProgramData\Microsoft\Windows\SystemData`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\ProgramData\Microsoft\Windows\SystemData\S-1-5-18`" >nul 2>&1"
cmd /c "icacls.exe `"C:\ProgramData\Microsoft\Windows\SystemData\S-1-5-18`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\ProgramData\Microsoft\Windows\SystemData\S-1-5-18\ReadOnly`" >nul 2>&1"
cmd /c "icacls.exe `"C:\ProgramData\Microsoft\Windows\SystemData\S-1-5-18\ReadOnly`" /grant *S-1-3-4:F /t /q >nul 2>&1"
cmd /c "takeown.exe /f `"C:\ProgramData\Microsoft\Windows\SystemData\S-1-5-18\ReadOnly\LockScreen_Z`" >nul 2>&1"
cmd /c "icacls.exe `"C:\ProgramData\Microsoft\Windows\SystemData\S-1-5-18\ReadOnly\LockScreen_Z`" /grant *S-1-3-4:F /t /q >nul 2>&1"
# delete lock screen images
cmd /c "rd /s /q `"C:\ProgramData\Microsoft\Windows\SystemData\S-1-5-18`" >nul 2>&1"
# find folder
$findFolder = "C:\ProgramData\Microsoft\Windows\SystemData"
$matchingFolder = Get-ChildItem -Recurse -Directory -Force $findFolder -ErrorAction SilentlyContinue | Where-Object { $_.Name -like "S-*" }
$matchingFolder = $($matchingFolder.Name)
$directoryPath = "C:\ProgramData\Microsoft\Windows\SystemData"
$fullFolderPath = Join-Path -Path $directoryPath -ChildPath $matchingFolder
# takeownership folders
takeown.exe /f $fullFolderPath | Out-Null
icacls.exe $fullFolderPath /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly | Out-Null
icacls.exe $fullFolderPath\ReadOnly /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_A | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_A /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_B | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_B /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_C | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_C /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_D | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_D /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_E | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_E /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_F | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_F /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_G | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_G /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_H | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_H /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_I | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_I /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_J | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_J /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_K | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_K /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_L | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_L /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_M | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_M /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_N | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_N /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_O | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_O /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_P | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_P /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_Q | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_Q /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_R | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_R /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_S | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_S /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_T | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_T /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_U | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_U /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_V | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_V /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_W | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_W /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_R | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_R /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_X | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_X /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_Y | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_Y /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
takeown.exe /f $fullFolderPath\ReadOnly\LockScreen_Z | Out-Null
icacls.exe $fullFolderPath\ReadOnly\LockScreen_Z /grant *S-1-3-4:F /t /q | Out-Null
Clear-Host
# delete lock screen images
cmd /c "rd /s /q `"C:\ProgramData\Microsoft\Windows\SystemData`" >nul 2>&1"
# set lock screen settings to windows spotlight
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d "1" /f | Out-Null
Write-Host "Restart to apply . . ."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    } } else { Write-Host "Invalid input. Please select a valid option (1-2)." } }