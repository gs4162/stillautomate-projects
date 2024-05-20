# User configurable parameters
$cameraName = "Canon EOS M200"  # Set your camera name here
$baseFolderName = "CameraAutoImport"  # Base folder name, can be changed as needed

# Compute paths
$userPicturesPath = "C:\Users\$env:USERNAME\Pictures"
$finalLocation = Join-Path $userPicturesPath "$baseFolderName\Complete"  # Final location for files
$destinationPath = Join-Path $userPicturesPath $baseFolderName  # Destination path for the base folder
$transferPath = Join-Path $destinationPath "Transfer"  # Path for the Transfer folder

# Initialize Shell Application object
$shell = New-Object -ComObject Shell.Application

# Ensure base, transfer, and final directories exist
if (-Not (Test-Path $destinationPath)) {
    New-Item -Path $destinationPath -ItemType Directory -Force
}
if (-Not (Test-Path $transferPath)) {
    New-Item -Path $transferPath -ItemType Directory -Force
}
if (-Not (Test-Path $finalLocation)) {
    New-Item -Path $finalLocation -ItemType Directory -Force
}

# Access the 'This PC' namespace which usually has the index 0x11
$folder = $shell.NameSpace(0x11)

# Find the camera based on the name
$cameraItem = $folder.Items() | Where-Object { $_.Name -eq $cameraName }

if ($cameraItem -eq $null) {
    Write-Output "Camera not detected."
    exit
}

# Attempt to navigate to the SD folder directly if possible
$sdFolder = $cameraItem.GetFolder.Items() | Where-Object { $_.Name -eq "SD" }

if ($sdFolder -eq $null) {
    Write-Output "SD folder not found within the camera storage."
    exit
}

# Ensure we are dealing with a folder object and try to access Items directly
try {
    $items = $sdFolder.GetFolder.Items()
} catch {
    Write-Output "Failed to retrieve items from SD folder."
    exit
}

# Get the destination folder object using its path
$destinationFolder = $shell.NameSpace($transferPath)

if ($destinationFolder) {
    foreach ($item in $items) {
        # Copy each item to the destination folder without confirmation dialog
        $destinationFolder.CopyHere($item, 16)
    }
    Write-Output "Copying contents to $transferPath..."
} else {
    Write-Output "Failed to access the destination directory."
}

# File extensions to include
$photoExtensions = @('.jpg', '.jpeg', '.png', '.gif', '.bmp')
$videoExtensions = @('.mp4', '.mov', '.avi', '.wmv')

# Recursive function to move files from nested directories
function Move-Files {
    param (
        [string]$sourcePath
    )
    $items = Get-ChildItem -Path $sourcePath -Recurse

    foreach ($item in $items) {
        if ($item -is [System.IO.FileInfo] -and $item.Extension -in $photoExtensions + $videoExtensions) {
            $targetPath = Join-Path $finalLocation $item.Name
            if (-Not (Test-Path $targetPath)) {
                Move-Item -Path $item.FullName -Destination $finalLocation
            } else {
                Write-Output "Skipping duplicate file: $($item.Name)"
            }
        }
    }
}

# Call the function for the Transfer directory
Move-Files -sourcePath $transferPath

# Empty the Transfer folder of all files and directories
$transferItems = Get-ChildItem -Path $transferPath -Recurse
foreach ($item in $transferItems) {
    Remove-Item -Path $item.FullName -Force -Recurse
}

Write-Output "Transfer complete. Photos and videos moved to $finalLocation. Transfer directory is now empty."
