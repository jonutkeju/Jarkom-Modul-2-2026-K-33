# Conf ke Penny
    up a2enmod rewrite 2>/dev/null
    up echo '<VirtualHost *:80>' > /etc/apache2/sites-available/redirect-penny.conf
    up echo '    ServerName penny.Kel33.com' >> /etc/apache2/sites-available/redirect-penny.conf
    up echo '    ServerAlias 10.80.4.2' >> /etc/apache2/sites-available/redirect-penny.conf
    up echo '    RewriteEngine On' >> /etc/apache2/sites-available/redirect-penny.conf
    up echo '    RewriteRule ^(.*)$ http://www.Kel33.com$1 [R=301,L]' >> /etc/apache2/sites-available/redirect-penny.conf
    up echo '</VirtualHost>' >> /etc/apache2/sites-available/redirect-penny.conf
    up a2ensite redirect-penny 2>/dev/null
    up /etc/init.d/apache2 restart 2>/dev/null

# Conf ke Abbey
    up echo 'server {' >> /etc/nginx/sites-available/core-proxy
    up echo '    listen 80;' >> /etc/nginx/sites-available/core-proxy
    up echo '    server_name abbey.Kel33.com 10.80.3.2;' >> /etc/nginx/sites-available/core-proxy
    up echo '    return 302 http://static.Kel33.com$request_uri;' >> /etc/nginx/sites-available/core-proxy
    up echo '}' >> /etc/nginx/sites-available/core-proxy
    up /etc/init.d/nginx restart 2>/dev/null

# Test Redirectionnya lewat Klien Bebas
# Uji Penny:
curl -I http://penny.Kel33.com/
curl -I http://10.80.4.2/
# Uji Abbey:
curl -I http://abbey.Kel33.com/
curl -I http://10.80.3.2/
# Harusnya Permintaan ke Penny mengembalikan 
# header HTTP/1.1 301 Moved Permanently dengan Location: [http://www.Kel33.com/](http://www.Kel33.com/),
# sedangkan permintaan ke Abbey mengembalikan 
# header HTTP/1.1 302 Moved Temporarily dengan Location: [http://static.Kel33.com/](http://static.Kel33.com/).
