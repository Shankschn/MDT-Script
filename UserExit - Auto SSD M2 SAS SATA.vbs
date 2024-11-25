Function UserExit(sType, sWhen, sDetail, bSkip)
    oLogging.CreateEntry "entered UserExit ", LogTypeInfo
    UserExit=Success
End Function

Function SetOSDisk()
    Dim objShell, objFSO, objFile, scriptTmpFolder, strScriptFile, wmi
    Dim colDisks, objDisk, disks, disk, diskp1, diskp2, diskp3, d, e, f
    Dim diskid, objFile2

    Set objShell = CreateObject("WScript.Shell")
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    scriptTmpFolder = "X:\Deploy\tmp"
    If Not objFSO.FolderExists(scriptTmpFolder) Then
        objFSO.CreateFolder(scriptTmpFolder)
    End If

    strScriptFile = scriptTmpFolder & "\CleanAllDisks.txt"
    Set objFile = objFSO.CreateTextFile(strScriptFile, True)
    Set wmi = GetObject("winmgmts:\\.\root\cimv2")
    Set colDisks = wmi.ExecQuery("Select * from Win32_DiskDrive")
    For Each objDisk In colDisks
        objFile.WriteLine("list disk")
        objFile.WriteLine("select disk " & objDisk.Index)
        objFile.WriteLine("clean")
    Next
    'objFile.WriteLine("exit")
    objFile.Close

    checkErr = scriptTmpFolder & "\CheckErr.vbs"
    Set objFile2 = objFSO.CreateTextFile(checkErr, True)
    objFile2.WriteLine("Dim objShell, wmi, pl, p, pn, pnHas")
    objFile2.WriteLine("pn = ""TsProgressUI.exe""")
    objFile2.WriteLine("pnHas = False")
    objFile2.WriteLine("Set wmi = GetObject(""winmgmts:\\.\root\cimv2"")")
    objFile2.WriteLine("For i = 1 To 30")
    objFile2.WriteLine("    Set pl = wmi.ExecQuery(""SELECT * FROM Win32_Process WHERE Name = '"" & pn & ""'"")")
    objFile2.WriteLine("    If pl.Count > 0 Then")
    objFile2.WriteLine("        pnHas = True")
    objFile2.WriteLine("        Exit For")
    objFile2.WriteLine("    End If")
    objFile2.WriteLine("    WScript.Sleep 1000")
    objFile2.WriteLine("Next")
    objFile2.WriteLine("If Not pnHas Then")
    objFile2.WriteLine("    Set objShell = CreateObject(""WScript.Shell"")")
    objFile2.WriteLine("    objShell.Run ""wpeutil reboot"", 0, False")
    objFile2.WriteLine("End If")
    objFile2.Close
    objShell.Run "wscript.exe """ & checkErr & """", 0, False
    objShell.Run "diskpart /s " & strScriptFile, 1, True
    WScript.Sleep 3000

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
