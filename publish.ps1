$FilesToBePublished = Get-ChildItem -Path "$PSScriptRoot\PSMetrolink" -File | Select-Object -ExpandProperty "Name"
Write-Verbose -Message "Files to be included in release: $($FilesToBePublished -join ', ')"

$PublishSplat = @{
    Path        = "$PSScriptRoot\PSMetrolink"
    Repository  = "PSGallery"
    NuGetApiKey = $ENV:NuGetApiKey
    Force       = $True
    Verbose     = $True
    ErrorAction = "Stop"
}

Publish-Module @PublishSplat