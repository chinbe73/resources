https://jon.sprig.gs/blog/post/1574

```
psexec64 -s -i "C:\Program Files\Oracle\VirtualBox\VirtualBox.exe"

Get-NetAdapter -Physical | format-list -property "Name","DriverDescription"

Name              : Ethernet0
DriverDescription : vmxnet3 Ethernet Adapter

psexec64 -s "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifyvm "kafka" --nic2 hostonly --hostonlyadapter2 "VirtualBox Host-Only Ethernet Adapter"
psexec64 -s "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifyvm "kafka" --nic2 bridged --bridgeadapter2 "vmxnet3 Ethernet Adapter"
psexec64 -s "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" showvminfo "kafka"
psexec64 -s "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm "kafka" --natpf1 "myport,tcp,,1234,,2345"
psexec64 -s "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm "kafka" --natpf1 delete "myport"
```
