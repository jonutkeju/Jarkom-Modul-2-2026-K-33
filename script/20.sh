# 1. Perbarui file database zone domain: kembalikan IP abbey ke normal (10.80.4.2), naikkan serial SOA menjadi 7, dan pertahankan CNAME serta TXT record
cat << 'EOF' > /etc/bind/db.Kel33.com
$TTL    604800
@       IN      SOA     ns1.Kel33.com. root.Kel33.com. (
                              7         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL

@       IN      NS      ns1.Kel33.com.
@       IN      A       10.80.4.2
ns1     IN      A       10.80.4.2
www     IN      A       10.80.4.2
static  IN      A       10.80.4.3
abbey   IN      A       10.80.4.2

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

# 3. Restart layanan DNS (named)
service named restart

# 4. Pastikan layanan DNS dan Apache terdaftar untuk autostart saat boot (sysvinit)
update-rc.d named defaults

# 5. Cek status layanan untuk memastikan semuanya berjalan normal
service named status