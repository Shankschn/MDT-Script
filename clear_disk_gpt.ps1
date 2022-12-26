Get-Disk |ForEach {
    Clear-Disk -Number $_.Number -RemoveData -RemoveOEM -Confirm:$false
}
Get-Disk |Where-Object PartitionStyle -eq 'RAW' |Initialize-Disk -PassThru |New-Partition -AssignDriveLetter -UseMaximumSize |Format-Volume -FileSystem NTFS -Confirm:$false