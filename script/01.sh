# Conf di Rootkit
  auto eth0
  iface eth0 inet dhcp

  auto eth1
  iface eth1 inet static
      address 10.80.1.1
      netmask 255.255.255.0

  auto eth2
  iface eth2 inet static
      address 10.80.2.1
      netmask 255.255.255.0

  auto eth3
  iface eth3 inet static
      address 10.80.3.1
      netmask 255.255.255.0

  auto eth4
  iface eth4 inet static
      address 10.80.4.1
      netmask 255.255.255.0

  auto eth5
  iface eth5 inet static
      address 10.80.5.1
      netmask 255.255.255.0

# Conf setiap node
  auto eth0
  iface eth0 inet static
      address 10.80.x.x
      netmask 255.255.255.0
      gateway 10.80.x.x
      up rm -f /etc/resolv.conf && echo "nameserver 192.168.122.1" > /etc/resolv.conf

# Test IP addressing setiap node, tapi ga ke diri sendiri
ip a show eth0
ping -c 3 10.80.x.x
ping -c 3 192.168.122.1

# Kalo gaada paket yang ilang berarti done kingg