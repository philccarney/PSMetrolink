if (Get-Module -Name "PSMetrolink" -ErrorAction "SilentlyContinue")
{
    Remove-Module -Name "PSMetrolink"
}

Import-Module (Join-Path -Path (Split-Path "C:\Development\Public\PSMetrolink\Tests\") -ChildPath "PSMetrolink" -AdditionalChildPath "PSMetrolink.psd1") -ErrorAction "Stop"
InModuleScope -ModuleName "PSMetrolink" {

    Describe "Unit tests for 'Get-Metrolink'" -Tags "Build" {

        Context "Input" {

            Context "Passing parameter validation" -Tag "ExpectedPass" {

                BeforeAll {

                    Mock Invoke-RestMethod -ModuleName "PSMetrolink" -MockWith {

                        $True
                    }

                    $Stations = @(
                        @{
                            StationName = "Abraham Moss"
                        }

                        @{
                            StationName = "Altrincham"
                        }

                        @{
                            StationName = "Anchorage"
                        }

                        @{
                            StationName = "Ashton Moss"
                        }

                        @{
                            StationName = "Ashton West"
                        }

                        @{
                            StationName = "Ashton-Under-Lyne"
                        }

                        @{
                            StationName = "Audenshaw"
                        }

                        @{
                            StationName = "Baguley"
                        }

                        @{
                            StationName = "Barlow Moor Road"
                        }

                        @{
                            StationName = "Benchill"
                        }

                        @{
                            StationName = "Besses O’ Th’ Barn"
                        }

                        @{
                            StationName = "Bowker Vale"
                        }

                        @{
                            StationName = "Broadway"
                        }

                        @{
                            StationName = "Brooklands"
                        }

                        @{
                            StationName = "Burton Road"
                        }

                        @{
                            StationName = "Bury"
                        }

                        @{
                            StationName = "Cemetery Road"
                        }

                        @{
                            StationName = "Central Park"
                        }

                        @{
                            StationName = "Chorlton"
                        }

                        @{
                            StationName = "Clayton Hall"
                        }

                        @{
                            StationName = "Cornbrook"
                        }

                        @{
                            StationName = "Crossacres"
                        }

                        @{
                            StationName = "Crumpsall"
                        }

                        @{
                            StationName = "Dane Road"
                        }

                        @{
                            StationName = "Deansgate - Castlefield"
                        }

                        @{
                            StationName = "Derker"
                        }

                        @{
                            StationName = "Didsbury Village"
                        }

                        @{
                            StationName = "Droylsden"
                        }

                        @{
                            StationName = "East Didsbury"
                        }

                        @{
                            StationName = "Eccles"
                        }

                        @{
                            StationName = "Edge Lane"
                        }

                        @{
                            StationName = "Etihad Campus"
                        }

                        @{
                            StationName = "Exchange Quay"
                        }

                        @{
                            StationName = "Exchange Square"
                        }

                        @{
                            StationName = "Failsworth"
                        }

                        @{
                            StationName = "Firswood"
                        }

                        @{
                            StationName = "Freehold"
                        }

                        @{
                            StationName = "Harbour City"
                        }

                        @{
                            StationName = "Heaton Park"
                        }

                        @{
                            StationName = "Hollinwood"
                        }

                        @{
                            StationName = "Holt Town"
                        }

                        @{
                            StationName = "Kingsway Business Park"
                        }

                        @{
                            StationName = "Ladywell"
                        }

                        @{
                            StationName = "Langworthy"
                        }

                        @{
                            StationName = "Manchester Airport"
                        }

                        @{
                            StationName = "Market Street"
                        }

                        @{
                            StationName = "Martinscroft"
                        }

                        @{
                            StationName = "MediaCityUK"
                        }

                        @{
                            StationName = "Milnrow"
                        }

                        @{
                            StationName = "Monsall"
                        }

                        @{
                            StationName = "Moor Road"
                        }

                        @{
                            StationName = "Navigation Road"
                        }

                        @{
                            StationName = "New Islington"
                        }

                        @{
                            StationName = "Newbold"
                        }

                        @{
                            StationName = "Newhey"
                        }

                        @{
                            StationName = "Newton Heath and Moston"
                        }

                        @{
                            StationName = "Northern Moor"
                        }

                        @{
                            StationName = "Old Trafford"
                        }

                        @{
                            StationName = "Oldham Central"
                        }

                        @{
                            StationName = "Oldham King Street"
                        }

                        @{
                            StationName = "Oldham Mumps"
                        }

                        @{
                            StationName = "Peel Hall"
                        }

                        @{
                            StationName = "Piccadilly"
                        }

                        @{
                            StationName = "Piccadilly Gardens"
                        }

                        @{
                            StationName = "Pomona"
                        }

                        @{
                            StationName = "Prestwich"
                        }

                        @{
                            StationName = "Queens Road"
                        }

                        @{
                            StationName = "Radcliffe"
                        }

                        @{
                            StationName = "Robinswood Road"
                        }

                        @{
                            StationName = "Rochdale Railway Station"
                        }

                        @{
                            StationName = "Rochdale Town Centre"
                        }

                        @{
                            StationName = "Roundthorn"
                        }

                        @{
                            StationName = "Sale"
                        }

                        @{
                            StationName = "Sale Water Park"
                        }

                        @{
                            StationName = "Salford Quays"
                        }

                        @{
                            StationName = "Shadowmoss"
                        }

                        @{
                            StationName = "Shaw and Crompton"
                        }

                        @{
                            StationName = "Shudehill"
                        }

                        @{
                            StationName = "South Chadderton"
                        }

                        @{
                            StationName = "St Peter's Square"
                        }

                        @{
                            StationName = "St Werburgh's Road"
                        }

                        @{
                            StationName = "Stretford"
                        }

                        @{
                            StationName = "Timperley"
                        }

                        @{
                            StationName = "Trafford Bar"
                        }

                        @{
                            StationName = "Velopark"
                        }

                        @{
                            StationName = "Victoria"
                        }

                        @{
                            StationName = "Weaste"
                        }

                        @{
                            StationName = "West Didsbury"
                        }

                        @{
                            StationName = "Westwood"
                        }

                        @{
                            StationName = "Whitefield"
                        }

                        @{
                            StationName = "Withington"
                        }

                        @{
                            StationName = "Wythenshawe Park"
                        }

                        @{
                            StationName = "Wythenshawe Town Centre"
                        }

                    )

                    It "Should pass parameter validation with '<StationName>'" -TestCases $Stations {

                        param ($StationName)
                        { Get-Metrolink -Station $StationName -Key "a1b2c3d4e5f6" } | Should -Not -Throw
                    }
                }
            }

            Context "Failing parameter validation" -Tag "ExpectedFail" {

                BeforeAll {

                    Mock Invoke-RestMethod -ModuleName "PSMetrolink" -MockWith {

                        $True
                    }

                    $Stations = @(
                        @{
                            StationName = "London"
                        }

                        @{
                            StationName = "Leeds"
                        }

                        @{
                            StationName = "Glasgow"
                        }

                        @{
                            StationName = "Sheffield"
                        }

                        @{
                            StationName = "Bolton"
                        }
                    )
                }

                It "Should fail parameter validation with '<StationName>'" -TestCases $Stations {

                    param ($StationName)
                    { Get-Metrolink -Station $StationName -Key "a1b2c3d4e5f6" } | Should -Throw
                }
            }
        }
    }
}