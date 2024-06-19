function CheckAdminRights {
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

CheckAdminRights

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

function ReinstallWindows {
  Write-Host "1. Reinstall: W10"
  Write-Host "2. Reinstall: W11"
  while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-2]$') {
      switch ($choice) {
        1 {
          Clear-Host
          Write-Host "Installing: Media Creation Tool Win 10 . . ."
          # download media creation tool win 10
          Get-FileFromWeb -URL "https://go.microsoft.com/fwlink/?LinkId=2265055" -File "$env:TEMP\Media Creation Tool Win 10.exe"
          # start media creation tool win 10
          Start-Process "$env:TEMP\Media Creation Tool Win 10.exe"
          exit

        }
        2 {
          Clear-Host
          Write-Host "Installing: Media Creation Tool Win 11 . . ."
          # download media creation tool win 11
          Get-FileFromWeb -URL "https://go.microsoft.com/fwlink/?linkid=2156295" -File "$env:TEMP\Media Creation Tool Win 11.exe"
          # start media creation tool win 11
          Start-Process "$env:TEMP\Media Creation Tool Win 11.exe"
          exit

        }
      } 
    }
    else { Write-Host "Invalid input. Please select a valid option (1-2)." } 
  }
}

function autounattend {
  # save autounattend config
  $MultilineComment = @"
<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
  <settings pass="oobeSystem">
      <component name="Microsoft-Windows-International-Core" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS"
          xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
          <InputLocale>0409:00000409</InputLocale>
          <SystemLocale>en-US</SystemLocale>
          <UILanguage>en-US</UILanguage>
          <UILanguageFallback>en-US</UILanguageFallback>
          <UserLocale>en-US</UserLocale>
      </component>
      <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS"
          xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
          <TimeZone>Central Standard Time</TimeZone>
          <OOBE>
              <HideEULAPage>true</HideEULAPage>
              <HideLocalAccountScreen>true</HideLocalAccountScreen>
              <HideOnlineAccountScreens>true</HideOnlineAccountScreens>
              <HideWirelessSetupInOOBE>true</HideWirelessSetupInOOBE>
              <NetworkLocation>Home</NetworkLocation>
              <ProtectYourPC>3</ProtectYourPC>
              <SkipMachineOOBE>true</SkipMachineOOBE>
              <SkipUserOOBE>true</SkipUserOOBE>
          </OOBE>
          <UserAccounts>
              <AdministratorPassword>
                  <PlainText>true</PlainText>
                  <Value></Value>
              </AdministratorPassword>
              <LocalAccounts>
                  <LocalAccount wcm:action="add">
                      <Group>Administrators</Group>
                      <Name>@</Name>
                      <Password>
                          <PlainText>true</PlainText>
                          <Value></Value>
                      </Password>
                  </LocalAccount>
              </LocalAccounts>
          </UserAccounts>
      </component>
  </settings>
  <settings pass="specialize">
      <component name="Microsoft-Windows-Deployment" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS"
          xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
          <RunSynchronous>
              <RunSynchronousCommand wcm:action="add">
                  <Order>1</Order>
                  <Path>net accounts /maxpwage:unlimited</Path>
                  <WillReboot>Never</WillReboot>
              </RunSynchronousCommand>
              <RunSynchronousCommand wcm:action="add">
                  <Order>2</Order>
                  <Path>net user @ /active:Yes</Path>
                  <WillReboot>Never</WillReboot>
              </RunSynchronousCommand>
              <RunSynchronousCommand wcm:action="add">
                  <Order>3</Order>
                  <Path>net user @ /passwordreq:no</Path>
                  <WillReboot>Never</WillReboot>
              </RunSynchronousCommand>
          </RunSynchronous>
      </component>
      <component name="Microsoft-Windows-Security-SPP-UX" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS"
          xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
          <SkipAutoActivation>true</SkipAutoActivation>
      </component>
      <component name="Microsoft-Windows-UnattendedJoin" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS"
          xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
          <Identification>
              <JoinWorkgroup>WORKGROUP</JoinWorkgroup>
          </Identification>
      </component>
  </settings>
  <settings pass="windowsPE">
      <component name="Microsoft-Windows-International-Core-WinPE" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS"
          xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
          <InputLocale>0409:00000409</InputLocale>
          <SystemLocale>en-US</SystemLocale>
          <UILanguage>en-US</UILanguage>
          <UILanguageFallback>en-US</UILanguageFallback>
          <UserLocale>en-US</UserLocale>
          <SetupUILanguage>
              <UILanguage>en-US</UILanguage>
          </SetupUILanguage>
      </component>
      <component name="Microsoft-Windows-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS"
          xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
          <RunSynchronous>
              <RunSynchronousCommand wcm:action="add">
                  <Order>1</Order>
                  <Path>reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /t REG_DWORD /d 1 /f</Path>
                  <Description>Add BypassTPMCheck</Description>
              </RunSynchronousCommand>
              <RunSynchronousCommand wcm:action="add">
                  <Order>2</Order>
                  <Path>reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /t REG_DWORD /d 1 /f</Path>
                  <Description>Add BypassRAMCheck</Description>
              </RunSynchronousCommand>
              <RunSynchronousCommand wcm:action="add">
                  <Order>3</Order>
                  <Path>reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /t REG_DWORD /d 1 /f</Path>
                  <Description>Add BypassSecureBootCheck</Description>
              </RunSynchronousCommand>
              <RunSynchronousCommand wcm:action="add">
                  <Order>4</Order>
                  <Path>reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassCPUCheck" /t REG_DWORD /d 1 /f</Path>
                  <Description>Add BypassCPUCheck</Description>
              </RunSynchronousCommand>
              <RunSynchronousCommand wcm:action="add">
                  <Order>5</Order>
                  <Path>reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassStorageCheck" /t REG_DWORD /d 1 /f</Path>
                  <Description>Add BypassStorageCheck</Description>
              </RunSynchronousCommand>
          </RunSynchronous>
          <Diagnostics>
              <OptIn>false</OptIn>
          </Diagnostics>
          <DynamicUpdate>
              <Enable>false</Enable>
              <WillShowUI>OnError</WillShowUI>
          </DynamicUpdate>
          <UserData>
              <AcceptEula>true</AcceptEula>
              <ProductKey>
                  <Key></Key>
              </ProductKey>
          </UserData>
      </component>
  </settings>
</unattend>
"@
  Set-Content -Path "$env:TEMP\autounattend.xml" -Value $MultilineComment -Force
  # user input change account name in autounattend
  $path = "$env:TEMP\autounattend.xml"
  $username = Read-Host -prompt "Enter Account Name"
(Get-Content $path) -replace "@", $username | out-file $path
  # convert file to utf8
  Get-Content "$env:TEMP\autounattend.xml" | Set-Content -Encoding utf8 "$env:C:\Windows\Temp\autounattend.xml" -Force
  # delete old autounattend file
  Remove-Item -Path "$env:TEMP\autounattend.xml" -Force | Out-Null
  # user input move autounattend to USB
  $file = "$env:C:\Windows\Temp\autounattend.xml"
  $destination = Read-Host -prompt "Enter USB Drive Letter" 
  $destination += ":\"
  Move-Item -Path $file -Destination $destination -Force
  # open USB directory to confirm
  Start-Process $destination
}

function networdDriver {
  # get motherboard id
  $instanceID = (wmic baseboard get product)
  # search motherboard id in web browser
  Start-Process "https://www.duckduckgo.com/?q=$instanceID"
}


function toBios {
  
  Write-Host "Press 'Y' To Restart To BIOS"
  while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[yY]$') {
      switch ($choice) {
        y {

          Clear-Host
          Write-Host "Restarting To BIOS: Press any key to restart . . ."
          $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
          # restart to bios
          cmd /c C:\Windows\System32\shutdown.exe /r /fw
          exit

        }
      } 
    }
    else { Write-Host "Invalid input. Please select a valid option (Y)." } 
  }
}

function show-menu {
  Clear-Host
  Write-Host "Select an option:"
  Write-Host "1. Exit"
  Write-Host "2. Reinstall: Windows 10 or 11"
  Write-Host "3. Auto Unattend"
  Write-Host "4. Network Driver"
  Write-Host "5. To BIOS"
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
        ReinstallWindows
        show-menu
      }
      3 {
        Clear-Host
        autounattend
        show-menu
      }
      4 {
        Clear-Host
        networdDriver
        show-menu
      }
      5 {
        Clear-Host
        toBios  
        show-menu
      }
    }
  }
  else { Write-Host "Invalid input. Please select a valid option (1-5)" }
}