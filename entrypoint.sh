#!/bin/bash
cd /home/container || exit 1

# Check for automatic updates on startup
if [ "${AUTO_UPDATE_CARDS}" == "1" ]; then
    echo "[Update] Auto-update is enabled. Fetching latest databases..."
    
    if [ -n "${CARDS_URL}" ]; then
        echo "[Update] Downloading cards.xml..."
        curl -sSL -o /home/container/cards.xml "${CARDS_URL}"
    fi

    if [ -n "${TOKENS_URL}" ]; then
        echo "[Update] Downloading tokens.xml..."
        curl -sSL -o /home/container/tokens.xml "${TOKENS_URL}"
    fi
    
    echo "[Update] Database update complete."
fi

# Replace variables in the Pterodactyl startup command
PARSED_CMD=$(echo -e "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')

echo -e ":/home/container$ ${PARSED_CMD}"
exec env ${PARSED_CMD}
