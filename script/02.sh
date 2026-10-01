# Conf setiap node
    up hostname (nama node)
    up echo "(nama node)" > /etc/hostname
    up echo -e "nameserver 10.80.5.2\nnameserver 10.80.5.3\nnameserver 192.168.122.1" > /etc/resolv.conf

# Cek identitasnya di setiap node
hostname
cat /etc/resolv.conf

# HARUSNYA outputnya sama