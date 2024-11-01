#!/bin/bash

# GoDaddy API credentials
API_KEY="h1okCf5NCjpb_G7fc2KGSt1oKUxAfG5x48d"
API_SECRET="HZcaigcV5VqZx3idQNdFUp"
DOMAIN="itay-noa.online"

# New data for the CNAME records from the Jenkins environment variable
LOAD_BALANCER_DNS="$LOAD_BALANCER_DNS"

# Function to update a CNAME record's data
update_cname() {
    local subdomain=$1

    curl -X PUT "https://api.godaddy.com/v1/domains/${DOMAIN}/records/CNAME/${subdomain}" \
        -H "Authorization: sso-key ${API_KEY}:${API_SECRET}" \
        -H "Content-Type: application/json" \
        -d "[{\"data\": \"${LOAD_BALANCER_DNS}\", \"ttl\": 600}]"
}

# Update both CNAME records to point to the same load balancer
update_cname "grafana"
update_cname "statuspage"
