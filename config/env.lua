hl.env("XCURSOR_THEME", "Breeze_Light")
hl.env("XCURSOR_SIZE", "24")

-- nvidia
hl.env("NVD_BACKEND", "direct")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
-- hl.env("WLR_NO_HARDWARE_CURSORS", 1)

-- path 
hl.env("PATH", "/bin:/usr/bin:/usr/local/bin:/usr/lib/qt6/bin:$HOME/.local/bin")

-- https://github.com/ghostty-org/ghostty/discussions/8899
hl.env("GTK_IM_MODULE", "simple")