# PSMetrolink

I was playing around with the TFGM/Metrolink API in the console, and after a while it seemed stupid to be re-using the same hacked together code when I could write something up.

## Usage

Sign-up for a [TFGM api key](https://developer.tfgm.com/), then follow the example below:

```Powershell
# Import the script.
. .\Get-Metrolink.ps1

# Save the key for use.
$Key = "abcdefghi123456789"

# Retrieve trams arriving at Bury.
Get-Metrolink -Station "Bury" -Key $Key
```