.\UpdateNotifier.ps1
#Made by, coloured flower

# Stopwatch for measurement
$stopWatch = [System.Diagnostics.Stopwatch]::startNew()

$7zipExec = """C:\Program Files\7-Zip\7z.exe"""
$input = """-.zip location-"""
$output = """-where to drop contents of .zip file-"""
$passwordfile = "-location of .txt file containing passwords-"
$windowStyle = "Hidden"
[long] $counter = 0

 # Correct password is 12341234

foreach ($password in (get-content $passwordfile)) {
$counter++
Write-Host -NoNewLine "Attempt #($counter): $password"
$arguments = "x -o$output -p$password -aoa $input"
$p = Start-Process $7zipExec -ArgumentList $arguments -Wait -PassThru -WindowStyle $windowStyle

if ($p.ExitCode -eq 0) {
    # Password OK
    Write-Host " ...OK!"
    Write-Host ""
    Write-Host "Password is $password, found it after $counter tries."
    break
}
elseif ($p.ExitCode -eq 2) {
    # Wrong password
    Write-Host " ...wrong"
}
else {
    # Unknown
    Write-Host " ...ERROR"
}
}

# Halt the stopwatch and display the time spent for this process
$stopWatch.Stop()
Write-Host
Write-Host "Done in $($stopWatch.Elapsed.Hours) hour(s), $($stopWatch.Elapsed.Minutes) minute(s) and $($stopWatch.Elapsed.Seconds) seconds(s)" 
Read-Host -Prompt "Press Enter to exit"
