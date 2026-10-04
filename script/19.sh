# 1. Perbarui file database zone domain dengan serial baru (6) dan CNAME record outbound menuju badssl.com
cat << 'EOF' > /etc/bind/db.Kel33.com
$TTL    604800
@       IN      SOA     ns1.Kel33.com. root.Kel33.com. (
                              6         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL

@       IN      NS      ns1.Kel33.com.
@       IN      A       10.80.4.2
ns1     IN      A       10.80.4.2
www     IN      A       10.80.4.2
static  IN      A       10.80.4.3
abbey   15      IN      A       192.168.99.99

; --- CNAME Record menuju badssl.com ---
outbound  IN    CNAME   badssl.com.

; --- TXT Record Klien ---
alpha     IN      TXT     "alpha"
beta      IN      TXT     "beta"
gamma     IN      TXT     "gamma"
delta     IN      TXT     "delta"
epsilon   IN      TXT     "epsilon"
EOF

# 2. Validasi konfigurasi zone DNS agar tidak ada error syntax
named-checkzone Kel33.com /etc/bind/db.Kel33.com

# 3. Restart layanan DNS (named) agar CNAME record langsung aktif
service named restart

# 4. Uji coba query CNAME dan curl ke outbound.Kel33.com
dig CNAME outbound.Kel33.com
curl -s -I http://outbound.Kel33.com