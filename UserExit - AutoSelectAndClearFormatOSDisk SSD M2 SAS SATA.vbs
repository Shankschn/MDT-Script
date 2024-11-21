Function UserExit(sType, sWhen, sDetail, bSkip)
    oLogging.CreateEntry "entered UserExit ", LogTypeInfo
    UserExit=Success
End Function

Function SetOSDisk()
    Set ObjShell=CreateObject("WScript.Shell")
    set wmi=GetObject("Winmgmts:\\.\Root\Microsoft\Windows\Storage")
    set disks=wmi.Execquery("Select * from MSFT_PhysicalDisk")
    diskp1=0
    diskp2=0
    diskp3=999999
    for each d in disks
        if d.MediaType=4 then
            if diskp1=0 then
                diskp1=d.MediaType
            end if
            if d.BusType=17 then
                diskp2=d.BusType
                exit for
            elseif d.BusType=10 then
                if diskp2=0 or diskp2=11 then
                    diskp2=d.BusType
                end if
            elseif d.BusType=11 and diskp2=0 then
                diskp2=d.BusType
            end if
        end if
    next
    if diskp1=0 then
        for each e in disks
            if e.Size/1024/1024/1024<diskp3 then
                diskp3=e.Size/1024/1024/1024
                diskid=e.DeviceId
            end if
        next
    else
        for each f in disks
            if diskp1=f.MediaType and diskp2=f.BusType then
                if f.Size/1024/1024/1024<diskp3 then
                    diskp3=f.Size/1024/1024/1024
                    diskid=f.DeviceId
                end if
            end if
        next
    end if
    if diskid="" then
        diskid=0
    end if
    SetOSDisk=diskid
    
    deployroot=oEnvironment.Item("deployroot")
    cmd1="powershell.exe -noprofile -executionpolicy bypass -file " & deployroot & "\scripts\clear_disk_gpt.ps1 " & diskid & " " & diskp1 & " " & diskp2 & " " & diskp3
    oLogging.CreateEntry "UserExit: Command to run " & cmd1, LogTypeInfo
    ObjShell.run cmd1,0,true
End Function
