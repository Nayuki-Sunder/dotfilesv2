#!/usr/bin/env zsh

# 1. Your Neovim Location
NVIM="/home/nyxx/nvim-linux-x86_64.appimage"

# 2. Get arguments
LINE="$1"
FILE="$2"

# 3. Sanitize: Force all backslashes (\) to forward slashes (/)
#    This ensures we have a consistent format regardless of quoting.
FILE="${FILE//\\//}"

# 4. Check if it's a Windows Path that needs conversion.
#    Condition 1: Starts with a Drive Letter (e.g. C:/)
#    Condition 2: Starts with a Network double-slash (e.g. //wsl.localhost/)
if [[ "$FILE" == [a-zA-Z]:* ]] || [[ "$FILE" == //* ]]; then

    # Special handling for Network paths (//wsl...)
    # wslpath requires backslashes to recognize a network share correctly.
    if [[ "$FILE" == //* ]]; then
        # Convert forward slashes back to backslashes just for wslpath
        WIN_PATH="${FILE//\//\\}"
        FILE=$(/bin/wslpath -u "$WIN_PATH")
    else
        # Standard C:/ paths work fine with forward slashes
        FILE=$(/bin/wslpath -u "$FILE")
    fi
fi

# 5. Open Neovim
exec "$NVIM" +$LINE "$FILE"
