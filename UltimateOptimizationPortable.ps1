#Fr33thy ultimate optimization guide portable script

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit	
}
#set console customization
$Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + ' (Administrator)'

#changes console to black
function color ($bc, $fc) {
    $a = (Get-Host).UI.RawUI
    $a.BackgroundColor = $bc
    $a.ForegroundColor = $fc 
    Clear-Host 
}	

color 'black' 'white'


$choice = $null
$github = 'https://raw.githubusercontent.com/fr33thytweaks/Ultimate-Windows-Optimization-Guide/main/'
#main menu
do {
    Clear-Host
    # Get the console window width
    $consoleWidth = $Host.UI.RawUI.WindowSize.Width

    # Calculate the number of padding characters needed on each side
    $padding = ($consoleWidth - 37) / 2

    # Create the full title string with padding
    $fullTitle = '~' * [Math]::Floor($padding) + ' ' + 'FR33THY ULTIMATE OPTIMIZATION GUIDE' + ' ' + '~' * [Math]::Ceiling($padding)

    Write-Host $fullTitle
    Write-Host

    Write-Host 'Select a folder [9 To Quit]: '
    Write-Host '[1] Check >' -ForegroundColor Yellow
    Write-Host '[2] Refresh >' -ForegroundColor Yellow
    Write-Host '[3] Setup >' -ForegroundColor Yellow
    Write-Host '[4] Installers >' -ForegroundColor Yellow
    Write-Host '[5] Graphics >' -ForegroundColor Yellow
    Write-Host '[6] Windows >' -ForegroundColor Yellow
    Write-Host '[7] Hardware >' -ForegroundColor Yellow
    Write-Host '[8] Advanced >' -ForegroundColor Yellow
    Write-Host
    $choice = Read-Host 'Enter 1-9: '
    Clear-Host
    switch ($choice) {
        1 {
            $checkScript = $null
            Write-Host 'Choose a Script to Run [Press ENTER to Go Back]:'
            Write-Host '[1] Space Check' -ForegroundColor Yellow
            Write-Host '[2] Ram Check' -ForegroundColor Yellow
            Write-Host '[3] Gpu Check' -ForegroundColor Yellow
            Write-Host '[4] Bios Update' -ForegroundColor Yellow
            Write-Host '[5] Bios Settings' -ForegroundColor Yellow
            Write-Host '[6] Cpu Test' -ForegroundColor Yellow
            Write-Host '[7] Ram Test' -ForegroundColor Yellow
            Write-Host '[8] Gpu Test' -ForegroundColor Yellow
            Write-Host '[9] Hw Info' -ForegroundColor Yellow
            $checkScript = Read-Host 'Enter Option: '
            Clear-Host
            switch ($checkScript) {
                1 { 
                    Invoke-WebRequest -Uri "$($github)1%20Check/1%20Space%20Check.ps1" -UseBasicParsing | Invoke-Expression 
                }
                2 {
                    Invoke-WebRequest -Uri "$($github)1%20Check/2%20Ram%20Check.ps1" -UseBasicParsing | Invoke-Expression
                }
                3 {
                    Invoke-WebRequest -Uri "$($github)1%20Check/3%20Gpu%20Check.ps1" -UseBasicParsing | Invoke-Expression
                }
                4 {
                    Invoke-WebRequest -Uri "$($github)1%20Check/4%20Bios%20Update.ps1" -UseBasicParsing | Invoke-Expression
                }
                5 {
                    Invoke-WebRequest -Uri "$($github)1%20Check/5%20Bios%20Settings.ps1" -UseBasicParsing | Invoke-Expression
                }
                6 {
                    Invoke-WebRequest -Uri "$($github)1%20Check/6%20Cpu%20Test.ps1" -UseBasicParsing | Invoke-Expression
                }
                7 {
                    Invoke-WebRequest -Uri "$($github)1%20Check/7%20Ram%20Test.ps1" -UseBasicParsing | Invoke-Expression
                }
                8 {
                    Invoke-WebRequest -Uri "$($github)1%20Check/8%20Gpu%20Test.ps1" -UseBasicParsing | Invoke-Expression
                }
                9 {
                    Invoke-WebRequest -Uri "$($github)1%20Check/9%20Hw%20Info.ps1" -UseBasicParsing | Invoke-Expression
                }
                default {
                    #do nothing
                }
            }
        }
        2 {
            $refreshScript = $null
            Write-Host 'Choose a Script to Run [Press ENTER to Go Back]:'
            Write-Host '[1] Reinstall' -ForegroundColor Yellow
            Write-Host '[2] Autounattend' -ForegroundColor Yellow
            Write-Host '[3] Network Driver' -ForegroundColor Yellow
            Write-Host '[4] To Bios' -ForegroundColor Yellow
            $refreshScript = Read-Host 'Enter Option: '
            Clear-Host
            switch ($refreshScript) {
                1 {
                    Invoke-WebRequest -Uri "$($github)2%20Refresh/3%20Reinstall.ps1" -UseBasicParsing | Invoke-Expression
                }
                2 {
                    Invoke-WebRequest -Uri "$($github)2%20Refresh/4%20Autounattend.ps1" -UseBasicParsing | Invoke-Expression
                }
                3 {
                    Invoke-WebRequest -Uri "$($github)2%20Refresh/5%20Network%20Driver.ps1" -UseBasicParsing | Invoke-Expression
                }
                4 {
                    Invoke-WebRequest -Uri "$($github)2%20Refresh/6%20To%20Bios.ps1" -UseBasicParsing | Invoke-Expression
                }
                default {
                    #do nothing
                }
            }
        }
        3 {
            $setupScript = $null
            Write-Host 'Choose a Script to Run [Press ENTER to Go Back]:'
            Write-Host '[1] Activation Home to Pro' -ForegroundColor Yellow
            Write-Host '[2] Edge Updates' -ForegroundColor Yellow
            Write-Host '[3] Background Apps' -ForegroundColor Yellow
            $setupScript = Read-Host 'Enter Option: '
            Clear-Host
            switch ($setupScript) {
                1 {
                    Invoke-WebRequest -Uri "$($github)3%20Setup/1%20Activation%20Home%20To%20Pro.ps1" -UseBasicParsing | Invoke-Expression
                }
                2 {
                    Invoke-WebRequest -Uri "$($github)3%20Setup/10%20Edge%20Updates.ps1" -UseBasicParsing | Invoke-Expression
                }
                3 {
                    Invoke-WebRequest -Uri "$($github)3%20Setup/9%20Backround%20Apps.ps1" -UseBasicParsing | Invoke-Expression
                }
                default {
                    #do nothing
                }
            }
        }
        4 {
            $installerScript = $null
            Write-Host 'Choose a Script to Run [Press ENTER to Go Back]:'
            Write-Host '[1] Installers' -ForegroundColor Yellow
            Write-Host '[2] Spotify' -ForegroundColor Yellow
            Write-Host '[3] MSI Afterburner' -ForegroundColor Yellow
            $installerScript = Read-Host 'Enter Option: '
            Clear-Host
            switch ($installerScript) {
                1 {
                    Invoke-WebRequest -Uri "$($github)4%20Installers/1%20Installers.ps1" -UseBasicParsing | Invoke-Expression
                }
                2 {
                    Invoke-WebRequest -Uri "$($github)4%20Installers/2%20Spotify.ps1" -UseBasicParsing | Invoke-Expression
                }
                3 {
                    Invoke-WebRequest -Uri "$($github)4%20Installers/3%20MSI%20Afterburner.ps1" -UseBasicParsing | Invoke-Expression
                }
                default {
                    #do nothing
                }
            }
        }
        5 {
            $graphicsScript = $null
            Write-Host 'Choose a Script to Run [Press ENTER to Go Back]:'
            Write-Host '[1] Clean Driver' -ForegroundColor Yellow
            Write-Host '[2] Direct X' -ForegroundColor Yellow
            Write-Host '[3] C++' -ForegroundColor Yellow
            Write-Host '[4] Amd Driver' -ForegroundColor Yellow
            Write-Host '[5] Amd Settings' -ForegroundColor Yellow
            Write-Host '[6] Nvidia Driver' -ForegroundColor Yellow
            Write-Host '[7] Nvidia Settings' -ForegroundColor Yellow
            Write-Host '[8] Msi Mode' -ForegroundColor Yellow
            $graphicsScript = Read-Host 'Enter Option: '
            Clear-Host
            switch ($graphicsScript) {
                1 { 
                    Invoke-WebRequest -Uri "$($github)5%20Graphics/1%20Clean%20Driver.ps1" -UseBasicParsing | Invoke-Expression 
                }
                2 {
                    Invoke-WebRequest -Uri "$($github)5%20Graphics/10%20Direct%20X.ps1" -UseBasicParsing | Invoke-Expression
                }
                3 {
                    Invoke-WebRequest -Uri "$($github)5%20Graphics/11%20C%2B%2B.ps1" -UseBasicParsing | Invoke-Expression
                }
                4 {
                    Invoke-WebRequest -Uri "$($github)5%20Graphics/2%20Amd%20Driver.ps1" -UseBasicParsing | Invoke-Expression
                }
                5 {
                    Invoke-WebRequest -Uri "$($github)5%20Graphics/3%20Amd%20Settings.ps1" -UseBasicParsing | Invoke-Expression
                }
                6 {
                    Invoke-WebRequest -Uri "$($github)5%20Graphics/4%20Nvidia%20Driver.ps1" -UseBasicParsing | Invoke-Expression
                }
                7 {
                    Invoke-WebRequest -Uri "$($github)5%20Graphics/5%20Nvidia%20Settings.ps1" -UseBasicParsing | Invoke-Expression
                }
                8 {
                    Invoke-WebRequest -Uri "$($github)5%20Graphics/9%20Msi%20Mode.ps1" -UseBasicParsing | Invoke-Expression
                }
                default {
                    #do nothing
                }
            }
        }
        6 {
            $windowsScript = $null
            Write-Host 'Choose a Script to Run [Press ENTER to Go Back]:'
            Write-Host '[1] Start Menu Taskbar' -ForegroundColor Yellow
            Write-Host '[2] Timer Resolution' -ForegroundColor Yellow
            Write-Host '[3] Registry' -ForegroundColor Yellow
            Write-Host '[4] Signout Lockscreen' -ForegroundColor Yellow
            Write-Host '[5] Edge' -ForegroundColor Yellow
            Write-Host '[6] Bloatware' -ForegroundColor Yellow
            Write-Host '[7] Start Menu Shortcuts' -ForegroundColor Yellow
            Write-Host '[8] Autoruns' -ForegroundColor Yellow
            Write-Host '[9] Cleanup' -ForegroundColor Yellow
            Write-Host '[10] Copilot' -ForegroundColor Yellow
            Write-Host '[11] Widgets' -ForegroundColor Yellow
            Write-Host '[12] Gamebar' -ForegroundColor Yellow
            Write-Host '[13] Power Plan' -ForegroundColor Yellow
            $windowsScript = Read-Host 'Enter Option: '
            Clear-Host
            switch ($windowsScript) {
                1 { 
                    Invoke-WebRequest -Uri "$($github)6%20Windows/1%20Start%20Menu%20Taskbar.ps1" -UseBasicParsing | Invoke-Expression 
                }
                2 {
                    Invoke-WebRequest -Uri "$($github)6%20Windows/10%20Timer%20Resolution.ps1" -UseBasicParsing | Invoke-Expression
                }
                3 {
                    Invoke-WebRequest -Uri "$($github)6%20Windows/12%20Registry.ps1" -UseBasicParsing | Invoke-Expression
                }
                4 {
                    Invoke-WebRequest -Uri "$($github)6%20Windows/13%20Signout%20Lockscreen.ps1" -UseBasicParsing | Invoke-Expression
                }
                5 {
                    Invoke-WebRequest -Uri "$($github)6%20Windows/14%20Edge.ps1" -UseBasicParsing | Invoke-Expression
                }
                6 {
                    Invoke-WebRequest -Uri "$($github)6%20Windows/15%20Bloatware.ps1" -UseBasicParsing | Invoke-Expression
                }
                7 {
                    Invoke-WebRequest -Uri "$($github)6%20Windows/2%20Start%20Menu%20Shortcuts.ps1" -UseBasicParsing | Invoke-Expression
                }
                8 {
                    Invoke-WebRequest -Uri "$($github)6%20Windows/21%20Autoruns.ps1" -UseBasicParsing | Invoke-Expression
                }
                9 {
                    Invoke-WebRequest -Uri "$($github)6%20Windows/22%20Cleanup.ps1" -UseBasicParsing | Invoke-Expression
                }
                10 {
                    Invoke-WebRequest -Uri "$($github)6%20Windows/3%20Copilot.ps1" -UseBasicParsing | Invoke-Expression
                }
                11 {
                    Invoke-WebRequest -Uri "$($github)6%20Windows/4%20Widgets.ps1" -UseBasicParsing | Invoke-Expression  
                }
                12 {
                    Invoke-WebRequest -Uri "$($github)6%20Windows/6%20Gamebar.ps1" -UseBasicParsing | Invoke-Expression 
                }
                13 {
                    Invoke-WebRequest -Uri "$($github)6%20Windows/9%20Power%20Plan.ps1" -UseBasicParsing | Invoke-Expression 
                }
                default {
                    #do nothing
                }
            }
        }
        7 {
            $hardwareScript = $null
            Write-Host 'Choose a Script to Run [Press ENTER to Go Back]:'
            Write-Host '[1] Mouse Optimization' -ForegroundColor Yellow
            Write-Host '[2] Controller Overclock' -ForegroundColor Yellow
            Write-Host '[3] Controller Polling Rate' -ForegroundColor Yellow
            Write-Host '[4] Monitor Optimization' -ForegroundColor Yellow
            $hardwareScript = Read-Host 'Enter Option: '
            Clear-Host
            switch ($hardwareScript) {
                1 {
                    Invoke-WebRequest -Uri "$($github)7%20Hardware/1%20Mouse%20Optimization.ps1" -UseBasicParsing | Invoke-Expression
                }
                2 {
                    Invoke-WebRequest -Uri "$($github)7%20Hardware/4%20Controller%20Overclock.ps1" -UseBasicParsing | Invoke-Expression
                }
                3 {
                    Invoke-WebRequest -Uri "$($github)7%20Hardware/5%20Controller%20Polling%20Rate.ps1" -UseBasicParsing | Invoke-Expression
                }
                4 {
                    Invoke-WebRequest -Uri "$($github)7%20Hardware/7%20Monitor%20Optimization.ps1" -UseBasicParsing | Invoke-Expression
                }
                default {
                    #do nothing
                }
            }
        }
        8 {
            $advancedScript = $null
            Write-Host 'Choose a Script to Run [Press ENTER to Go Back]:'
            Write-Host '[1] Network Adapter' -ForegroundColor Yellow
            Write-Host '[2] Start Search Shell' -ForegroundColor Yellow
            Write-Host '[3] Hdcp' -ForegroundColor Yellow
            Write-Host '[4] P0 State' -ForegroundColor Yellow
            Write-Host '[5] Mpo' -ForegroundColor Yellow
            Write-Host '[6] FSO FSE' -ForegroundColor Yellow
            Write-Host '[7] Keyboard Shortcuts' -ForegroundColor Yellow
            Write-Host '[8] Security' -ForegroundColor Yellow
            Write-Host '[9] Updates' -ForegroundColor Yellow
            Write-Host '[10] Services' -ForegroundColor Yellow
            $advancedScript = Read-Host 'Enter Option: '
            Clear-Host
            switch ($advancedScript) {
                1 { 
                    Invoke-WebRequest -Uri "$($github)8%20Advanced/1%20Network%20Adapter.ps1" -UseBasicParsing | Invoke-Expression 
                }
                2 {
                    Invoke-WebRequest -Uri "$($github)8%20Advanced/10%20Start%20Search%20Shell.ps1" -UseBasicParsing | Invoke-Expression
                }
                3 {
                    Invoke-WebRequest -Uri "$($github)8%20Advanced/2%20Hdcp.ps1" -UseBasicParsing | Invoke-Expression
                }
                4 {
                    Invoke-WebRequest -Uri "$($github)8%20Advanced/3%20Po%20State.ps1" -UseBasicParsing | Invoke-Expression
                }
                5 {
                    Invoke-WebRequest -Uri "$($github)8%20Advanced/4%20Mpo.ps1" -UseBasicParsing | Invoke-Expression
                }
                6 {
                    Invoke-WebRequest -Uri "$($github)8%20Advanced/5%20Fso%20Fse.ps1" -UseBasicParsing | Invoke-Expression
                }
                7 {
                    Invoke-WebRequest -Uri "$($github)8%20Advanced/6%20Keyboard%20Shortcuts.ps1" -UseBasicParsing | Invoke-Expression
                }
                8 {
                    Invoke-WebRequest -Uri "$($github)8%20Advanced/7%20Security.ps1" -UseBasicParsing | Invoke-Expression
                }
                9 {
                    Invoke-WebRequest -Uri "$($github)8%20Advanced/8%20Updates.ps1" -UseBasicParsing | Invoke-Expression
                }
                10 {
                    Invoke-WebRequest -Uri "$($github)8%20Advanced/9%20Services.ps1" -UseBasicParsing | Invoke-Expression
                }
                default {
                    #do nothing
                }
            }
        }
    }
}while ($choice -ne 9) {}