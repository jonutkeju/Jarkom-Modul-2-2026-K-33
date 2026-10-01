#PRAB
up echo -e '$TTL 604800\n@ IN SOA prab.Kel33.com. root.Kel33.com. ( 1 604800 86400 2419200 604800 )\n@ IN NS prab.Kel33.com.\n@ IN NS tedd.Kel33.com.\n2 IN PTR abbey.Kel33.com.' > /etc/bind/zones/db.10.80.3
up echo -e '$TTL 604800\n@ IN SOA prab.Kel33.com. root.Kel33.com. ( 1 604800 86400 2419200 604800 )\n@ IN NS prab.Kel33.com.\n@ IN NS tedd.Kel33.com.\n2 IN PTR penny.Kel33.com.' > /etc/bind/zones/db.10.80.4
up echo -e '$TTL 604800\n@ IN SOA prab.Kel33.com. root.Kel33.com. ( 1 604800 86400 2419200 604800 )\n@ IN NS prab.Kel33.com.\n@ IN NS tedd.Kel33.com.\n2 IN PTR prab.Kel33.com.\n3 IN PTR tedd.Kel33.com.\n4 IN PTR vault.Kel33.com.\n5 IN PTR desmond.Kel33.com.\n6 IN PTR core.Kel33.com.\n7 IN PTR molly.Kel33.com.' > /etc/bind/zones/db.10.80.5

#cek di client
#1. Menguji CNAME www:
nslookup www.Kel33.com
#2. Menguji CNAME static:
nslookup static.Kel33.com
#3. Menguji vault:
nslookup vault.Kel33.com
#4. Menguji core:
nslookup core.Kel33.com