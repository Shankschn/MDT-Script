Get-WmiObject -Class Win32_Volume -Filter "DriveType=5 and DriveLetter='D:'" |Select-Object -First 1 |Set-WmiInstance -Arguments @{DriveLetter="R:"}
Get-Disk |Where-Object PartitionStyle -eq 'RAW' |Initialize-Disk -PassThru |New-Partition -UseMaximumSize |Format-Volume -FileSystem NTFS -Confirm:$false
$tmp1 = Get-Partition | Where-Object {-not $_.DriveLetter -and $($_.size/1024/1024/1024) -gt 30}
foreach ($tmp2 in $tmp1) {
    $tmp3 = Get-Volume | Where-Object {$_.DriveLetter -ne "R" -and -not -not $_.DriveLetter} |Sort-Object DriveLetter |Select-Object -Last 1
    $tmp4 = [char]([int][char]$tmp3.DriveLetter + 1)
    Set-Partition -DiskNumber $tmp2.DiskNumber -PartitionNumber $tmp2.PartitionNumber -NewDriveLetter $tmp4
    Start-Sleep -Seconds 1
}
