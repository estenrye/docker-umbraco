function Test-SQLConnection
{    
    [OutputType([bool])]
    Param
    (
        [Parameter(Mandatory=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        $ConnectionString
    )
    try
    {
        $sqlConnection = New-Object System.Data.SqlClient.SqlConnection $ConnectionString;
        $sqlConnection.Open();
        $sqlConnection.Close();

        return $true;
    }
    catch
    {
        return $false;
    }
}

Write-Host 'Starting SQL Server for database update.'
$proc = Start-Process -passthru -FilePath C:\start -ArgumentList "-sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -attach_dbs '$env:attach_dbs' -verbose"

$connectionString = 'server=localhost;database=UmbracoDb;Trusted_Connection=true;'

$totalWaitTime = 0
$waitTimeIncrement = 1000
$maxWaitTime = 180000
while (-not (Test-SQLConnection $connectionString))
{
	if ($totalWaitTime -gt $maxWaitTime)
	{
		$exceptionMessage = "Timeout of $maxWaitTime ms has been exceeded while waiting for a connection to SQL Server.  Aborting."
		Write-Host $exceptionMessage
		Throw New-Object [System.TimeoutException]($exceptionMessage)
	}
	Write-Host "Waiting $waitTimeIncrement ms for connection to instance."
	Start-Sleep -Milliseconds $waitTimeIncrement
	$totalWaitTime += $waitTimeIncrement
}
Write-Host "Database started on process id: $($proc.Id)"
Write-Host 'Connected to instance.  Running Update Scripts'

. /Scripts/ExecuteUpdateScript.ps1

Write-Host "Stopping SQL Server on process id: $($proc.Id)"
Stop-Process $proc.Id
Write-Host 'SQL Server process stopped'

Write-Host 'Starting default entrypoint.'
C:\start -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -attach_dbs "$env:attach_dbs" -verbose