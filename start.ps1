$ErrorActionPreference = 'Stop'

$config = Get-Content -LiteralPath (Join-Path $PSScriptRoot 'config.json') -Raw |
    ConvertFrom-Json
if ($config.public_port -isnot [int] -or $config.public_port -lt 1 -or $config.public_port -gt 65535) {
    throw 'public_port must be an integer between 1 and 65535.'
}

$previousHost = $env:PERSONALIZE_CRM_HOST
$previousPort = $env:PERSONALIZE_CRM_PORT
try {
    $env:PERSONALIZE_CRM_HOST = $config.public_host
    $env:PERSONALIZE_CRM_PORT = [string]$config.public_port
    docker compose --project-name $config.project_name --file (Join-Path $PSScriptRoot 'pwd.yml') up -d
    if ($LASTEXITCODE -ne 0) {
        throw "Docker Compose failed with exit code $LASTEXITCODE."
    }
    Write-Output "Login: http://$($config.public_host):$($config.public_port)/login"
}
finally {
    $env:PERSONALIZE_CRM_HOST = $previousHost
    $env:PERSONALIZE_CRM_PORT = $previousPort
}
