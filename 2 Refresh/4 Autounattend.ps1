    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
    {Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit}
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
    $Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
    $Host.PrivateData.ProgressForegroundColor = "White"
    Clear-Host

# save autounattend config
$MultilineComment = @"
<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
    <settings pass="oobeSystem">
        <component name="Microsoft-Windows-International-Core" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS"
            xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <InputLocale>{LANG}</InputLocale>
            <SystemLocale>{LANG}</SystemLocale>
            <UILanguage>{LANG}</UILanguage>
            <UILanguageFallback>{LANG}</UILanguageFallback>
            <UserLocale>{LANG}</UserLocale>
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
                        <Name>{USERNAME}</Name>
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
                    <Path>net user {USERNAME} /active:Yes</Path>
                    <WillReboot>Never</WillReboot>
                </RunSynchronousCommand>
                <RunSynchronousCommand wcm:action="add">
                    <Order>3</Order>
                    <Path>net user {USERNAME} /passwordreq:no</Path>
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
            <InputLocale>{LANG}</InputLocale>
            <SystemLocale>{LANG}</SystemLocale>
            <UILanguage>{LANG}</UILanguage>
            <UILanguageFallback>{LANG}</UILanguageFallback>
            <UserLocale>{LANG}</UserLocale>
            <SetupUILanguage>
                <UILanguage>{LANG}</UILanguage>
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
# Save the XML template to a temporary file
$path = "$env:TEMP\autounattend.xml"
Set-Content -Path $path -Value $MultilineComment -Force

# Input user for account name
$username = Read-Host -Prompt "Enter Account Name"

# Input user for language selection
Clear-Host
$languageOptions = @("fr-FR", "en-US", "es-ES", "de-DE", "it-IT", "ja-JP", "ko-KR", "pt-BR", "ru-RU", "zh-CN")
$languagePrompt = "Please choose the language of the installed Windows operating system using the corresponding index:`n"
for ($i = 0; $i -lt $languageOptions.Count; $i++) {
    $languagePrompt += "$($i + 1). $($languageOptions[$i])`n"
}
$language = Read-Host -Prompt $languagePrompt

# Verify if the language selected is right in the list
while ($language -notin 1..$languageOptions.Count) {
    Write-Host "Invalid choice. Please enter a valid number corresponding to the desired language."
    $language = Read-Host -Prompt $languagePrompt
}
$selectedLanguage = $languageOptions[$language - 1]

# Input user to choose if he/she wants a password
Clear-Host
$setPassword = Read-Host -Prompt "Do you want to set a password? (Y/N)"

# Check if he/she wants a password
while ($setPassword -ne "Y" -and $setPassword -ne "N") {
    Write-Host "Invalid choice. Please enter 'Y' for Yes or 'N' for No."
    $setPassword = Read-Host -Prompt "Do you want to set a password? (Y/N)"
}

if ($setPassword -eq "Y") {
    $password = Read-Host -Prompt "Enter the password"
    # Replace the placeholder with the entered password in the XML
    (Get-Content $path) -replace "<Value></Value>", "<Value>$password</Value>" | Set-Content -Path $path -Force
}


# Replace placeholders in the XML template with user inputs
(Get-Content $path) -replace "{USERNAME}", $username -replace "{LANG}", $selectedLanguage | Set-Content -Path $path -Force

# Convert file to utf8
Get-Content "$env:TEMP\autounattend.xml" | Set-Content -Encoding utf8 "$env:C:\Windows\Temp\autounattend.xml" -Force

# Delete the old autounattend file
Remove-Item -Path $path -Force | Out-Null

# User input move autounattend to USB
Clear-Host
$file = "$env:C:\Windows\Temp\autounattend.xml"
$destination = Read-Host -prompt "Enter USB Drive Letter" 
$destination += ":\"
Move-Item -Path $file -Destination $destination -Force

# Open USB directory to confirm
Start-Process $destination