# [JALANKAN DI KLIEN ex: ALPHA]
# 1. Update repository dan instal paket apache2-utils (jika belum terinstal)
apt-get update && apt-get install -y apache2-utils

# [JALANKAN DI KLIEN ex: ALPHA]
# 2. Jalankan uji beban (Benchmarking) ke domain utama (Proxy ke Vault Cluster via Penny)
# -n 250 : total 250 request yang dikirimkan
# -c 10  : 10 request bersamaan (concurrent) per waktu
ab -n 250 -c 10 http://www.Kel33.com/

# [JALANKAN DI KLIEN ex: ALPHA]
# 3. Jalankan uji beban ke path statis Orion (via Abbey / Static)
ab -n 250 -c 10 http://static.Kel33.com/orion/