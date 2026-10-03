# Conf ke Oblada & Molly
    up which nginx || (rm -f /etc/resolv.conf && echo "nameserver 192.168.122.1" > /etc/resolv.conf && apt-get update && apt-get install -y nginx php-fpm)
    up mkdir -p /var/www/core
    up echo '<?php echo "<h1>Beranda Core - Oblada</h1><p>Selamat datang di layanan web dinamis Core.</p>"; ?>' > /var/www/core/index.php
    up echo '<?php echo "<h1>Profil Core - Oblada</h1><p>Halaman profil berhasil diakses via rewrite clean URL tanpa .php</p>"; ?>' > /var/www/core/profil.php
    up /etc/init.d/php*-fpm start 2>/dev/null
    up sh -c 'SOCK=$(ls /run/php/php*-fpm.sock | head -n 1); echo "server { listen 80; server_name core.Kel33.com oblada.Kel33.com; root /var/www/core; index index.php index.html; location / { try_files \$uri \$uri/ \$uri.php?\$args; } location ~ \.php\$ { include snippets/fastcgi-php.conf; fastcgi_pass unix:$SOCK; } }" > /etc/nginx/sites-available/core'
    up rm -f /etc/nginx/sites-enabled/default
    up ln -sf /etc/nginx/sites-available/core /etc/nginx/sites-enabled/core
    up /etc/init.d/php*-fpm restart 2>/dev/null
    up /etc/init.d/nginx restart 2>/dev/null

# Cek lewat klien bebas
curl -s http://oblada.Kel33.com/
curl -s http://oblada.Kel33.com/profil
curl -s http://molly.Kel33.com/
curl -s http://molly.Kel33.com/profil

# Outputnya juga html, yang penting jangan error