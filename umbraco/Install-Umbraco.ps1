Write-Host 'Downloading url rewrite.'
Invoke-WebRequest `
    -Uri 'http://download.microsoft.com/download/C/9/E/C9E8180D-4E51-40A6-A9BF-776990D8BCA9/rewrite_amd64.msi' `
    -OutFile c:/urlrewrite2.msi
Write-Host 'Installing url rewrite'
Start-Process 'c:/urlrewrite2.msi' '/qn' -PassThru | Wait-Process

Write-Host 'Downloading Umbraco'
Invoke-WebRequest `
    -Uri "http://umbracoreleases.blob.core.windows.net/download/UmbracoCms.$($env:UmbracoVersion).zip" `
    -OutFile $env:TEMP/umbraco.zip
Write-Host 'Extracting Umbraco'
Expand-Archive -Path $env:TEMP/umbraco.zip -DestinationPath /inetpub/wwwroot

Install-Module ntfssecurity -Force
Add-NTFSAccess -Path C:\inetpub\wwwroot\ -Account BUILTIN\IIS_IUSRS -AccessRights FullControl
Add-NTFSAccess -Path C:\inetpub\wwwroot\web.config -Account BUILTIN\IIS_IUSRS -AccessRights FullControl