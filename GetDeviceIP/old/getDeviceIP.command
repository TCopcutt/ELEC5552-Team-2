#!/bin/bash
cd "$(dirname "$0")"
python3 ipgetter.py
echo "Exiting."

# give mac address, get IP or say cant find,
# open the web configuration