$ScriptPath = Get-ChildItem -Path ($PSScriptRoot -replace "\\Tests|Unit\.Tests\.") -Filter "*.ps1" | Select-Object -ExpandProperty "FullName"
. $ScriptPath

Describe "Unit tests for 'Get-Metrolink'" {

    Context "Input" {

        Context "Passing parameter validation" -Tag "ExpectedPass" {

            BeforeAll {

                $ExampleKey = "123456789abcdefghi"
                Mock -CommandName "Invoke-RestMethod" -MockWith { $True }
            }

            It "Should not throw with valid named parameters" {

                { Get-Metrolink -Station "Bury" -Key $ExampleKey -Uri "https://api.tfgm.com/odata/Metrolinks" } | Should -Not -Throw
                Assert-MockCalled -CommandName "Invoke-RestMethod" -Times 1
            }

            It "Should not throw with valid positional parameters" {

                { Get-Metrolink "Bury" $ExampleKey "https://api.tfgm.com/odata/Metrolinks" } | Should -Not -Throw
                Assert-MockCalled -CommandName "Invoke-RestMethod" -Times 1
            }
        }

        Context "Failing parameter validation" -Tag "ExpectedFail" {

            BeforeAll {

                Mock -CommandName "Invoke-RestMethod" -MockWith { $True }
            }

            It "Should throw when Key is null" {

                $ExampleKey = $Null
                { Get-Metrolink -Station "Bury" -Key $ExampleKey } | Should -Throw
                Assert-MockCalled -CommandName "Invoke-RestMethod" -Times 0
            }

            It "Should throw when Key is empty" {

                { Get-Metrolink -Station "Bury" -Key "" } | Should -Throw
                Assert-MockCalled -CommandName "Invoke-RestMethod" -Times 0
            }
        }
    }

    Context "Execution" {

    }

    Context "Output" {

    }
}