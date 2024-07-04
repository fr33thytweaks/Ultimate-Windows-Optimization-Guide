    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
    {Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit}
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
    $Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
    $Host.PrivateData.ProgressForegroundColor = "White"
    Clear-Host

# W11
#create updater script
$scriptContent = @"
`$keys = Get-ChildItem -Path 'registry::HKEY_CURRENT_USER\Control Panel\NotifyIconSettings' -Recurse -Force

foreach (`$key in `$keys) {
    #if the value is set to 0 do not set it to 1
    #set 1 when no reg key is there (new apps)
    if ((Get-ItemProperty -Path "registry::`$key").IsPromoted -eq 0) {
    }
    else {
        Set-ItemProperty -Path "registry::`$key" -Name 'IsPromoted' -Value 1 -Force
    }
}
"@

$scriptPath = "$env:ProgramData\UpdateTaskTrayIcons.ps1"
Set-Content -Path $scriptPath -Value $scriptContent -Force

#get username and sid
$currentUserName = $env:COMPUTERNAME + '\' + $env:USERNAME
$username = Get-LocalUser -Name $env:USERNAME | Select-Object -ExpandProperty sid

$content = @"
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Date>2024-05-20T12:59:50.8741407</Date>
    <Author>$currentUserName</Author>
    <URI>\UpdateTaskTray</URI>
  </RegistrationInfo>
   <Triggers>
    <LogonTrigger>
      <Enabled>true</Enabled>
    </LogonTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <UserId>$username</UserId>
      <LogonType>InteractiveToken</LogonType>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>true</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>true</StopIfGoingOnBatteries>
    <AllowHardTerminate>true</AllowHardTerminate>
    <StartWhenAvailable>false</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <StopOnIdleEnd>true</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>false</Hidden>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <WakeToRun>false</WakeToRun>
    <ExecutionTimeLimit>PT72H</ExecutionTimeLimit>
    <Priority>7</Priority>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>PowerShell.exe</Command>
      <Arguments>-ExecutionPolicy Bypass -WindowStyle Hidden -File C:\ProgramData\UpdateTaskTrayIcons.ps1</Arguments>
    </Exec>
  </Actions>
</Task>
"@
Set-Content -Path "$env:TEMP\UpdateTaskTray" -Value $content -Force

schtasks /Create /XML "$env:TEMP\UpdateTaskTray" /TN '\UpdateTaskTray' /F | Out-Null 

Remove-Item -Path "$env:TEMP\UpdateTaskTray" -Force -ErrorAction SilentlyContinue

# W10
# show all taskbar icons
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "EnableAutoTray" /t REG_DWORD /d "0" /f | Out-Null
  
Write-Host "Restart to apply . . ."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")