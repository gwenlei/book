http://www.cyberciti.biz/faq/howto-linux-renew-dhcp-client-ip-address/
More detail, about this not working on Ubuntu:
sudo dhclient -r -pf /var/run/dhclient-eth1.pid -lf /var/lib/dhcp3/dhclient-eth1.lease eth1

This kill the running dhcp daemon which is noticed by Network Manager which then immediately downs the interface, so the dhclient can not send the DHCPRELEASE packet.

The solution is to disable NM (right clik on its icon and uncheck the first option “Enable Netwroking” – this is so on Ubuntu 10.10, other version might look a bit different), kill existing dhclient processes, then establish the connection manually, run dhclient eth0 , then run the above dhclient command to release the IP.

For connection to WPA protected WLAN networks follow the description on 
