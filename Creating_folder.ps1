$foldername = read-host -promt 'input folder-name'

if(Get-ChildItem -Path $foldername -Force -ErrorAction SilentlyContinue)
{
    Write-host "Folder already exists"
}
else {
    new-item "C:\Users\Alexa\OneDrive\Dokumenter\ARM-templates\$foldername" -type Directory
    Write-host "Created folder" @foldername
    
}

