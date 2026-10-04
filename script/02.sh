# Di Rootkit Terminal

nano /root/.bashrc
dhclient eth0 2>/dev/null
iptables -F
iptables -t nat -F
sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Cek di Rootkit Terminal setelah restart
cat /proc/sys/net/ipv4/ip_forward
iptables -t nat -L POSTROUTING -n -v 
# Hasilnya harus ada MASQUERADE nya

# Cek di klien bebas
ping -c 3 192.168.122.1
# Kalo bisa berarti aman kingg