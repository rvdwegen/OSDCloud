$ProgressPreference = 'SilentlyContinue'
$host.ui.RawUI.WindowTitle = "Post OOBE Bootstrap"

try {
    # Change execution policy
    if ((Get-ExecutionPolicy) -ne "Unrestricted") {
           Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force -Confirm:$false
           Write-Host "adfdasdasdasdasdsd"
           Write-Host "Executionpolicy has been changed to unrestricted for this process" -ForegroundColor Green
    }

    [uri]$url = "https://github.com/mgajda83/PSWindowsUpdate/archive/refs/heads/main.zip"
    Invoke-RestMethod -Uri $url.AbsoluteUri -OutFile "$env:TEMP\$($url.Segments[2].Trim('/')).zip"
    Expand-Archive -Path "$env:TEMP\$($url.Segments[2].Trim('/')).zip" -DestinationPath "$env:PROGRAMFILES\WindowsPowerShell\Modules\$($url.Segments[2].Trim('/'))" -Force
    Import-Module -Name PSWindowsUpdate
    #"$env:TEMP\lol098\PSWindowsUpdate-main\PSWindowsUpdate\*" | Get-ChildItem -include '*.psm1','*.ps1' | Import-Module

#     # Install PackageProvider NuGet
#     try {
#            if (!(Get-PackageProvider | Where-Object { $_.Name -eq "NuGet" })) {
#                   Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Confirm:$FALSE | Out-Null
#            }
#     } catch {
#            throw "Failed to find/install NuGet: $($_.Exception.Message)"
#     }

#     # Check & Install requisite modules
#     $installedModules = Get-InstalledModule
#     Write-Host "Checking modules..."
#     @('PSWindowsUpdate') | ForEach-Object {
#            try {
#                   if ($installedModules.Name -notcontains $($_)) {
#                          Install-Module -Name $($_) -Scope AllUsers -Force -Confirm:$FALSE
#                          Write-Host "Module $($_) has been installed" -ForegroundColor Green
#                   } else {
#                          Write-Host "Module $($_) has been found" -ForegroundColor Green
#                   }
#            } catch {
#                   throw "Failed to install/find module $($_): $($_.Exception.Message)"
#            }
#     }
} catch {
    throw "$($_.Exception.Message)"
}

# try {
#     $serialNumber = (Get-WmiObject Win32_bios).SerialNumber
#     if ($env:COMPUTERNAME -ne $serialNumber) {
#         $serialNumber | Rename-Computer
#     }
# } catch {
#    throw "$($_.Exception.Message)"
# }

try {
    Write-Host "ATTEMPTING TO INSTALL ALL WINDOWS UPDATES" -ForegroundColor DarkYellow
    Write-Host "THIS MAY TAKE A WHILE..." -ForegroundColor DarkYellow
    #Get-WindowsUpdate -Install -AcceptAll -AutoReboot -RecurseCycle 3 -Confirm:$false
    Get-WindowsUpdate -Install -AcceptAll -Confirm:$false
    #Install-WindowsUpdate -UpdateType Driver -AcceptAll -IgnoreReboot

    if ((Get-WURebootStatus).RebootRequired -eq $true) {
        # Schedule a one time start of get-windowsupdate after reboot
        Write-Host "Reboot logic here"
    } else {
        Write-Host "UPDATES COMPLETED, WINDOWS SHOULD BE FULLY UP TO DATE" -ForegroundColor Green
    }
} catch {
    throw "$($_.Exception.Message)"
}
