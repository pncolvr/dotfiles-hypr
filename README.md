# Info

This is my personal daily driver hyprland configuration that I use for personal and work activities.

## Compositor animations and screen sharing

Quickshell owns compositor animations through `Config.hyprlandAnimationsEnabled`
and the current sharing state. Animations run only when that setting is enabled
and no screen share is active. Quickshell waits for capture discovery, excludes
known webcam sources and keeps suppression until the last share ends.
`HideApplications(active, animationsEnabled)` applies privacy rules and the
animation boolean supplied by Quickshell.

The **Meta+X** binding and toggle script have been removed. Edit Quickshell's
Config.qml and reload/restart the bar to change compositor animations. There is no
SQLite override, animation IPC setter or separate state file. UI animation switches
remain independent.

Hypr configuration loading starts with animations disabled and private capture
rules enabled. Quickshell then reapplies its authoritative state, including after
a compositor reload. No Lua animation owner or separate state file is used.
Run `bash tests/hyprland/capture-sync.sh` in the Quickshell repository for isolated
Config/restart, readiness and sharing checks with a mocked compositor.

# Relevant Commands
I use this repo as a git submodule on my dotfiles.  
The following command is isued on the dotfiles repo, to have this one as a submodule.
```shell
git submodule add git@github.com:pncolvr/dotfiles-hypr.git .config/hypr
```

## When cloning a "parent repo" to include the submodules

```shell
git clone --recurse-submodules <repository-url>
```
_or_ if we cloned the repo without the submodules
```shell
git submodule update --init --recursive
```

# Syncing submodules

```shell
git submodule sync --recursive
```

## Quickshell shortcuts

Service-backed Quickshell keybinds use `hl.dsp.global("quickshell:NAME")` and the
shared registry in Quickshell's `shell.qml`. This includes launchers, recording,
Vault, notification DND, the modules submap, window cycling/group selection and
the tools-submap shell reload. Key combinations and submap behavior are preserved.
Meta+Escape opens the native Power menu through `quickshell:launcher-power`.
Meta+B opens native Bookmarks through `quickshell:launcher-bookmarks`, preserving
the existing bookmark source and browser policy.
Tools-submap E opens native QR encoding through `quickshell:launcher-encode-qr`;
its noninteractive tool worker never calls back into a picker.
Hypridle retains direct `provider power Lock` execution, including when the bar is
unavailable. Other shell-backed menu workflows remain pending their native-service migration.
External scripts retain Quickshell IPC when they need arguments, status or results;
full process restart/recovery remains external.
