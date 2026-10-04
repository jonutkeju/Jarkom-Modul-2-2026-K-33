# Conf ke Penny
    up which htpasswd || (rm -f /etc/resolv.conf && echo "nameserver 192.168.122.1" > /etc/resolv.conf && apt-get update && apt-get install -y apache2-utils)
    up mkdir -p /var/www/penny/admin
    up echo "<h1>Dokumen Rahasia Sindikat Penny</h1><p>Akses berhasil diberikan ke path rahasia /admin.</p>" > /var/www/penny/admin/index.html
    up htpasswd -bc /etc/apache2/.htpasswd prabs 'pakar_pinter_jadi_gob***' 2>/dev/null
    up a2enmod auth_basic authn_file authz_user 2>/dev/null
    up echo '    Alias /admin /var/www/penny/admin' >> /etc/apache2/sites-available/vault-proxy.conf
    up echo '    <Directory /var/www/penny/admin>' >> /etc/apache2/sites-available/vault-proxy.conf
    up echo '        AuthType Basic' >> /etc/apache2/sites-available/vault-proxy.conf
    up echo '        AuthName "Restricted Admin Area"' >> /etc/apache2/sites-available/vault-proxy.conf
    up echo '        AuthUserFile /etc/apache2/.htpasswd' >> /etc/apache2/sites-available/vault-proxy.conf
    up echo '        Require valid-user' >> /etc/apache2/sites-available/vault-proxy.conf
    up echo '    </Directory>' >> /etc/apache2/sites-available/vault-proxy.conf
    up echo '    ProxyPass /admin !' >> /etc/apache2/sites-available/vault-proxy.conf

# Test authorizationnya ke klien bebas
# Uji tanpa auth
curl -i http://www.Kel33.com/admin/
# Uji kalo pwnya salah
curl -i -u prabs:'pakar_pinter_beneran_pinter' http://www.Kel33.com/admin/
# Uji dengan auth
curl -i -u prabs:'pakar_pinter_jadi_gob***' http://www.Kel33.com/admin/
# Yang pertama harusnya 401 Unauthorized, yang ketiga kudu 200 OK