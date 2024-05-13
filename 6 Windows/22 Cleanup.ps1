    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
    {Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit}
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
    $Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
    $Host.PrivateData.ProgressForegroundColor = "White"
    Clear-Host

# clear %temp% folder
Remove-Item -Path "$env:USERPROFILE\AppData\Local\Temp" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
New-Item -Path "$env:USERPROFILE\AppData\Local" -Name "Temp" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
# open %temp% folder
Start-Process $env:TEMP
# clear temp folder
Remove-Item -Path "$env:C:\Windows\Temp" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
New-Item -Path "$env:C:\Windows" -Name "Temp" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
# open temp folder
Start-Process $env:C:\Windows\Temp
# open disk cleanup
Start-Process cleanmgr.exe