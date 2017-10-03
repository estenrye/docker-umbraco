Import-Module SqlPs -DisableNameChecking
Invoke-SqlCmd -InputFile /Scripts/Install-Login.sql
Invoke-SqlCmd -InputFile /Scripts/Install-User.sql