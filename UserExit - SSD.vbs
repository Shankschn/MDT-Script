Function UserExit(sType, sWhen, sDetail, bSkip)
    oLogging.CreateEntry "entered UserExit ", LogTypeInfo
    UserExit = Success
End Function

Function SetOSDisk()
    set wmi = GetObject("Winmgmts:\\.\Root\Microsoft\Windows\Storage")
    set disks = wmi.Execquery("Select * from MSFT_PhysicalDisk")
    for each d in disks
        if d.MediaType=4 then
            diskid=d.DeviceId
        end if
    next
    if diskid = "" then
        diskid=0
    end if

    SetOSDisk = diskid
End Function