try {
    Start-OSDCloudGUI
    Write-Host "HERE?"
    Write-Host "HERE?"
    Write-Host "HERE?"
    Write-Host "HERE?"
} catch {
    throw "$($_.Exception.Message)"
}

try {
    Invoke-RestMethod -Uri "https://github.com/rvdwegen/OSDCloud/raw/main/PostOOBEBootstrap.exe" -OutFile "C:\OSDCloud\PostOOBEBootstrap.exe"

    $SetupCompleteData = "powershell.exe -command Start-Process -FilePath C:\OSDCloud\PostOOBEBootstrap.exe"
    Set-Content -Path "C:\Windows\Setup\Scripts\SetupComplete.cmd" -Value $SetupCompleteData -Force
} catch {
    throw "$($_.Exception.Message)"
}

Write-Host "PAUSE HERE WHY?"