Function UserExit(sType, sWhen, sDetail, bSkip)
    oLogging.CreateEntry "entered UserExit ", LogTypeInfo
    UserExit=Success
End Function

Function SetOSDisk()
    Set objShell = CreateObject("WScript.Shell")
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    tmpName = GenRandomName()
    scriptTmpFolder = "X:\Deploy\tmp"
    strScriptFile = scriptTmpFolder & "\CleanAllDisks-" & tmpName & ".txt"
    If Not objFSO.FolderExists(scriptTmpFolder) Then
        objFSO.CreateFolder(scriptTmpFolder)
    End If
    Set objFile = objFSO.CreateTextFile(strScriptFile, True)
    Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
    Set colDisks = objWMIService.ExecQuery("Select * from Win32_DiskDrive")
    For Each objDisk In colDisks
        objFile.WriteLine("select disk " & objDisk.Index)
        objFile.WriteLine("clean")
    Next
    objFile.WriteLine("exit")
    objFile.Close
    objShell.Run "diskpart /s " & strScriptFile, 1, True
    objFSO.DeleteFile(strScriptFile)

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
End Function

Function GenRandomName()
    Dim chars, GRName, i, randomIndex
    chars = "ABCDEFGHJKLQWERTZXCVB123456789"
    GRName = ""
    For i = 1 To 8
        randomIndex = Int((Len(chars) * Rnd) + 1)
        GRName = GRName & Mid(chars, randomIndex, 1)
    Next
    GenRandomName = GRName
End Function
