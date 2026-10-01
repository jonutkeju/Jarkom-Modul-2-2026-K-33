# Conf di Prab
    up which named || (apt-get update && apt-get install -y bind9 bind9-dnsutils)
    up mkdir -p /etc/bind/zones
    up /etc/init.d/named restart 2>/dev/null || /etc/init.d/bind9 restart 2>/dev/null

# Conf di Tedd
    up which named || (apt-get update && apt-get install -y bind9 bind9-dnsutils)
    up /etc/init.d/named restart 2>/dev/null || /etc/init.d/bind9 restart 2>/dev/null

# Test BIN9 di Prab or Tedd
named -v
/etc/init.d/named status || /etc/init.d/bind9 status

# Kalo versi ada dan statusnya running berarti aman banget geloo