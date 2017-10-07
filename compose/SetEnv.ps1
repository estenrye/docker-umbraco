param(
    [Parameter(Mandatory=$true, Position=1)]
    [string]$DatabaseSaPassword,
    [Parameter(Mandatory=$true, Position=2)]
    [string]$DatabaseUserPassword
)

[System.Environment]::SetEnvironmentVariable('SA_PASSWORD', $DatabaseSaPassword, 'user')
[System.Environment]::SetEnvironmentVariable('DB_PASSWORD', $DatabaseUserPassword, 'user')
$env:SA_PASSWORD = $DatabaseSaPassword
$env:DB_PASSWORD = $DatabaseUserPassword