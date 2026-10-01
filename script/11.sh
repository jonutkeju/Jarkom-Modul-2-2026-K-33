# Conf ke Abbey
    up echo 'upstream core_cluster {' > /etc/nginx/sites-available/core-proxy
    up echo '    server 10.80.5.6:80;' >> /etc/nginx/sites-available/core-proxy
    up echo '    server 10.80.5.7:80;' >> /etc/nginx/sites-available/core-proxy
    up echo '}' >> /etc/nginx/sites-available/core-proxy
    up echo 'server {' >> /etc/nginx/sites-available/core-proxy
    up echo '    listen 80;' >> /etc/nginx/sites-available/core-proxy
    up echo '    server_name static.Kel33.com;' >> /etc/nginx/sites-available/core-proxy
    up echo '    location / {' >> /etc/nginx/sites-available/core-proxy
    up echo '        proxy_pass http://core_cluster;' >> /etc/nginx/sites-available/core-proxy
    up echo '        proxy_set_header Host $host;' >> /etc/nginx/sites-available/core-proxy
    up echo '        proxy_set_header X-Real-IP $remote_addr;' >> /etc/nginx/sites-available/core-proxy
    up echo '        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;' >> /etc/nginx/sites-available/core-proxy
    up echo '    }' >> /etc/nginx/sites-available/core-proxy
    up echo '}' >> /etc/nginx/sites-available/core-proxy
    up ln -sf /etc/nginx/sites-available/core-proxy /etc/nginx/sites-enabled/core-proxy
    up /etc/init.d/nginx restart 2>/dev/null

# Conf ke Penny
    up a2enmod proxy proxy_http proxy_balancer lbmethod_byrequests headers 2>/dev/null
    up echo '<VirtualHost *:80>' > /etc/apache2/sites-available/vault-proxy.conf
    up echo '    ServerName www.Kel33.com' >> /etc/apache2/sites-available/vault-proxy.conf
    up echo '    ServerAlias Kel33.com' >> /etc/apache2/sites-available/vault-proxy.conf
    up echo '    ProxyPreserveHost On' >> /etc/apache2/sites-available/vault-proxy.conf
    up echo '    RequestHeader set X-Real-IP "%{REMOTE_ADDR}e"' >> /etc/apache2/sites-available/vault-proxy.conf
    up echo '    <Proxy balancer://vaultcluster>' >> /etc/apache2/sites-available/vault-proxy.conf
    up echo '        BalancerMember http://10.80.5.4:80' >> /etc/apache2/sites-available/vault-proxy.conf
    up echo '        BalancerMember http://10.80.5.5:80' >> /etc/apache2/sites-available/vault-proxy.conf
    up echo '    </Proxy>' >> /etc/apache2/sites-available/vault-proxy.conf
    up echo '    ProxyPass / balancer://vaultcluster/' >> /etc/apache2/sites-available/vault-proxy.conf
    up echo '    ProxyPassReverse / balancer://vaultcluster/' >> /etc/apache2/sites-available/vault-proxy.conf
    up echo '</VirtualHost>' >> /etc/apache2/sites-available/vault-proxy.conf
    up a2ensite vault-proxy 2>/dev/null
    up /etc/init.d/apache2 restart 2>/dev/null

# Conf ke Obladi & Desmond
    up mkdir -p /var/log/apache2
    up sed -i 's/LogFormat "%h %l %u %t \\"%r\\" %>s %O/LogFormat "%h (%{X-Forwarded-For}i) %l %u %t \\"%r\\" %>s %O/g' /etc/apache2/apache2.conf
    up /etc/init.d/apache2 restart 2>/dev/null

# Conf ke Oblada & Molly
    up echo '<?php print_r(getallheaders()); ?>' > /var/www/core/headers.php

# Test Load Balancingnya lewat klien bebas
for i in {1..4}; do curl -s http://static.Kel33.com/profil | grep -o "Profil Core - [^<]*"; sleep 0.2; done
for i in {1..4}; do curl -s http://www.Kel33.com/arsip/ | grep -o "dokumen_[^.]*"; sleep 0.2; done
# Hasilnya kudu ganti-ganti karna robin bulat


# Test Header Core, juga bebas di klien mana
curl -s http://static.Kel33.com/headers.php
# Harusnya si penny yang muncul 


# Test Log Vault ke si Desmond
curl -s http://www.Kel33.com/arsip/   # dari klien bebas
tail -n 2 /var/log/apache2/access.log  # dari desmond
# Harusnya IP yang ngakses muncul di desmond