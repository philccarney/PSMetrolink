# PSMetrolink

I was playing around with the TFGM/Metrolink API in the console, and after a while it seemed stupid to be re-using the same hacked together code when I could write something up.

## Usage

Sign-up for a [TFGM api key](https://developer.tfgm.com/), then follow the example below:

```Powershell
Install the module
Install-Module -Name "PSMetrolink"

# Save your subscription key for ease of use - don't save it to your history
$OriginalSaveStyle = (Get-PSReadLineOption).HistorySaveStyle
Set-PSReadLineOption -HistorySaveStyle SaveNothing
$Key = "abcdefghi123456789"
Set-PSReadLineOption -HistorySaveStyle $OriginalSaveStyle

# Retrieve Metrolinks arriving at Bury.
Get-Metrolink -Station "Bury" -Key $Key
# or trams
Get-Tram -Key $Key
# or Mets
Get-Met -Station "Radcliffe" -Key $Key

# There's a generational difference.
```

## Notes

The structure and build/publishing process borrows heavily from Kevin Marquette's _Micro Modules_ write-up on [PowershellExplained.com](https://powershellexplained.com/2019-04-11-Powershell-Building-Micro-Modules/).
