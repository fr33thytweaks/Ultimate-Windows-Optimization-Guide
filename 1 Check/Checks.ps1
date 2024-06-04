function CheckAdminRights {
  If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
  }
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

function SpaceCheck {
  CheckAdminRights
  $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
  $Host.UI.RawUI.BackgroundColor = "Black"
  $Host.PrivateData.ProgressBackgroundColor = "Black"
  $Host.PrivateData.ProgressForegroundColor = "White"
  Clear-Host
  Start-Process explorer shell:MyComputerFolder
  Write-Host "Maintain at least 10% free space."
  Write-Host "Press any key to go back . . ."
  $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
  

}

function RamCheck {
  CheckAdminRights
  $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
  $Host.UI.RawUI.BackgroundColor = "Black"
  $Host.PrivateData.ProgressBackgroundColor = "Black"
  $Host.PrivateData.ProgressForegroundColor = "White"
  Clear-Host
  Write-Host "Installing: Cpu Z . . ."
  # download cpuz
  Get-FileFromWeb -URL "https://download.cpuid.com/cpu-z/cpu-z_2.09-en.zip" -File "$env:TEMP\Cpu Z.zip" 
  # extract files
  Expand-Archive "$env:TEMP\Cpu Z.zip" -DestinationPath "$env:TEMP\Cpu Z" -ErrorAction SilentlyContinue
  # start cpuz
  Start-Process "$env:TEMP\Cpu Z\cpuz_x64.exe"
  Clear-Host
  Write-Host "Check (XMP DOCP EXPO) is enabled."
  Write-Host "Verify RAM is in the correct slots."
  Write-Host "Confirm there is no mismatch in RAM modules."
  Write-Host "At least two RAM sticks (dual channel) is ideal."
  Write-Host "Press any key to go back . . ."
  $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

 
}

function GpuCheck {
  CheckAdminRights
  $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
  $Host.UI.RawUI.BackgroundColor = "Black"
  $Host.PrivateData.ProgressBackgroundColor = "Black"
  $Host.PrivateData.ProgressForegroundColor = "White"
  Clear-Host
  Write-Host "Installing: Gpu Z . . ."
  # download gpuz
  Get-FileFromWeb -URL "https://ftp.nluug.nl/pub/games/PC/guru3d/generic/GPU-Z-[Guru3D.com].zip" -File "$env:TEMP\Gpu Z.zip"
  # extract files
  Expand-Archive "$env:TEMP\Gpu Z.zip" -DestinationPath "$env:TEMP\Gpu Z" -ErrorAction SilentlyContinue
  # start gpuz
  Start-Process "$env:TEMP\Gpu Z\GPU-Z.2.59.0.exe"
  Clear-Host
  Write-Host "Check PCIe bus interface is at maximum."
  Write-Host "Verify monitor cable is connected to the GPU."
  Write-Host "Confirm GPU is in the top PCIe motherboard slot."
  Write-Host "Running multiple graphics cards is not recommended."
  Write-Host "Press any key to go back . . ."
  $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function BiosUpdate {
  CheckAdminRights
  $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
  $Host.UI.RawUI.BackgroundColor = "Black"
  $Host.PrivateData.ProgressBackgroundColor = "Black"
  $Host.PrivateData.ProgressForegroundColor = "White"
  Clear-Host

  # get motherboard id
  $instanceID = (wmic baseboard get product)
  # search motherboard id in web browser
  Start-Process "https://www.google.com/search?q=$instanceID"
  
}

function BiosSettings {
  CheckAdminRights
  $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
  $Host.UI.RawUI.BackgroundColor = "Black"
  $Host.PrivateData.ProgressBackgroundColor = "Black"
  $Host.PrivateData.ProgressForegroundColor = "White"
  Clear-Host
  Write-Host "INTEL CPU"
  Write-Host "-ENABLE ram profile (XMP DOCP EXPO)"
  Write-Host "-DISABLE c-state"
  Write-Host "-ENABLE resizable bar (REBAR C.A.M)"
  Write-Host ""
  Write-Host "AMD CPU"
  Write-Host "-ENABLE ram profile (XMP DOCP EXPO)"
  Write-Host "-ENABLE precision boost overdrive (PBO)"
  Write-Host "-ENABLE resizable bar (REBAR C.A.M)"
  Write-Host ""
  Write-Host "MAX pump and set fans to performance"
  Write-Host ""
  Write-Host "DISABLE any driver installer software"
  Write-Host "-Asus armory crate"
  Write-Host "-MSI driver utility"
  Write-Host "-Gigabyte update utility"
  Write-Host "-Asrock motherboard utility"
  $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
  Clear-Host

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

function CpuTest {
  CheckAdminRights
  $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
  $Host.UI.RawUI.BackgroundColor = "Black"
  $Host.PrivateData.ProgressBackgroundColor = "Black"
  $Host.PrivateData.ProgressForegroundColor = "White"
  Clear-Host
  Write-Host "Installing: Prime95 . . ."
  # download prime95
  Get-FileFromWeb -URL "https://www.mersenne.org/download/software/v30/30.19/p95v3019b13.win64.zip" -File "$env:TEMP\Prime 95.zip"
  # extract files
  Expand-Archive "$env:TEMP\Prime 95.zip" -DestinationPath "$env:TEMP\Prime 95" -ErrorAction SilentlyContinue
  # start prime95
  Start-Process "$env:TEMP\Prime 95\prime95.exe"
  Clear-Host
  Write-Host "Run a basic CPU stress test to check for errors."
  Write-Host "Check temps and WHEA errors in Hw Info during this test."
  Write-Host "In Prime95, click 'Window' and select 'Merge All Workers'."
  Write-Host ""
  Write-Host "CPU and RAM errors should not be ignored as they can lead to:"
  Write-Host "-Corrupted Windows"
  Write-Host "-Corrupted files"
  Write-Host "-Stutters and hitches"
  Write-Host "-Poor performance"
  Write-Host "-Input lag"
  Write-Host "-Shutdowns"
  Write-Host "-Blue screens"
  Write-Host ""
  Write-Host "Basic troubleshooting for errors or issues running XMP DOCP EXPO:"
  Write-Host "-BIOS out of date? (update)"
  Write-Host "-BIOS bugged out? (clear CMOS)"
  Write-Host "-Incompatible RAM? (check QVL)"
  Write-Host "-Mismatched RAM? (replace)"
  Write-Host "-RAM in wrong slots? (check manual)"
  Write-Host "-Unlucky CPU memory controller? (lower RAM speed)"
  Write-Host "-Overclock? (turn it off/dial it down)"
  Write-Host "-CPU cooler overtightened? (loosen)"
  Write-Host "-CPU overheating? (repaste/retighten/RMA cooler)"
  Write-Host "-RAM overheating? Typically over 55deg. (fix case flow/ram fan)"
  Write-Host "-Faulty RAM stick? (RMA)"
  Write-Host "-Faulty motherboard? (RMA)"
  Write-Host "-Faulty CPU? (RMA)"
  Write-Host "-Bent CPU pin? (RMA)"
  Write-Host "press any key to go back . . ."
  $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function RamTest {
  CheckAdminRights
  $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
  $Host.UI.RawUI.BackgroundColor = "Black"
  $Host.PrivateData.ProgressBackgroundColor = "Black"
  $Host.PrivateData.ProgressForegroundColor = "White"
  Clear-Host
  Write-Host "Installing: TM5 . . ."
  # allow powershell to download tm5
  Add-Type @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {public bool CheckValidationResult(ServicePoint srvPoint, X509Certificate certificate, WebRequest request, int certificateProblem) {return true;}}
"@
  [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
  # download tm5
  $result = Get-FileFromWeb -URL "https://testmem.tz.ru/tm5.rar" -File "$env:TEMP\TM5.rar"
  # download 7zip
  Get-FileFromWeb -URL "https://www.7-zip.org/a/7z2301-x64.exe" -File "$env:TEMP\7-Zip.exe"
  # install 7zip
  Start-Process -wait "$env:TEMP\7-Zip.exe" /S
  # extract files with 7zip
  cmd /c "C:\Program Files\7-Zip\7z.exe" x "$env:TEMP\TM5.rar" -o"$env:TEMP" -y | Out-Null
  # create config for tm5
  $MultilineComment = @"
Memory Test config file v0.02
Copyrights to the program belong to me.
Serj
testmem.tz.ru
serj_m@hotmail.com

[Main Section]
Config Name=ABSOLUT(01102021)
Config Author=anta777
Cores=0
Tests=16
Time (%)=1250
Cycles=3
Language=0
Test Sequence=1,4,6,15,3,2,7,15,5,2,8,15,4,2,9,15,3,2,10,15,5,2,11,15,4,2,12,15,5,14,15

[Global Memory Setup]
Channels=2
Interleave Type=1
Single DIMM width, bits=64
Operation Block, byts=64
Testing Window Size (Mb)=1536
Lock Memory Granularity (Mb)=64
Reserved Memory for Windows (Mb)=512
Capable=0x0
Debug Level=7

[Window Position]
WindowPosX=400
WindowPosY=400

[Test0]
Enable=1
Time (%)=8
Function=RefreshStable
DLL Name=bin\MT0.dll
Pattern Mode=0
Pattern Param0=0x0
Pattern Param1=0x0
Parameter=0
Test Block Size (Mb)=0

[Test1]
Enable=1
Time (%)=240
Function=SimpleTest
DLL Name=bin\MT0.dll
Pattern Mode=2
Pattern Param0=0x77777777
Pattern Param1=0x33333333
Parameter=0
Test Block Size (Mb)=4

[Test2]
Enable=1
Time (%)=8
Function=SimpleTest
DLL Name=bin\MT0.dll
Pattern Mode=1
Pattern Param0=0
Pattern Param1=0
Parameter=0
Test Block Size (Mb)=0

[Test3]
Enable=1
Time (%)=20
Function=MirrorMove128
DLL Name=bin\MT0.dll
Pattern Mode=0
Pattern Param0=0x0
Pattern Param1=0x0
Parameter=2
Test Block Size (Mb)=0

[Test4]
Enable=1
Time (%)=20
Function=MirrorMove
DLL Name=bin\MT0.dll
Pattern Mode=0
Pattern Param0=0x0
Pattern Param1=0x0
Parameter=4
Test Block Size (Mb)=0

[Test5]
Enable=1
Time (%)=20
Function=MirrorMove128
DLL Name=bin\MT0.dll
Pattern Mode=0
Pattern Param0=0x0
Pattern Param1=0x0
Parameter=1
Test Block Size (Mb)=0

[Test6]
Enable=1
Time (%)=240
Function=SimpleTest
DLL Name=bin\MT0.dll
Pattern Mode=0
Pattern Param0=0x0
Pattern Param1=0x0
Parameter=0
Test Block Size (Mb)=4

[Test7]
Enable=1
Time (%)=120
Function=SimpleTest
DLL Name=bin\MT0.dll
Pattern Mode=0
Pattern Param0=0x0
Pattern Param1=0x0
Parameter=0
Test Block Size (Mb)=8

[Test8]
Enable=1
Time (%)=60
Function=SimpleTest
DLL Name=bin\MT0.dll
Pattern Mode=0
Pattern Param0=0x0
Pattern Param1=0x0
Parameter=0
Test Block Size (Mb)=16

[Test9]
Enable=1
Time (%)=30
Function=SimpleTest
DLL Name=bin\MT0.dll
Pattern Mode=0
Pattern Param0=0x0
Pattern Param1=0x0
Parameter=0
Test Block Size (Mb)=32

[Test10]
Enable=1
Time (%)=16
Function=SimpleTest
DLL Name=bin\MT0.dll
Pattern Mode=0
Pattern Param0=0x0
Pattern Param1=0x0
Parameter=0
Test Block Size (Mb)=64

[Test11]
Enable=1
Time (%)=8
Function=SimpleTest
DLL Name=bin\MT0.dll
Pattern Mode=0
Pattern Param0=0x0
Pattern Param1=0x0
Parameter=0
Test Block Size (Mb)=128

[Test12]
Enable=1
Time (%)=8
Function=SimpleTest
DLL Name=bin\MT0.dll
Pattern Mode=0
Pattern Param0=0x0
Pattern Param1=0x0
Parameter=0
Test Block Size (Mb)=256

[Test13]
Enable=1
Time (%)=8
Function=SimpleTest
DLL Name=bin\MT0.dll
Pattern Mode=0
Pattern Param0=0x0
Pattern Param1=0x0
Parameter=0
Test Block Size (Mb)=512

[Test14]
Enable=1
Time (%)=8
Function=SimpleTest
DLL Name=bin\MT0.dll
Pattern Mode=0
Pattern Param0=0x0
Pattern Param1=0x0
Parameter=0
Test Block Size (Mb)=0

[Test15]
Enable=1
Time (%)=8
Function=SimpleTest
DLL Name=bin\MT0.dll
Pattern Mode=0
Pattern Param0=0x0
Pattern Param1=0x0
Parameter=256
Test Block Size (Mb)=0
"@
  Set-Content -Path "$env:TEMP\TM5\bin\MT.cfg" -Value $MultilineComment -Force
  # set config to read only
  Set-ItemProperty -Path "$env:TEMP\TM5\bin\MT.cfg" -Name IsReadOnly -Value $true
  # start tm5
  Start-Process "$env:TEMP\TM5\TM5.exe"
  Clear-Host
  Write-Host "Run a basic RAM stress test to check for errors."
  Write-Host "Check temps and WHEA errors in Hw Info during this test."
  Write-Host "TM5 will run three cycles."
  Write-Host ""
  Write-Host "CPU and RAM errors should not be ignored as they can lead to:"
  Write-Host "-Corrupted Windows"
  Write-Host "-Corrupted files"
  Write-Host "-Stutters and hitches"
  Write-Host "-Poor performance"
  Write-Host "-Input lag"
  Write-Host "-Shutdowns"
  Write-Host "-Blue screens"
  Write-Host ""
  Write-Host "Basic troubleshooting for errors or issues running XMP DOCP EXPO:"
  Write-Host "-BIOS out of date? (update)"
  Write-Host "-BIOS bugged out? (clear CMOS)"
  Write-Host "-Incompatible RAM? (check QVL)"
  Write-Host "-Mismatched RAM? (replace)"
  Write-Host "-RAM in wrong slots? (check manual)"
  Write-Host "-Unlucky CPU memory controller? (lower RAM speed)"
  Write-Host "-Overclock? (turn it off/dial it down)"
  Write-Host "-CPU cooler overtightened? (loosen)"
  Write-Host "-CPU overheating? (repaste/retighten/RMA cooler)"
  Write-Host "-RAM overheating? Typically over 55deg. (fix case flow/ram fan)"
  Write-Host "-Faulty RAM stick? (RMA)"
  Write-Host "-Faulty motherboard? (RMA)"
  Write-Host "-Faulty CPU? (RMA)"
  Write-Host "-Bent CPU pin? (RMA)"
  Write-Host "press any key to go back . . ."
  $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function GpuTest {
  CheckAdminRights
  $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
  $Host.UI.RawUI.BackgroundColor = "Black"
  $Host.PrivateData.ProgressBackgroundColor = "Black"
  $Host.PrivateData.ProgressForegroundColor = "White"
  Clear-Host
  Write-Host "Installing: Furk Mark . . ."
  # download furkmark
  Get-FileFromWeb -URL "https://geeks3d.com/downloads/2024p/furmark2/FurMark_2.3.0.0_win64.zip" -File "$env:TEMP\Furk Mark.zip"
  # extract files
  Expand-Archive "$env:TEMP\Furk Mark.zip" -DestinationPath "$env:TEMP\Furk Mark" -ErrorAction SilentlyContinue
  # start furkmark
  Start-Process "$env:TEMP\Furk Mark\FurMark_win64\FurMark_GUI.exe"
  Clear-Host
  Write-Host "Run a basic GPU stress test."
  Write-Host ""
  Write-Host "Basic troubleshooting items to monitor:"
  Write-Host "-Temps"
  Write-Host "-Framerate"
  Write-Host "-Artifacts"
  Write-Host "-Freezing"
  Write-Host "-Driver crashes"
  Write-Host "-Shutdowns"
  Write-Host "-Blue screens"
  Write-Host "press any key to go back . . ."
  $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function HwInfo {
  CheckAdminRights
  $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
  $Host.UI.RawUI.BackgroundColor = "Black"
  $Host.PrivateData.ProgressBackgroundColor = "Black"
  $Host.PrivateData.ProgressForegroundColor = "White"
  Clear-Host
  Write-Host "Installing: Hw Info . . ."
  # download hwinfo
  Get-FileFromWeb -URL "https://ixpeering.dl.sourceforge.net/project/hwinfo/Windows_Portable/hwi_772.zip" -File "$env:TEMP\Hw Info.zip"
  # extract files
  Expand-Archive "$env:TEMP\Hw Info.zip" -DestinationPath "$env:TEMP\Hw Info" -ErrorAction SilentlyContinue
  # start hwinfo
  Start-Process "$env:TEMP\Hw Info\HWiNFO64.exe"
}

function show-menu {
  Clear-Host
  Write-Host "Select an option:"
  Write-Host "1. Exit"
  Write-Host "2. Space Check"
  Write-Host "3. Ram Check"
  Write-Host "4. Gpu Check"
  Write-Host "5. Bios Update"
  Write-Host "6. Bios Settings"
  Write-Host "7. Cpu Test"
  Write-Host "8. Ram Test"
  Write-Host "9. Gpu Test"
  Write-Host "10. Hw Info"
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
        SpaceCheck
        show-menu
      }
      3 {
        Clear-Host
        RamCheck
        show-menu
        
      }
      4 {
        Clear-Host
        GpuCheck
        show-menu
      }
      5 {
        Clear-Host
        BiosUpdate
        show-menu
      } 6 {
        Clear-Host
        BiosSettings
        show-menu
      } 7 {
        Clear-Host  
        CpuTest
        show-menu
      } 8 {
        Clear-Host
        RamTest
        show-menu
      } 9 {
        Clear-Host
        GpuTest
        show-menu
      } 10 {
        Clear-Host
        HwInfo
        show-menu
      }
    } 
  }
}
else {
  Write-Host "Invalid input. Please select a valid option (1-10)."
}