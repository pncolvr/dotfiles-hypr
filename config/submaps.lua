local home = os.getenv("HOME")
local scripts = home .. "/.config/hypr/scripts"
local rofi    = home .. "/.config/rofi/scripts"
local waybar  = home .. "/.config/waybar/scripts"

hl.define_submap("resize", function()
    hl.bind("l", hl.resize({ x = 10, y = 0, relative = true}), { repeating = true })
    hl.bind("h", hl.resize({ x = -10, y = 0, relative = true}), { repeating = true })
    hl.bind("k", hl.resize({ x = 0, y = 10, relative = true}), { repeating = true })
    hl.bind("j", hl.resize({ x = 0, y = -10, relative = true}), { repeating = true })

    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("catchall", hl.dsp.submap("reset"))
end)


hl.define_submap("notes", function()
    hl.bind("t", hl.dsp.exec_cmd(scripts .. "/floating-notes.sh random"))
    hl.bind("w", hl.dsp.exec_cmd(scripts .. "/floating-notes.sh work"))
    hl.bind("p", hl.dsp.exec_cmd(scripts .. "/floating-notes.sh personal"))

    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("catchall", hl.dsp.submap("reset"))
end)

hl.define_submap("tools", function()
    hl.bind("c", hl.dsp.exec_cmd("hyprpicker -an"))
    hl.bind("d", hl.dsp.exec_cmd(scripts .. "/tools/currentdate.sh"))
    hl.bind("e", hl.dsp.exec_cmd(scripts .. "/tools/encode-qrcode.sh"))
    hl.bind("g", hl.dsp.exec_cmd(scripts .. "/tools/uuidgen.sh"))
    hl.bind("m", hl.dsp.exec_cmd('ghostty --title="musicplayer" -e rmpc'))
    hl.bind("n", hl.dsp.exec_cmd(scripts .. "/tools/ptvatid/create.sh"))
    hl.bind("o", hl.dsp.exec_cmd(scripts .. "/screen/shot.sh ocr"))
    hl.bind("p", hl.dsp.exec_cmd(scripts .. "/toggle/pin.sh"))
    hl.bind("q", hl.dsp.exec_cmd(scripts .. "/screen/shot.sh qrcode"))
    hl.bind("u", hl.dsp.exec_cmd("uxplay"))
    hl.bind("w", hl.dsp.exec_cmd('ghostty --title="wallpapers" -e "' .. scripts .. '/wallpapers/picker.sh ' .. home .. '/Pictures/wallpapers/"'))

    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("catchall", hl.dsp.submap("reset"))
end)