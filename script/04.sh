# Conf Master ke Prab
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

# Cek Master Forwarding ama Reverse Zonenya di Prab
named-checkconf /etc/bind/named.conf.local

# Lek misal ra onok error aman aee