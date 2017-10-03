Invoke-WebRequest 'http://download.microsoft.com/download/C/9/E/C9E8180D-4E51-40A6-A9BF-776990D8BCA9/rewrite_amd64.msi' -OutFile c:/urlrewrite2.msi
Start-Process 'c:/urlrewrite2.msi' '/qn' -PassThru | Wait-Process

Invoke-WebRequest 'https://our.umbraco.org/ReleaseDownload?id=271908' -OutFile $env:TEMP/umbraco.zip
Expand-Archive $env:TEMP/umbraco.zip /inetpub/wwwroot
