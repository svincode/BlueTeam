@echo off

::Flicker dat NIC
netsh interface set interface name="Local Area Connection" admin=disabled
netsh interface set interface name="Local Area Connection" admin=enabled

::Change Passwords! Disable Guest!
net user Administrator *
net user guest /active:no

::Change paswords of all other domain users
dsquery user cn=Users,dc=ad,dc=team5,dc=ists | dsmod user -pwd TheHawkingProject!@# -mustchpwd yes -disabled yes

::Firewall Time
netsh advfirewall reset
netsh advfirewall set allprofiles state on
netsh advfirewall firewall delete rule name=all
netsh advfirewall set allprofiles firewallpolicy blockinbound,blockoutbound

netsh advfirewall firewall add rule name=ping action=allow protocol=icmpv4:8,any dir=in
netsh advfirewall firewall add rule name=lo action=allow remoteip=127.0.0.0/8 dir=in
netsh advfirewall firewall add rule name=lo action=allow remoteip=127.0.0.0/8 dir=out

netsh advfirewall firewall add rule name=dnsfwd action=allow protocol=udp remoteport=53 remoteip=8.8.8.8 dir=out
netsh advfirewall firewall add rule name=dnssrv action=allow protocol=udp localport=53 dir=in
netsh advfirewall firewall add rule name=ztdns action=allow protocol=tcp localport=53 remoteip=10.2.5.60 dir=out
netsh advfirewall firewall add rule name=ztdns action=allow protocol=tcp remoteport=53 remoteip=10.2.5.60 dir=in 
netsh advfirewall firewall add rule name=ztdns action=allow protocol=udp remoteport=53 remoteip=10.2.5.60 dir=in

netsh advfirewall firewall add rule name=RPC action=allow protocol=tcp localport=RPC remoteip=10.2.5.0/24 dir=in 
netsh advfirewall firewall add rule name=RPCEPM action=allow protocol=tcp localport=RPC-EPMap remoteip=10.2.5.0/24 dir=in 

netsh advfirewall firewall add rule name=AD1 action=allow protocol=tcp localport=445,389,88,135,636,3268 remoteip=10.2.5.0/24 dir=in 
netsh advfirewall firewall add rule name=AD2 action=allow protocol=tcp localport=445 remoteip=10.2.5.0/24 dir=out 
netsh advfirewall firewall add rule name=AD3 action=allow protocol=udp localport=389,88,445,636 remoteip=10.2.5.0/24 dir=in 

netsh advfirewall firewall add rule name=ftpout action=allow protocol=tcp remoteip=63.245.215.56,63.245.56.46 dir=out
netsh advfirewall firewall add rule name=ftpout action=allow protocol=tcp remoteip=63.245.215.56,63.245.56.46 dir=in

netsh advfirewall firewall add rule name=localDomain action=allow remoteip=10.2.5.0/24 dir=in
netsh advfirewall firewall add rule name=localDomain action=allow remoteip=10.2.5.0/24 dir=out

::Flicker dat NIC
netsh interface set interface name="Local Area Connection" admin=disabled
netsh interface set interface name="Local Area Connection" admin=enabled

::Once you get firefox, uncomment this part
::netsh advfirewall firewall add rule name=web action=allow program=whereisfirefox protocol=tcp remoteport=443,80 dir=out ::if proxy, remoteip=<proxyip>
::GO to https://technet.microsoft.com/en-us/sysinternals/bb842062




