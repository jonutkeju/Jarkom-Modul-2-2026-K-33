#LANGKAH 1: Konfigurasi di Node penny (Path /eternal + PHP)
#PENNY
mkdir -p /var/www/html/eternal
echo '<?php echo "Selamat! Web Eternal Berhasil Jalan!"; ?>' > /var/www/html/eternal/index.php

apt-get update && apt-get install -y php8.4-fpm nginx

cat << 'EOF' > /etc/nginx/sites-available/default
server {
    listen 80;
    server_name Kel33.com;

    location /eternal {
        root /var/www/html;
        index index.php index.html index.htm;
        try_files $uri $uri/ =404;

        location ~ \.php$ {
            include snippets/fastcgi-php.conf;
            fastcgi_pass unix:/run/php/php8.4-fpm.sock;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }
    }

    location / {
        proxy_pass http://10.80.5.4;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF

killall -9 nginx 2>/dev/null || true
/etc/init.d/php8.4-fpm start
/etc/init.d/nginx start

#cek
curl -i -H "Host: Kel33.com" http://10.80.4.2/eternal/index.php

#ABBEY
mkdir -p /var/www/orion
echo '<h1>Selamat! Konten Statis Orion Berhasil Jalan!</h1>' > /var/www/orion/index.html

cat << 'EOF' > /etc/nginx/sites-available/default
server {
    listen 80;
    server_name abbey localhost;

    location /orion {
        alias /var/www/orion/;
        index index.html index.htm;
        try_files $uri $uri/ =404;
    }
}
EOF

ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
killall -9 nginx 2>/dev/null || true
nginx -t && /etc/init.d/nginx restart

#cek
curl -i http://localhost/orion/index.html