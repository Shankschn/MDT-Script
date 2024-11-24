# MDT-Scripts
微软 MDT 个人脚本 Microsoft Deployment Toolkit Scripts

建议使用从介绍上（介绍越靠上越新）至下；使用时，请更改脚本名称。

## UserExit - Auto SSD M2 SAS SATA.vbs
重要：该脚本会清理所有硬盘数据！

优先选择容量最小，速度最快的盘，设置为 OSDisk，即系统盘。

硬盘优先级：M2 SSD > SAS SSD > SATA SSD > SATA HDD
### 该命令通常还需配合 FormatOtherDisks.ps1
FormatOtherDisks.ps1 将所有磁盘均格式化。

## UserExit - AutoSelectDisk SSD M2 SAS SATA.vbs
只进行标记操作系统安装 Disk，不会进行格式化操作。

优先选择容量最小，速度最快的盘，设置为 OSDisk，即系统盘。

硬盘优先级：M2 SSD > SAS SSD > SATA SSD > SATA HDD

支持虚拟机 VMWare Workstation 17，ESXi 6.7 U3 磁盘测试。

## UserExit - FormatDisk SSD M2.vbs
格式化所有硬盘(需搭配 clear_disk_gpt.ps1)，检测并选择 SSD，优先选择 M2 SSD。仅支持 Windows 10 PE 及以上。

## UserExit - FormatDisk SSD.vbs
格式化所有硬盘(需搭配 clear_disk_gpt.ps1)，检测并选择 SSD。

## UserExit - SSD M2.vbs
检测并选择 SSD，优先选择 M2 SSD。

仅支持 Windows 10 PE 及以上。

## UserExit - SSD.vbs
检测并选择 SSD。

# 使用方法
https://www.yudelei.com/272.html
