#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true

# Download Windows server files using SteamCMD
bash "${STEAMCMDDIR}/steamcmd.sh" +@sSteamCmdForcePlatformType windows \
				+force_install_dir "${STEAMAPPDIR}" \
				+login "anonymous" \
				+app_update "${STEAMAPPID}" validate \
				+quit

# Switch to server directory
cd "${STEAMAPPDIR}"

# Create config directories
mkdir -p "R5/Saved/SaveProfiles/Default/RocksDB"

# Generate ServerDescription.json
cat > "ServerDescription.json" << EOF
{
  "InviteCode": "${WR_INVITECODE}",
  "ServerName": "${WR_SERVERNAME}",
  "IsPasswordProtected": $([ -n "${WR_PASSWORD}" ] && echo "true" || echo "false"),
  "Password": "${WR_PASSWORD}",
  "WorldIslandId": "${WR_WORLDID}",
  "MaxPlayerCount": ${WR_MAXPLAYERS},
  "P2pProxyAddress": "0.0.0.0"
}
EOF

# Start virtual display for Wine
Xvfb :99 -screen 0 1024x768x16 &
sleep 2

# Start Server with Wine
wine WindroseServer.exe