#!/usr/bin/env bash
# Recreates the "decobosa" OpenVPN connection from a self-contained .ovpn
# export (certs embedded) and sets the cert passphrase non-interactively.
# No secrets live in this script or in git — it reads them from the backup
# folder at runtime.
#
# Requires: Documents/RSI restored first (the .ovpn and certPassword.txt
# live there, not in this repo — see the reinstall runbook).
#
# Usage: scripts/setup-vpn.sh [path-to-decobosa.ovpn]
set -euo pipefail

OVPN="${1:-$HOME/Documents/RSI/2025/decobosa-r5/decobosa/decobosa.ovpn}"
PASSFILE="$(dirname "$OVPN")/certPassword.txt"
NAME="$(basename "$OVPN" .ovpn)"   # "decobosa.ovpn" -> connection named "decobosa", matching the .zshrc alias

if [ ! -f "$OVPN" ]; then
  echo "Not found: $OVPN" >&2
  echo "Restore the Documents/RSI backup first." >&2
  exit 1
fi

if nmcli -t -f NAME connection show | grep -qx "$NAME"; then
  echo "Connection '$NAME' already exists — skipping import, just refreshing settings/secret."
else
  nmcli connection import type openvpn file "$OVPN"
  echo "Imported '$NAME'."
fi

if [ -f "$PASSFILE" ]; then
  nmcli connection modify "$NAME" vpn.secrets "cert-pass=$(cat "$PASSFILE")"
  echo "Cert passphrase set from $PASSFILE."
else
  echo "No certPassword.txt next to the .ovpn — you'll be prompted for the cert passphrase on first connect." >&2
fi

# Not preserved by `nmcli connection import` — set explicitly to match the original.
nmcli connection modify "$NAME" ipv4.dns-search uis.edu.co
nmcli connection modify "$NAME" connection.autoconnect yes

echo
echo "Done. Connect with: nmcli connection up $NAME  (or the 'vpn' alias in .zshrc)"
echo "You'll still be prompted for your VPN username/password — that's the MFA step, not something a script can supply."
