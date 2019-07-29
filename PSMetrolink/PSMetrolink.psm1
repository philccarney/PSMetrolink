function Get-Metrolink
{
    <#
    .SYNOPSIS
        Retrieves live data from the Geater Manchester Metrolink system using the TFGM/Metrolink API.
    .DESCRIPTION
        Uses 'Invoke-RestMethod' and the TFGM/Metrolink API to return live data from the Greater Manchester Metrolink system.
    .PARAMETER Key
        The API subscription key used to make the query.
    .PARAMETER Station
        If used, the query will only retrieve data for the specified station.
    .PARAMETER Uri
        Specifies the URI to make the API call to. This is provided as a failsafe in case the included value becomes incorrect.
    .EXAMPLE
        $Key = 1234567890asdfghjkl
        Get-Metrolink -Key $SubscriptionKey -Station "Radcliffe"

        Destination : Bury
        Wait        : 6
        Carriages   : Double
        Status      : Due
        Line        : Bury
        Station     : Radcliffe

        Destination : Bury
        Wait        : 19
        Carriages   : Double
        Status      : Due
        Line        : Bury
        Station     : Radcliffe

        Destination : Piccadilly
        Wait        : 9
        Carriages   : Double
        Status      : Due
        Line        : Bury
        Station     : Radcliffe

        Destination : Piccadilly
        Wait        : 21
        Carriages   : Double
        Status      : Due
        Line        : Bury
        Station     : Radcliffe
    .INPUTS
        String(s)
    .OUTPUTS
        PSCustomObject
    .NOTES
        This cmdlet requires a subscription key to the Open Data Service Version 2.0 API provided by TFGM.
    .LINK
        https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/invoke-restmethod
        https://developer.tfgm.com/
        https://developer.tfgm.com/docs/services
    #>
    [CmdletBinding(ConfirmImpact = 'Low', SupportsShouldProcess = $True)]
    [Alias("Get-Tram", "Get-Met")]
    [OutputType([PSCustomObject])]
    param
    (
        [Parameter(Mandatory = $True, Position = 0, ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True, HelpMessage = "The API key used for the query")]
        [string] $Key,

        [Parameter(Mandatory = $False, Position = 1, HelpMessage = "A specific Metrolink station")]
        [ValidateSet(
            "Abraham Moss", "Altrincham", "Anchorage", "Ashton Moss", "Ashton West", "Ashton-Under-Lyne", "Audenshaw", "Baguley", "Barlow Moor Road", "Benchill", "Besses O’ Th’ Barn", "Bowker Vale", "Broadway",
            "Brooklands", "Burton Road", "Bury", "Cemetery Road", "Central Park", "Chorlton", "Clayton Hall", "Cornbrook", "Crossacres", "Crumpsall", "Dane Road", "Deansgate - Castlefield", "Derker", "Didsbury Village",
            "Droylsden", "East Didsbury", "Eccles", "Edge Lane", "Etihad Campus", "Exchange Quay", "Exchange Square", "Failsworth", "Firswood", "Freehold", "Harbour City", "Heaton Park", "Hollinwood", "Holt Town",
            "Kingsway Business Park", "Ladywell", "Langworthy", "Manchester Airport", "Market Street", "Martinscroft", "MediaCityUK", "Milnrow", "Monsall", "Moor Road", "Navigation Road", "New Islington", "Newbold",
            "Newhey", "Newton Heath and Moston", "Northern Moor", "Old Trafford", "Oldham Central", "Oldham King Street", "Oldham Mumps", "Peel Hall", "Piccadilly", "Piccadilly Gardens", "Pomona", "Prestwich", "Queens Road",
            "Radcliffe", "Robinswood Road", "Rochdale Railway Station", "Rochdale Town Centre", "Roundthorn", "Sale", "Sale Water Park", "Salford Quays", "Shadowmoss", "Shaw and Crompton", "Shudehill", "South Chadderton",
            "St Peter's Square", "St Werburgh's Road", "Stretford", "Timperley", "Trafford Bar", "Velopark", "Victoria", "Weaste", "West Didsbury", "Westwood", "Whitefield", "Withington", "Wythenshawe Park", "Wythenshawe Town Centre"
        )]
        #[ValidateSet("test_me")]
        [string] $Station,

        [Parameter(Mandatory = $False, Position = 2, HelpMessage = "The API uri")]
        [string] $Uri = "https://api.tfgm.com/odata/Metrolinks"
    )

    if ($PSBoundParameters.ContainsKey("Debug"))
    {
        $DebugPreference = "Continue"
    }

    if ($PSCmdlet.ShouldProcess($Uri, "Query API"))
    {
        try
        {
            Write-Verbose -Message "Defining query parameters."
            $QueryParams = @{
                Uri         = $Uri
                Method      = "Get"
                Headers     = @{ "Ocp-Apim-Subscription-Key" = $Key }
                ErrorAction = "Stop"
            }

            Write-Verbose -Message "Querying API."
            $QueryResults = (Invoke-RestMethod @QueryParams).Value
        }
        catch
        {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }

    if ($PSCmdlet.ShouldProcess($Uri, "Process query results"))
    {
        try
        {
            $ProcessedResults = forEach ($WorkingResult in $QueryResults)
            {
                # Here begins the work to re-format the default object returned by the API.
                # By default you get as many as three trams/'events' per-object.
                # This should be 1:1 in my opinion.
                $i = 0
                do
                {
                    $DestToken = "Dest$i"
                    $StatusToken = "Status$i"
                    $CarriagesToken = "Carriages$i"
                    $WaitToken = "Wait$i"

                    # Some logic here to compare WorkingResult.StationLocation to the $Station value would be useful for the optional parameter.
                    if ((-not ($Station)) -or
                        (($Null -ne $Station) -and ($WorkingResult.StationLocation -match $Station)))
                    {
                        Write-Debug -Message "Passed conditional station validation: '$($WorkingResult.StationLocation)'."
                        $Tram = [PSCustomObject]@{
                            # I've been calling this a tram-stop(ping) event, because I don't know the technical name of it.
                            Destination = ( $WorkingResult.PSObject.Properties | Where-Object { ( $_.Name -match $DestToken ) -and ( $_.Value ) } ).Value
                            Wait        = ([int] ( $WorkingResult.PSObject.Properties | Where-Object { ( $_.Name -match $WaitToken ) -and ( $_.Value ) } ).Value)
                            Carriages   = ( $WorkingResult.PSObject.Properties | Where-Object { ( $_.Name -match $CarriagesToken ) -and ( $_.Value ) } ).Value
                            Status      = ( $WorkingResult.PSObject.Properties | Where-Object { ( $_.Name -match $StatusToken ) -and ( $_.Value ) } ).Value
                            Line        = ( $WorkingResult.Line)
                            Station     = ( $WorkingResult.StationLocation)
                        }

                        if (($Tram.Wait) -and ($Tram.Status))
                        {
                            # This is a valid tram-stopping event, so we can output it.
                            Write-Debug -Message "Passed basic object property validation."
                            $Tram
                        }
                        else
                        {
                            # This isn't.
                            Write-Debug -Message "Failed basic object property validation."
                        }
                    }
                    else
                    {
                        Write-Debug -Message "Failed station validation: '$($WorkingResult.StationLocation)'."
                    }

                    $i++

                } while ( ($WorkingResult.PSObject.Properties | Where-Object { ($_.Name -match $DestToken) -and ($_.Value) }) )
            }
        }
        catch
        {
            $PSCmdlet.ThrowTerminatingError($_)
        }

        if ($ProcessedResults)
        {
            Write-Verbose -Message "Outputting results."
            $ProcessedResults | Sort-Object "Line", "Station", "Destination", "Wait"
        }
        else
        {
            Write-Verbose -Message "No results found."
        }
    }
}