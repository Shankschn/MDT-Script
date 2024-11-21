# MDT-Scripts
Microsoft Deployment Toolkit Scripts
微软 MDT 个人脚本
使用时，请更改脚本名称。

## UserExit - AutoSelectAndClearFormatDisk SSD M2 SAS SATA.vbs
优先选择容量最小，速度最快的盘，设置为 OSDisk，即系统盘。
硬盘优先级：M2 SSD > SAS SSD > SATA SSD > SATA HDD
格式化所有硬盘(需搭配 clear_disk_gpt.ps1)。

## UserExit - AutoSelectDisk SSD M2 SAS SATA.vbs
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
