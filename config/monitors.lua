--resolution and position
hl.monitor({
    output   = "DP-1",
    mode     = "2560x1440@144",
    position = "0x0",
    scale    = 1,
})

-- workspace affinity
for i = 1, 10 do
    local key = i % 10
    hl.workspace_rule({ workspace = tostring(key), monitor = "DP-1", persistent = true })
end


