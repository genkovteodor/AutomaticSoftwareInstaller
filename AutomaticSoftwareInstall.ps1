#Set-ExecutionPolicy -Scope CurrentUser RemoteSigned


# Get the path of the script's folder
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

Set-Location -Path $scriptPath

Write-Host $script

# Define the name of the MSI file
$msiFileNames = @(
                "MullvadVPN-2023.4.exe"

)

foreach ($msiFileName in $msiFileNames) {

    $fileExtension = (Get-Item $msiFileName).Extension
    # Construct the full path to the MSI file
    $msiFilePath = Join-Path -Path $scriptPath -ChildPath $msiFileName

    #do msi installation branch
    if($fileExtension -eq ".msi"){
        # Check if the MSI file exists
        if (Test-Path -Path $msiFilePath -PathType Leaf) {
            # Install the MSI silently
            $logFilePath = Join-Path -Path $scriptPath -ChildPath "InstallLog.txt"
            Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$msiFilePath`" /qn /log `"$logFilePath`"" -Wait
            Write-Host "Installation completed."
        } else {
            Write-Host "MSI file not found: $msiFilePath"
        }
    } elseif($fileExtension -eq ".exe"){
        Write-Host $msiFileName
        if($msiFileName -like "*Mullvad*") {
            Write-Host "Installing $msiFileName..."
            Start-Process -FilePath $msiFileName -ArgumentList "/allusers /S" -Wait
            Write-Host "$msiFileName successfully executed"
        }
    } else {
        Write-Host "$msiFileName is not a valid file"
    }

}


#Keeps PowerShell Terminal Open
Read-Host -Prompt "Press Enter to Exit"




