# software id = GKV1-####
#
# model = RB2011UiAS
# serial number = #########
/interface bridge
add name=theBridge
/interface ethernet
set [ find default-name=ether1 ] name=ether1_Biznet
set [ find default-name=ether2 ] name=ether2_DecoS7
set [ find default-name=ether3 ] name=ether3_AX10_1stFloor
set [ find default-name=ether4 ] name=ether4_Ax20_2ndFloor
set [ find default-name=ether6 ] disabled=yes
set [ find default-name=ether7 ] disabled=yes
set [ find default-name=ether8 ] disabled=yes
set [ find default-name=ether9 ] disabled=yes
set [ find default-name=ether10 ] disabled=yes
set [ find default-name=sfp1 ] disabled=yes
/ip pool
add name=dhcp_pool0 ranges=192.168.10.2-192.168.10.254
add name=dhcp_pool1 ranges=192.168.13.2-192.168.13.10
/ip dhcp-server
add address-pool=dhcp_pool0 interface=theBridge name=dhcp1
add address-pool=dhcp_pool1 interface=ether5 name=dhcp2
/port
set 0 name=serial0
/queue type
add kind=fq-codel name=theCodel
add kind=cake name=theCake
add kind=pcq name=downloadLimit-pcq pcq-classifier=dst-address pcq-rate=30M
/queue tree
add max-limit=250M name=theQueue packet-mark=no-mark parent=global queue=\
    theCake
add max-limit=150M name=Balancer packet-mark=no-mark parent=theQueue \
    priority=3 queue=downloadLimit-pcq
/interface bridge port
add bridge=theBridge interface=ether2_DecoS7
add bridge=theBridge interface=ether3_AX10_1stFloor
add bridge=theBridge interface=ether4_Ax20_2ndFloor
/ip address
add address=192.168.10.1/24 interface=theBridge network=192.168.10.0
add address=192.168.13.1/24 interface=ether5 network=192.168.13.0
/ip dhcp-client
add default-route-tables=main interface=ether1_Biznet
/ip dhcp-server lease
add address=192.168.10.253 client-id=#:##:##:##:##:##:## mac-address=\
    ##:##:##:##:##:##:## server=dhcp1
add address=192.168.10.8 client-id=#:##:##:##:##:##:## mac-address=\
    ##:##:##:##:##:##:## server=dhcp1
add address=192.168.10.6 client-id=#:##:##:##:##:##:## mac-address=\
    ##:##:##:##:##:##:## server=dhcp1
add address=192.168.10.3 client-id=#:##:##:##:##:##:## mac-address=\
    ##:##:##:##:##:##:## server=dhcp1
add address=192.168.10.13 client-id=#:##:##:##:##:##:## mac-address=\
    ##:##:##:##:##:##:## server=dhcp1
add address=192.168.10.209 client-id=#:##:##:##:##:##:## mac-address=\
    ##:##:##:##:##:##:## server=dhcp1
add address=192.168.10.72 client-id=#:##:##:##:##:##:## mac-address=\
    ##:##:##:##:##:##:## server=dhcp1
/ip dhcp-server network
add address=192.168.10.0/24 dns-server=192.168.10.1 gateway=192.168.10.1
add address=192.168.13.0/24 dns-server=192.168.13.1 gateway=192.168.13.1
/ip dns
set allow-remote-requests=yes cache-size=4096KiB servers=1.1.1.1,8.8.8.8
/ip firewall address-list
add address=192.168.13.0/24 comment="Emergency Lan" list=allowed_to_router
add address=192.168.10.0/24 comment="Office LAN" list=allowed_to_router
/ip firewall filter
add action=accept chain=input connection-state=established,related,untracked
add action=accept chain=forward connection-state=\
    established,related,untracked
add action=accept chain=input protocol=icmp
add action=fasttrack-connection chain=forward disabled=yes hw-offload=yes
add action=accept chain=input src-address-list=allowed_to_router
add action=accept chain=input comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=accept chain=input comment="Allow Loopback" src-address=127.0.0.1
add action=accept chain=input comment="defconf: accept ICMP" protocol=icmp
add action=accept chain=input comment="Allow Admin Access" src-address-list=\
    allowed_to_router
add action=drop chain=input comment="defconf: drop all not coming from LAN"
add action=accept chain=forward comment=\
    "defconf: accept established,related, untracked" connection-state=\
    established,related,untracked
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid
add action=drop chain=forward comment=\
    "defconf: drop all from WAN not DSTNATed" connection-nat-state=!dstnat \
    connection-state=new in-interface=ether1_Biznet
add action=drop chain=forward comment="Drop Invalid" connection-state=invalid
add action=drop chain=forward comment="Block WAN Input" connection-nat-state=\
    !dstnat connection-state=new in-interface=ether1_Biznet
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1_Biznet
add action=redirect chain=dstnat comment="Force DNS to Router" dst-port=53 \
    protocol=udp src-address=192.168.10.0/24 to-ports=53
add action=redirect chain=dstnat dst-port=53 protocol=tcp src-address=\
    192.168.10.0/24 to-ports=53
/ip service
set ftp disabled=yes
set telnet disabled=yes
set www disabled=yes
set api disabled=yes
/lcd
set default-screen=stats
/system clock
set time-zone-name=Asia/Jakarta
/system scheduler
add interval=4w2d name=Daily-Reboot on-event="/system reboot" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2025-12-02 start-time=23:59:59
