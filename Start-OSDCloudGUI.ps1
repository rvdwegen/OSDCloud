try {
    Start-OSDCloudGUI
} catch {
    throw "$($_.Exception.Message)"
}

try {
    Invoke-RestMethod -Uri "https://github.com/rvdwegen/OSDCloud/raw/main/ShiftF10.exe" -OutFile "C:\OSDCloud\ShiftF10.exe"

    $SetupCompleteData = "powershell.exe -command Start-Process -FilePath C:\OSDCloud\ShiftF10.exe"
    Set-Content -Path "C:\Windows\Setup\Scripts\SetupComplete.cmd" -Value $SetupCompleteData -Force
} catch {
    throw "$($_.Exception.Message)"
}

Write-Host "PAUSE HERE WHY?"
Pause