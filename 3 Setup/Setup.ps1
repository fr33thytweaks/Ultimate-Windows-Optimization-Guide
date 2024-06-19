function CheckAdmin {
  If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
  }
  $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
  $Host.UI.RawUI.BackgroundColor = "Black"
  $Host.PrivateData.ProgressBackgroundColor = "Black"
  $Host.PrivateData.ProgressForegroundColor = "White"
  Clear-Host
}

CheckAdmin

function activateHomeToPro {
  Write-Host "Disable: Internet . . ."
  $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
  # open device manager
  Start-Process devmgmt.msc
  Clear-Host
  Write-Host "Press any key to continue . . ."
  $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
  Clear-Host
  # copy key to clipboard
  Set-Clipboard -Value "VK7JG-NPHTM-C97JM-9MPGT-3V66T"
  Write-Host "Enter: VK7JG-NPHTM-C97JM-9MPGT-3V66T (Or Paste From Clipboard) . . ."
  $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
  # create device manager shortcut
  $WshShell = New-Object -comObject WScript.Shell
  $Shortcut = $WshShell.CreateShortcut("$Home\Desktop\Enable Internet.lnk")
  $Shortcut.TargetPath = "$env:C:\Windows\System32\devmgmt.msc"
  $Shortcut.Save()
  # open activation screen
  Start-Process slui.exe 3
  Clear-Host
  Write-Host "Enter: VK7JG-NPHTM-C97JM-9MPGT-3V66T (Or Paste From Clipboard) . . ."
  $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function backgroundApps {
  Write-Host "1. Backround Apps: Off (Recommended)"
  Write-Host "2. Backround Apps: Default"
  while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-2]$') {
      switch ($choice) {
        1 {

          Clear-Host
          # disable background apps regedit
          reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f | Out-Null
          Write-Host "Restart to apply . . ."
          $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
          # open settings
          Start-Process ms-settings:privacy-backgroundapps
          exit

        }
        2 {

          Clear-Host
          # background apps regedit
          cmd /c "reg delete `"HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications`" /v `"GlobalUserDisabled`" /f >nul 2>&1"
          Write-Host "Restart to apply . . ."
          $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
          # open settings
          Start-Process ms-settings:privacy-backgroundapps
          exit

        }
      } 
    }
    else { Write-Host "Invalid input. Please select a valid option (1-2)." } 
  } 
}

function edgeUpdates {
  # open ublock origin in web browser
  Start-Process "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" "https://microsoftedge.microsoft.com/addons/detail/ublock-origin/odfafepnkmbhccpbejgmiehpchacaeak"
}


function show-menu {
  Clear-Host
  Write-Host "Select an option:"
  Write-Host "1. Exit"
  Write-Host "2. Activate Home To Pro"
  Write-Host "3. Background Apps"
  Write-Host "4. Edge Updates"
}

show-menu

while ($true) {
  $selection = Read-Host " "
  if ($selection -match '^(1[0-7]|[1-9])$') {
    switch ($selection) {
      1 {
        Clear-Host
        exit
      }
      2 {
        Clear-Host
        activateHomeToPro
        show-menu
      }
      3 {
        Clear-Host
        backgroundApps
        show-menu
      }
      4 {
        Clear-Host
        edgeUpdates 
        show-menu
      }
    }
  }
  else { Write-Host "Invalid input. Please select a valid option (1-4)." }
}