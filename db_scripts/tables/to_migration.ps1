$scriptDirectory = Split-Path $MyInvocation.MyCommand.Definition -Parent 

$outputFile = Join-Path -Path $scriptDirectory -ChildPath "migration.sql"

if (Test-Path $outputFile) {
    Remove-Item $outputFile
}
$sqlFiles = Get-ChildItem -Path $scriptDirectory -Filter *.sql -File | Sort-Object Name 

foreach($file in $sqlFiles){
    Get-Content $file.FullName | Out-File -Append -FilePath $outputFile
    "GO" | Out-File -Append -FilePath $outputFile
}

Write-Host "Todos os arquivos foram combinados $outputFile"
