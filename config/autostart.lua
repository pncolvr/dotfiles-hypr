hl.on("hyprland.start", function () 
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("quickshell")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("pcmanfm-qt -d")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("udiskie --no-automount --tray")
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("firewall-applet")
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)


