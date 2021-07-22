Function UserExit(sType, sWhen, sDetail, bSkip)
    oLogging.CreateEntry "entered UserExit ", LogTypeInfo
    UserExit = Success
End Function

Function SetOSDisk()
    Set ObjShell = CreateObject("WScript.Shell")
    deployroot = oEnvironment.Item("deployroot")
    cmd1 = "powershell.exe -noprofile -executionpolicy bypass -file" & deployroot & "\scripts\clear_disk_gpt.ps1"
    oLogging.CreateEntry "UserExit: Command to run " & cmd1, LogTypeInfo
    ObjShell.run cmd1,0,true

    set wmi = GetObject("Winmgmts:\\.\Root\Microsoft\Windows\Storage")
    set disks = wmi.Execquery("Select * from MSFT_PhysicalDisk")
    for each d in disks
        if d.MediaType=4 then
            diskid=d.DeviceId
            if d.BusType=17 then
                exit for
            end if
        end if
    next
    if diskid = "" then
        diskid=0
    end if
    SetOSDisk = diskid

End Function
