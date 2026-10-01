### SOAL 6
Saat ini file zona baru berisi prab, tedd, dan Apex Kel33.com. Sesuai Soal 5 dan 7, kamu perlu mendaftarkan seluruh host (alpha, beta, gamma, delta, epsilon, abbey, penny, obladi, desmond, oblada, molly), serta record tambahan (vault, core, www, static).   Ganti bagian up echo -e '$TTL ...' di konfigurasi interfaces prab menjadi mencakup seluruh record tersebut (sesuaikan IP dengan hasil subnetting kelompokmu):
```
up echo -e '$TTL 604800\n@ IN SOA prab.Kel33.com. root.Kel33.com. ( 3 604800 86400 2419200 604800 )\n@ IN NS prab.Kel33.com.\n@ IN NS tedd.Kel33.com.\n@ IN A 10.80.4.2\nprab IN A 10.80.5.2\ntedd IN A 10.80.5.3\nrootkit IN A 10.80.1.1\nalpha IN A 10.80.1.2\nbeta IN A 10.80.1.3\ngamma IN A 10.80.1.4\ndelta IN A 10.80.2.2\nepsilon IN A 10.80.2.3\nabbey IN A 10.80.3.2\npenny IN A 10.80.4.2\nobladi IN A 10.80.5.4\ndesmond IN A 10.80.5.5\noblada IN A 10.80.5.6\nmolly IN A 10.80.5.7\nvault IN A 10.80.5.4\ncore IN A 10.80.5.6\nwww IN CNAME penny.Kel33.com.\nstatic IN CNAME abbey.Kel33.com.' > /etc/bind/zones/db.Kel33.com
```
Lakukan pengujian dari terminal klien (alpha atau penny) untuk memastikan sinkronisasi sukses:
```
dig @10.80.5.2 Kel33.com soa
dig @10.80.5.3 Kel33.com soa
```
![alpha](assets/soal6(2).png)
![penny](assets/soal6(1).png)

### SOAL 7
Buka terminal pada salah satu klien (misalnya alpha atau klien lainnya), lalu jalankan perintah nslookup untuk menguji semua record yang diminta di soal:
1. Menguji CNAME www:
```
nslookup www.Kel33.com
```
2. Menguji CNAME static:
```
nslookup static.Kel33.com
```
3. Menguji vault:
```
nslookup vault.Kel33.com
```
4. Menguji core:
```
nslookup core.Kel33.com
```
![alt text](assets/soal7.png)

### SOAL 8
Kita perlu menambahkan deklarasi reverse zone ke file /etc/bind/named.conf.local dan membuat file database PTR-nya di direktori /etc/bind/zones/.
Berdasarkan subnet node-node tersebut (penny di 10.80.4.x, abbey di 10.80.3.x, serta vault & core di 10.80.5.x), kita buat reverse zone untuk segmen-segmen tersebut. Di dalam konfigurasi interfaces prab, tambahkan deklarasi zona dan isi file PTR-nya.
```
# Deklarasi Reverse Zone di named.conf.local
    up echo 'zone "3.80.10.in-addr.arpa" { type master; file "/etc/bind/zones/db.10.80.3"; notify yes; allow-transfer { 10.80.5.3; }; };' >> /etc/bind/named.conf.local
    up echo 'zone "4.80.10.in-addr.arpa" { type master; file "/etc/bind/zones/db.10.80.4"; notify yes; allow-transfer { 10.80.5.3; }; };' >> /etc/bind/named.conf.local
    up echo 'zone "5.80.10.in-addr.arpa" { type master; file "/etc/bind/zones/db.10.80.5"; notify yes; allow-transfer { 10.80.5.3; }; };' >> /etc/bind/named.conf.local

# Pembuatan File Database PTR untuk Abbey, Penny, Vault, dan Core
    up echo -e '$TTL 604800\n@ IN SOA prab.Kel33.com. root.Kel33.com. ( 1 604800 86400 2419200 604800 )\n@ IN NS prab.Kel33.com.\n@ IN NS tedd.Kel33.com.\n2 IN PTR abbey.Kel33.com.' > /etc/bind/zones/db.10.80.3
    up echo -e '$TTL 604800\n@ IN SOA prab.Kel33.com. root.Kel33.com. ( 1 604800 86400 2419200 604800 )\n@ IN NS prab.Kel33.com.\n@ IN NS tedd.Kel33.com.\n2 IN PTR penny.Kel33.com.' > /etc/bind/zones/db.10.80.4
    up echo -e '$TTL 604800\n@ IN SOA prab.Kel33.com. root.Kel33.com. ( 1 604800 86400 2419200 604800 )\n@ IN NS prab.Kel33.com.\n@ IN NS tedd.Kel33.com.\n2 IN PTR prab.Kel33.com.\n3 IN PTR tedd.Kel33.com.\n4 IN PTR vault.Kel33.com.\n5 IN PTR desmond.Kel33.com.\n6 IN PTR core.Kel33.com.\n7 IN PTR molly.Kel33.com.' > /etc/bind/zones/db.10.80.5
```
Setelah itu, langsung tes kembali di terminal prab:
```
dig @10.80.5.2 -x 10.80.5.4

```
![alt text](assets/soal8.png)