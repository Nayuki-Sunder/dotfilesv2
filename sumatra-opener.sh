#!/usr/bin/env zsh

# 1. Configuration
NVIM="/home/nyxx/./nvim-linux-x86_64.appimage"
SOCKET="/tmp/nvimsocket"

# Check if nvr is in PATH, if not, hardcode it (adjust if needed)
NVR="nvr"
# If nvr command not found, try common install location:
if ! command -v nvr &> /dev/null; then
    NVR="/home/nyxx/anaconda3/envs/gen/bin/nvr"
fi

# 2. Get arguments
LINE="$1"
FILE="$2"

# 3. Sanitize Path (Backslashes to Slashes)
FILE="${FILE//\\//}"

# 4. Windows -> Linux Path Conversion
if [[ "$FILE" == [a-zA-Z]:* ]] || [[ "$FILE" == //* ]]; then
    if [[ "$FILE" == //* ]]; then
        WIN_PATH="${FILE//\//\\}"
        FILE=$(/bin/wslpath -u "$WIN_PATH")
    else
        FILE=$(/bin/wslpath -u "$FILE")
    fi
fi

# 5. The "Smart" Logic
# Check if the socket exists (meaning Neovim is open and listening)
if [ -S "$SOCKET" ]; then
    # Send command to existing instance
    "$NVR" --servername "$SOCKET" --remote-silent +$LINE "$FILE"
else
    # No instance found? Start a new one with the listener active
    exec "$NVIM" --listen "$SOCKET" +$LINE "$FILE"
fi
