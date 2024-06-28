<# The script currently uses a local version of ImageMagick instead of a system-wide 
installed one. A check to use the system one when the local one is not present will be added. #>

param (
    # The path of the input image to be splitted
    [string]$filePath, 
    
    # The width in pixels of the output images
    [int]$outputPhotosWidth
)

# Check if $filePath has been provided
if (-not $filePath) {
    $filePath = Read-Host "Insert the path of the input image"
}

# Check if file exists
if (-not (Test-Path $filePath)) {
    Write-Host "The file doesn't exist: $filePath."
    exit 1
}

# Check if $outputPhotosWidth has been provided
if(-not $outputPhotosWidth) {
    $outputPhotosWidth = Read-Host "Insert the output images width in pixels"
}

# Check that $outputPhotosWidth is a positive number
if($outputPhotosWidth -lt 1) {
    Write-Host "The value should be a positive number."
    exit 1
}


<# Extract the parent folder path, the file name and the extension #>
$parentFolder = Split-Path -Path $filePath # Will implement output to same folder as input
$fileName = [System.IO.Path]::GetFileNameWithoutExtension($filePath)
$fileExt = [System.IO.Path]::GetExtension($filePath)

<# The path to the magick executable (it'll be handy because we'll change directory).
Check if there's a local version of ImageMagick in the script folder. Otherwise fallback
to the system Magick executable. magick.exe must be in the user path variable for this  to work. #>
$magick = "$PSScriptRoot\ImageMagick\magick.exe"
if(-not (Test-Path $magick)) {
    $magick = "magick"
}

# Move in the directory of the input image (without this Image Magick has troubles writing the output)
Set-Location $parentFolder

<# Get the width and height of the input image #>
$getDimCommand = "$magick identify -format ""%w,%h"" $filePath"
$dimensions = Invoke-Expression $getDimCommand
$imageWidth, $imageHeight = $dimensions -split ","

# Calculate how many photos will be outputted with the output width provided by the user
$photosCount = $imageWidth / $outputPhotosWidth

# Once per every calculated output image
for($i = 0; $i -lt $photosCount; $i++) {
    Write-Host "Cutting image number $($i+1)..."
    <# Use the local copy of ImageMagick to extract a smaller image from the input image.
    The size of the output image is $outputPhotosWidth x $imageheight. 
    The starting x moves to the right every cycle by $outputPhotosWidth pixels. #>
    $splitCommand = "$magick -extract ${outputPhotosWidth}x$imageHeight+$($i*$outputPhotosWidth)+0 .\$fileName$fileExt .\${fileName}_$($i+1)$fileExt"
    Invoke-Expression $splitCommand
}

Write-Host "Splitting completed."
