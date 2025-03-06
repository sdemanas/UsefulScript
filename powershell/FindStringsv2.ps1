# FindStringsv2 is a powershell script to find a string in a list of directories

# Searches for the InputString recursively in a list of dirs and their subdirs

# directories.txt and script file in the same directory 
$directoriesFile = "$PSScriptRoot\directories.txt"

# String Input
$InputString = Read-Host 'Input the string to search'

# Read all directories from the text file
$directories = Get-Content $directoriesFile

# Check if the file exists
if (-Not (Test-Path $directoriesFile)) {
    Write-Output "Error: directories.txt not found in the script directory."
    exit
}

$directories = Get-Content $directoriesFile  # Read directories from file
$totalFilesSearched = 0
$totalFilesMatched = 0

# Loop through each directory and search for the input string
foreach ($directory in $directories) {

    if(-Not (Test-Path $directory)) {
        Write-Output "Directory not found: $directory"
        continue
    }

    Write-Output "Searching in: $directory"
    # Get all files in the directory
    $files = Get-ChildItem -Path $directory -Recurse -File  
    
    $filesSearched = $files.Count
    $totalFilesSearched += $filesSearched
    $filesMatched = 0

    foreach ($file in $files) {
        $match = Select-String -Path $file.FullName -Pattern $InputString
        if ($match) {
            Write-Output "Match found in: $file.FullName"
            $filesMatched++
        }
    }

    $totalFilesMatched += $filesMatched

    Write-Output "---------------------------------------------------"
    Write-Output "Files searched in $($directory): $($filesSearched)"
    Write-Output "Files with matches in $($directory): $($filesMatched)"
}
