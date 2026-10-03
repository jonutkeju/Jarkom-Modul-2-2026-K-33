# Conf masing-masing node
    up hostname (nama node)
    up echo "(nama node)" > /etc/hostname

# Cek di node masing2
hostname
cat /etc/hostname
# Harusnya ada detail hostnya

# Cek di node manapun
for host in rootkit alpha beta gamma delta epsilon abbey penny obladi desmond oblada molly; do
    echo -n "$host.Kel33.com -> "; dig +short $host.Kel33.com A
done
# Harusnya ada IP masing-masing node sesuai soal