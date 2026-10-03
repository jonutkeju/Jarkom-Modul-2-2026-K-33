# Conf Master ke Prab

    #Yang ini nginstall bind9
    up which named || (apt-get update && apt-get install -y bind9 bind9-dnsutils)
    up mkdir -p /etc/bind/zones

    # Di bagian akhir banget, tambahin ini buat ngerestart
    up /etc/init.d/named restart 2>/dev/null || /etc/init.d/bind9 restart 2>/dev/null
    up rm -f /etc/resolv.conf && echo -e "nameserver 10.80.5.2\nnameserver 10.80.5.3\nnameserver 192.168.122.1" > /etc/resolv.conf

    # Yang ini ngeconfig Reverse Zonenya
    up echo 'zone "Kel33.com" {' > /etc/bind/named.conf.local
    up echo '    type master;' >> /etc/bind/named.conf.local
    up echo '    file "/etc/bind/zones/db.Kel33.com";' >> /etc/bind/named.conf.local
    up echo '    notify yes;' >> /etc/bind/named.conf.local
    up echo '    allow-transfer { 10.80.5.3; };' >> /etc/bind/named.conf.local
    up echo '};' >> /etc/bind/named.conf.local
    up echo '' >> /etc/bind/named.conf.local
    up echo 'zone "3.80.10.in-addr.arpa" {' >> /etc/bind/named.conf.local
    up echo '    type master;' >> /etc/bind/named.conf.local
    up echo '    file "/etc/bind/zones/db.10.80.3";' >> /etc/bind/named.conf.local
    up echo '    notify yes;' >> /etc/bind/named.conf.local
    up echo '    allow-transfer { 10.80.5.3; };' >> /etc/bind/named.conf.local
    up echo '};' >> /etc/bind/named.conf.local
    up echo '' >> /etc/bind/named.conf.local
    up echo 'zone "4.80.10.in-addr.arpa" {' >> /etc/bind/named.conf.local
    up echo '    type master;' >> /etc/bind/named.conf.local
    up echo '    file "/etc/bind/zones/db.10.80.4";' >> /etc/bind/named.conf.local
    up echo '    notify yes;' >> /etc/bind/named.conf.local
    up echo '    allow-transfer { 10.80.5.3; };' >> /etc/bind/named.conf.local
    up echo '};' >> /etc/bind/named.conf.local
    up echo '' >> /etc/bind/named.conf.local
    up echo 'zone "5.80.10.in-addr.arpa" {' >> /etc/bind/named.conf.local
    up echo '    type master;' >> /etc/bind/named.conf.local
    up echo '    file "/etc/bind/zones/db.10.80.5";' >> /etc/bind/named.conf.local
    up echo '    notify yes;' >> /etc/bind/named.conf.local
    up echo '    allow-transfer { 10.80.5.3; };' >> /etc/bind/named.conf.local
    up echo '};' >> /etc/bind/named.conf.local

# Conf Slave ke Tedd

    # Yang ini nginstall bind9
    up which named || (apt-get update && apt-get install -y bind9 bind9utils dnsutils)

    # Di bagian akhir banget, tambahin ini buat ngerestart
    up /etc/init.d/named restart 2>/dev/null || /etc/init.d/bind9 restart 2>/dev/null
    up rm -f /etc/resolv.conf && echo -e "nameserver 10.80.5.2\nnameserver 10.80.5.3\nnameserver 192.168.122.1" > /etc/resolv.conf

    # Ngeconfig Slave Zonenya
    up echo 'zone "Kel33.com" {' > /etc/bind/named.conf.local
    up echo '    type slave;' >> /etc/bind/named.conf.local
    up echo '    file "/var/cache/bind/db.Kel33.com";' >> /etc/bind/named.conf.local
    up echo '    masters { 10.80.5.2; };' >> /etc/bind/named.conf.local
    up echo '};' >> /etc/bind/named.conf.local
    up echo '' >> /etc/bind/named.conf.local
    up echo 'zone "3.80.10.in-addr.arpa" {' >> /etc/bind/named.conf.local
    up echo '    type slave;' >> /etc/bind/named.conf.local
    up echo '    file "/var/cache/bind/db.10.80.3";' >> /etc/bind/named.conf.local
    up echo '    masters { 10.80.5.2; };' >> /etc/bind/named.conf.local
    up echo '};' >> /etc/bind/named.conf.local
    up echo '' >> /etc/bind/named.conf.local
    up echo 'zone "4.80.10.in-addr.arpa" {' >> /etc/bind/named.conf.local
    up echo '    type slave;' >> /etc/bind/named.conf.local
    up echo '    file "/var/cache/bind/db.10.80.4";' >> /etc/bind/named.conf.local
    up echo '    masters { 10.80.5.2; };' >> /etc/bind/named.conf.local
    up echo '};' >> /etc/bind/named.conf.local
    up echo '' >> /etc/bind/named.conf.local
    up echo 'zone "5.80.10.in-addr.arpa" {' >> /etc/bind/named.conf.local
    up echo '    type slave;' >> /etc/bind/named.conf.local
    up echo '    file "/var/cache/bind/db.10.80.5";' >> /etc/bind/named.conf.local
    up echo '    masters { 10.80.5.2; };' >> /etc/bind/named.conf.local
    up echo '};' >> /etc/bind/named.conf.local

# Cek dari klien manapun
dig @10.80.5.2 Kel33.com SOA
dig @10.80.5.3 Kel33.com SOA
dig Kel33.com A +short
dig prab.Kel33.com A +short
dig tedd.Kel33.com A +short
dig @10.80.5.2 google.com +short

# Lek misal ra onok error aman aee