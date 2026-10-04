# 1. Perbarui file database zone domain dengan serial baru (5), TTL 15 detik untuk abbey, dan IP fiktif
cat << 'EOF' > /etc/bind/db.Kel33.com
$TTL    604800
@       IN      SOA     ns1.Kel33.com. root.Kel33.com. (
                              5         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL

@       IN      NS      ns1.Kel33.com.
@       IN      A       10.80.4.2
ns1     IN      A       10.80.4.2
www     IN      A       10.80.4.2
static  IN      A       10.80.4.3

; --- A record abbey dengan TTL 15 detik dan IP fiktif ---
abbey   15      IN      A       192.168.99.99

; --- TXT Record Klien ---
alpha     IN      TXT     "alpha"
beta      IN      TXT     "beta"
gamma     IN      TXT     "gamma"
delta     IN      TXT     "delta"
epsilon   IN      TXT     "epsilon"
EOF

# 2. Validasi konfigurasi zone DNS agar tidak ada error
named-checkzone Kel33.com /etc/bind/db.Kel33.com

# 3. Restart layanan DNS (named) agar perubahan langsung diterapkan ke server master & slave (tedd)
service named restart

# 4. Uji coba query DNS dari klien untuk verifikasi fase TTL
dig abbey.Kel33.com