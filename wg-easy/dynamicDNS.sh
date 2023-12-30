#!/bin/bash

# Load variables from .env file
if [[ -f .env ]]; then
    source .env
    echo "Variables loaded from .env file"
else
    echo "Error: .env file not found"
    exit 1
fi

## Get the current public IP address
IP=$(curl -s https://cloudflare.com/cdn-cgi/trace | grep -E '^ip' | cut -d = -f 2)

echo "Current IP: $IP"

## Get the current IP address on Cloudflare
CF_IP=$(curl -s "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/dns_records?type=A&name=$DOMAIN" \
    -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
    -H "X-Auth-Key: $CLOUDFLARE_API_KEY" \
    -H "Content-Type: application/json" |
    jq -r '.result[0].content')

echo "Current Cloudflare IP: $CF_IP"

## Update the IP address on Cloudflare if it has changed
if [ "$IP" != "$CF_IP" ]; then
    RECORD_ID=$(curl -s "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/dns_records?type=A&name=$DOMAIN" \
        -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
        -H "X-Auth-Key: $CLOUDFLARE_API_KEY" \
        -H "Content-Type: application/json" |
        jq -r '.result[0].id')

    RESULT=$(curl -s https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/dns_records/$RECORD_ID \
        -X PUT \
        -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
        -H "X-Auth-Key: $CLOUDFLARE_API_KEY" \
        -H "Content-Type: application/json" \
        --data "{\"type\":\"A\",\"name\":\"$DOMAIN\",\"content\":\"$IP\"}" |
        jq -r '.success')

    echo $RESULT

    if [ "$RESULT" = "true" ]; then
        echo "You IP was updated to $IP"
    else
        echo "An error occured - You IP was not updated"
    fi

fi

echo "No changes - DNS A record already set to $IP"
