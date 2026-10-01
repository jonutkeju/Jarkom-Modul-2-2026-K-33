# Conf Slave ke Tedd
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

# Cek Slave Zonenya di Tedd
ls -la /var/cache/bind/

# Harusnya mirip sama 04.sh karna zona hasil replika master