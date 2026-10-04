# PENNY
#!/bin/bash
apt update && apt install -y apache2 nginx

# Konfigurasi Nginx Reverse Proxy ke Obladi (10.80.5.4)
cat << 'EOF' > /etc/nginx/sites-available/default
server {
    listen 80;
    server_name Kel33.com;

    location / {
        proxy_pass http://10.80.5.4; 
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
     }
}
EOF

# Matikan proses yang tabrakan port jika ada, lalu jalankan Nginx
nginx -t && systemctl restart nginx || {
    # Fallback jika port 80 masih terpakai process lain
    pkill -f apache2
    systemctl restart nginx
}

#ABBEY
#!/bin/bash
apt update && apt install -y apache2 nginx

# Konfigurasi Nginx Reverse Proxy ke Desmond (10.80.5.6)
cat << 'EOF' > /etc/nginx/sites-available/default
server {
    listen 80;
    server_name Kel33.com;

    location / {
        proxy_pass http://10.80.5.6;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF

nginx -t && /etc/init.d/nginx restart

#Konfigurasi di Server Backend Area Vault (obladi/desmond) & Core (oblada/molly)
#OBLADI & DESMOND
#!/bin/bash
apt update && apt install -y apache2 nginx

# Tambahkan custom log format ke nginx.conf jika belum ada
if ! grep -q "custom_log" /etc/nginx/nginx.conf; then
    sed -i '/http {/a \    log_format custom_log \x27$http_x_forwarded_for - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent"\x27;' /etc/nginx/nginx.conf
fi

# Konfigurasi sites-available default
cat << 'EOF' > /etc/nginx/sites-available/default
server {
    listen 80;
    server_name Kel33.com;

    access_log /var/log/nginx/access.log custom_log;

    location / {
        root /var/www/html;
        index index.html index.htm;
    }
}
EOF

# Hentikan proses yang bentrok port, lalu restart Nginx
pkill -f apache2
nginx -t && /etc/init.d/nginx restart

#OBLADA & MOLLY
#!/bin/bash
# Tambahkan custom log format ke nginx.conf jika belum ada
if ! grep -q "custom_log" /etc/nginx/nginx.conf; then
    sed -i '/http {/a \    log_format custom_log \x27$http_x_forwarded_for - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent"\x27;' /etc/nginx/nginx.conf
fi

# Konfigurasi sites-available default
cat << 'EOF' > /etc/nginx/sites-available/default
server {
    listen 80;
    server_name Kel33.com;

    access_log /var/log/nginx/access.log custom_log;

    location / {
        root /var/www/html;
        index index.html index.htm;
    }
}
EOF

nginx -t && /etc/init.d/nginx restart

#PENGUJIAN
#akses dari client ALPHA
curl http://Kel33.com

#pantau akses secara real-time di server backend (obladi, desmond, oblada, molly)
tail -f /var/log/nginx/access.log
