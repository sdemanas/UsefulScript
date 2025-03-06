# FindStrings is a powershell script to find a unique string

# Searches for the InputString recursively in files stored in current parent & sub directories 

# String Input
$InputString = Read-Host 'Input the string to search'

# Recursively list all files recursively where "InputString" is found 
Get-ChildItem -Path . -Recurse -File | 

# Use regex to strictly search for InputString 
# Select-String -Pattern "\b$InputString\b" 
Select-String -Pattern $InputString |

# keep only unique file paths in the result.
Select-Object -Unique Path