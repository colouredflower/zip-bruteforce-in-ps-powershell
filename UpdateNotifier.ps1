Invoke-WebRequest https://raw.githubusercontent.com/colouredflower/zip-bruteforce-in-ps-powershell/main/version.txt -OutFile latestversion.txt
$latestver = (Get-Content latestversion.txt)
$currentver = (Get-Content version.txt)
if ((Compare-Object $currentver $latestver) -eq $null) {
Write-Output "Good job! You are using the latest version"
exit
} else {
Write-Output "New update alert $latestver! You are currently using $currentver"
exit
}
