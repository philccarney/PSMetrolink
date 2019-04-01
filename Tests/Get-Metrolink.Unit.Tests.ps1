$ScriptPath = Get-ChildItem -Path ($PSScriptRoot -replace "\\Tests|Unit\.Tests\.") -Filter "*.ps1" | Select-Object -ExpandProperty "FullName"
. $ScriptPath

Describe "Unit tests for 'Get-Metrolink'" {

    Context "Input" {

    }

    Context "Execution" {

    }

    Context "Output" {

    }
}