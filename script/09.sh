# Conf ke Obladi dan Desmond
    up which apache2 || (rm -f /etc/resolv.conf && echo "nameserver 192.168.122.1" > /etc/resolv.conf && apt-get update && apt-get install -y apache2)
    up mkdir -p /var/www/html/arsip
    up touch /var/www/html/arsip/dokumen_obladi.txt /var/www/html/arsip/catatan_vault.txt
    up echo "Arsip Obladi Vault" > /var/www/html/arsip/info.txt
    up echo '<Directory /var/www/html/arsip>' > /etc/apache2/conf-available/arsip-autoindex.conf
    up echo '    Options +Indexes +FollowSymLinks' >> /etc/apache2/conf-available/arsip-autoindex.conf
    up echo '    AllowOverride None' >> /etc/apache2/conf-available/arsip-autoindex.conf
    up echo '    Require all granted' >> /etc/apache2/conf-available/arsip-autoindex.conf
    up echo '</Directory>' >> /etc/apache2/conf-available/arsip-autoindex.conf
    up a2enmod autoindex 2>/dev/null
    up a2enconf arsip-autoindex 2>/dev/null
    up /etc/init.d/apache2 restart 2>/dev/null

# Coba akses webnya dri klien bebas
curl -s http://obladi.Kel33.com/arsip/
curl -s http://desmond.Kel33.com/arsip/

# Outputnya kudu html