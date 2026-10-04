# Conf di Masing-masing klien
    up rm -f /etc/resolv.conf && echo "nameserver 192.168.122.1" > /etc/resolv.conf

# Ngecek di klien terkait
cat /etc/resolv.conf

# Kalo nampilin IP dari nameservernya (Ada 3 karna tambahan dari
# soal-soal selanjutnya, berarti aman)