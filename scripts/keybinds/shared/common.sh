function load_lua_vars() {
    local file="$1"

    MAINMOD=$(grep -oP 'local mainMod = "\K[^"]+' "$file")

    local scripts_suffix rofi_suffix waybar_suffix
    scripts_suffix=$(grep -oP 'local scripts\s*= home \.\. "\K[^"]+' "$file")
    rofi_suffix=$(grep -oP 'local rofi\s*= home \.\. "\K[^"]+' "$file")
    waybar_suffix=$(grep -oP 'local waybar\s*= home \.\. "\K[^"]+' "$file")

    HOME_VAL="~"
    SCRIPTS_VAL="~${scripts_suffix}"
    ROFI_VAL="~${rofi_suffix}"
    WAYBAR_VAL="~${waybar_suffix}"

    export MAINMOD HOME_VAL SCRIPTS_VAL ROFI_VAL WAYBAR_VAL
}

function awk_parse_bind() {
    local prefix="${1:-}"
    awk \
        -v mainMod="$MAINMOD" \
        -v home_val="$HOME_VAL" \
        -v scripts_val="$SCRIPTS_VAL" \
        -v rofi_val="$ROFI_VAL" \
        -v waybar_val="$WAYBAR_VAL" \
        -v prefix="$prefix" '
    {
        sub(/^[[:space:]]+/, "")

        match($0, /^hl\.bind\((.*)\)[[:space:]]*$/, arr)
        params = arr[1]

        comma = index(params, ",")
        keybind = substr(params, 1, comma - 1)
        action  = substr(params, comma + 1)

        gsub(/^[[:space:]]+|[[:space:]]+$/, "", keybind)
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", action)

        # Resolve keybind
        gsub(/mainMod[[:space:]]*\.\.[[:space:]]*/, mainMod, keybind)
        gsub(/"/, "", keybind)
        sub(/^XF86Audio/, "", keybind)
        sub(/^XF86/, "", keybind)
        gsub(/\.\. key/, "[0-9]", keybind)
        gsub(/\.\./, "", keybind)
        gsub(/[[:space:]]{2,}/, " ", keybind)

        # Unwrap hl.dsp.exec_cmd(...)
        if (match(action, /^[[:space:]]*hl\.dsp\.exec_cmd\((.*)\)[[:space:]]*(,.*)?$/, m)) {
            action = m[1]
            if (match(action, /^"(.*)"$/, q)) {
                action = q[1]
            }
        }

        # Resolve Lua variables in action
        gsub(/scripts/, scripts_val, action)
        gsub(/rofi/,    rofi_val,    action)
        gsub(/waybar/,  waybar_val,  action)
        gsub(/home/,    home_val,    action)

        # Clean up Lua concat syntax and quotes
        gsub(/[[:space:]]*\.\.[[:space:]]*/, "", action)
        gsub(/"/, "", action)
        gsub(/[[:space:]]{2,}/, " ", action)

        print prefix keybind ";" action
    }
    '
}