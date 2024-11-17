#!/bin/bash
cat /etc/hosts | while read -r ip name _; do
    if [[ "$ip" == \#* || -z "$ip" || -z "$name" ]]; then
        continue
    fi
    resolved_ip=$(nslookup "$name" 2>/dev/null | awk '/^Address: / {print $2}' | tail -n1)
    if [[ -n "$resolved_ip" && "$resolved_ip" != "$ip" ]]; then
        echo "Bogus IP for $name in /etc/hosts!"
    fi
done
