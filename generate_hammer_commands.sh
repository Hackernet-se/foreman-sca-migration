#!/bin/bash

# Set PAT and base URL
FOREMAN_URL="https://<url to foreman>"
PAT="not-actual-pat"  # Replace with actual PAT

# Get all hosts
curl -s --user $USER:$PAT "$FOREMAN_URL/api/hosts?thin=true&per_page=all" | jq -r '.results[] | "\(.id) \(.name)"' | while read host_id hostname; do
    # Get enabled repositories for each host
    curl -s --user $USER:$PAT "$FOREMAN_URL/api/hosts/$host_id/subscriptions/enabled_repositories" | \
    jq -r '.results[].content_label' | while read content_label; do
        echo "hammer host subscription content-override --content-label \"$content_label\" --host $hostname --value 1"
    done
done > hammer_commands.txt

echo "Hammer commands generated in hammer_commands.txt"
