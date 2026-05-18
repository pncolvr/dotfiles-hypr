local home = os.getenv("HOME")

hl.on("hyprland.start", function () 
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("quickshell")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("pcmanfm-qt -d")
  hl.exec_cmd("swww-daemon")
  hl.exec_cmd("copyq --start-server")
  hl.exec_cmd("udiskie --no-automount --tray")
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("firewall-applet")
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd(home .. "/.config/conky/start.sh")
  hl.exec_cmd(home .. "/.config/zsh/scripts/status/manager.sh --log-system-event active")
  hl.exec_cmd(home .. "/.config/hypr/scripts/wallpapers/default.sh")
end)


