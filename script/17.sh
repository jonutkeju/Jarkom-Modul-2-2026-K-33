# 1. Daftarkan zone domain ke konfigurasi utama BIND9
cat << 'EOF' > /etc/bind/named.conf.local
zone "Kel33.com" {
    type master;
    file "/etc/bind/db.Kel33.com";
};
EOF

# 2. Buat atau perbarui file database zone domain dengan serial terbaru dan TXT record klien
cat << 'EOF' > /etc/bind/db.Kel33.com
$TTL    604800
@       IN      SOA     ns1.Kel33.com. root.Kel33.com. (
                              4         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL

@       IN      NS      ns1.Kel33.com.
@       IN      A       10.80.4.2
ns1     IN      A       10.80.4.2
www     IN      A       10.80.4.2
static  IN      A       10.80.4.3

; --- TXT Record untuk Klien Sayap Kiri dan Kanan ---
alpha     IN      TXT     "alpha"
beta      IN      TXT     "beta"
gamma     IN      TXT     "gamma"
delta     IN      TXT     "delta"
epsilon   IN      TXT     "epsilon"
EOF

# 3. Validasi konfigurasi zone DNS agar tidak ada error
named-checkzone Kel33.com /etc/bind/db.Kel33.com

# 4. Restart layanan DNS (named)
service named restart

# 5. Uji coba di PRAB query TXT untuk memastikan berhasil mengembalikan hostname 
dig TXT alpha.Kel33.com