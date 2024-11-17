#!/bin/bash

validate_host_entry() {
    local ip="$1"
    local name="$2"

    if [[ "$ip" == \#* || -z "$ip" || -z "$name" ]]; then
        return
    fi

    local resolved_ip
    resolved_ip=$(nslookup "$name" 2>/dev/null | awk '/^Address: / {print $2}' | tail -n1)

    if [[ -n "$resolved_ip" && "$resolved_ip" != "$ip" ]]; then
        echo "Bogus IP for $name in /etc/hosts!"
    fi
}

while read -r ip name _; do
    validate_host_entry "$ip" "$name"
done < /etc/hosts

