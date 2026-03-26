#!/usr/bin/env bash


# shellcheck source=/home/pncolvr/Projects/scripts/rofi/web/common/utils.sh
source "$HOME"/Projects/scripts/rofi/web/common/utils.sh
source "$HOME/.config/hypr/screen/common/utils.sh"

declare -A paths

paths["Computer"]="computer:///"
paths["Desktop"]="$HOME/Desktop"
paths["Downloads"]="$HOME/Downloads"
paths["Books"]="$HOME/Books"
paths["Documents"]="$HOME/Documents"
paths["Local/share"]="$HOME/.local/share"
paths["Music"]="$HOME/Music"
paths["Pictures"]="$HOME/Pictures"
paths["Steam compatdata"]="$HOME/.local/share/Steam/steamapps/compatdata/"
paths["Trash"]="trash:///"
paths["Videos"]="$HOME/Videos"
paths["Home"]="$HOME"
paths["Tardis"]="/mnt/Tardis"
paths["Trantor"]="/mnt/Trantor"
paths["Mirabilis"]="/mnt/Mirabilis"
paths["SobeckStash"]="/mnt/SobeckStash"


if [[ $1 == "include-work" ]]; then
    workFolder="$HOME/Projects/bizdocs"
    paths["Bizdocs"]="$workFolder"
    paths["Bizdocs docs test"]="$workFolder/docs/docsteste/"
    paths["Bizdocs downloads"]="$workFolder/downloads"
    paths["Bizdocs repos"]="$workFolder/repos"
    #shellcheck disable=2034
    paths["Bizdocs rheia downloads"]="$workFolder/repos/rheia/SQLFiles/scripts/downloads/"
fi

TEMP_DIR="${XDG_RUNTIME_DIR:-${TMPDIR:-/tmp}}"
file="$TEMP_DIR"/files_shortcuts

save_assoc_array "paths" "$file"

chosen=$("$HOME"/Projects/scripts/rofi/web/common/handle.sh "$file" "open" output)

if [[ -n $chosen ]]; then 
    openFileExplorer "$chosen"
fi
