@echo off

::Flicker dat NIC
netsh interface set interface name="Local Area Connection" admin=disabled
netsh interface set interface name="Local Area Connection" admin=enabled

::Change Passwords! Disable Guest!
net user Administrator *
net user guest /active:no

::Firewall Time
netsh advfirewall reset
netsh advfirewall set allprofiles state on
netsh advfirewall firewall delete rule name=all
netsh advfirewall set allprofiles firewallpolicy blockinbound,blockoutbound

netsh advfirewall firewall add rule name=ping action=allow protocol=icmpv4:8,any dir=in
netsh advfirewall firewall add rule name=lo action=allow remoteip=127.0.0.0/8 dir=in
netsh advfirewall firewall add rule name=lo action=allow remoteip=127.0.0.0/8 dir=out

netsh advfirewall firewall add rule name=ftpout action=allow protocol=tcp remoteip=63.245.215.56,63.245.56.46 dir=out
netsh advfirewall firewall add rule name=ftpout action=allow protocol=tcp remoteip=63.245.215.56,63.245.56.46 dir=in

netsh advfirewall firewall add rule name=ftp action=allow protocol=tcp remoteport=20,21,10000-10010 dir=in
netsh advfirewall set global StatefulFTP disable

netsh advfirewall firewall add rule name=localDomain action=allow remoteip=10.2.x.0/24 dir=in
netsh advfirewall firewall add rule name=localDomain action=allow remoteip=10.2.x.0/24 dir=out

::Flicker dat NIC
netsh interface set interface name="Local Area Connection" admin=disabled
netsh interface set interface name="Local Area Connection" admin=enabled

::Once you get firefox, uncomment this part
::netsh advfirewall firewall add rule name=web action=allow program=whereisfirefox protocol=tcp remoteport=443,80 dir=out ::if proxy, remoteip=<proxyip>

::Go to https://technet.microsoft.com/en-us/sysinternals/bb842062