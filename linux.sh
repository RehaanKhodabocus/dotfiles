# Hyprland config — single monitor (laptop)
# Converted from AeroSpace config
#
# Workspace layout:
#   1 → Browser
#   2 → Terminal + VS Code
#   3 → Notes (Obsidian)
#   4 → Chat (WhatsApp etc.)
#   5 → Music / Spotify
#   6 → Scratch
#   7 → Scratch
#   8 → Scratch
#   9 → Scratch

################
### MONITORS ###
################

# eDP-1 is the standard internal laptop display name.
# Run `hyprctl monitors` to confirm yours.
monitor = eDP-1, preferred, auto, 1

################
### AUTOSTART ##
################

exec-once = waybar
exec-once = dunst

#################
### VARIABLES ###
#################

$mainMod = ALT

#############
### LAYOUT ###
#############

general {
    gaps_in = 10
    gaps_out = 10
    border_size = 1
    layout = dwindle
}

dwindle {
    pseudotile = false
    preserve_split = true
}

#####################
### WINDOW RULES ####
#####################

# Browser → workspace 1
windowrulev2 = workspace 1, class:^(firefox)$
windowrulev2 = workspace 1, class:^(chromium)$
windowrulev2 = workspace 1, class:^(brave-browser)$
windowrulev2 = workspace 1, class:^(zen-browser)$

# Terminal + VS Code → workspace 2
windowrulev2 = workspace 2, class:^(ghostty)$
windowrulev2 = workspace 2, class:^(com.mitchellh.ghostty)$
windowrulev2 = workspace 2, class:^(code-oss)$
windowrulev2 = workspace 2, class:^(code)$

# Notes → workspace 3
windowrulev2 = workspace 3, class:^(obsidian)$
windowrulev2 = workspace 3, class:^(org.gnome.Notes)$

# Chat → workspace 4
windowrulev2 = workspace 4, class:^(whatsapp-for-linux)$
windowrulev2 = workspace 4, class:^(vesktop)$
windowrulev2 = workspace 4, class:^(telegram-desktop)$

# Music → workspace 5
windowrulev2 = workspace 5, class:^(spotify)$
windowrulev2 = workspace 5, class:^(rhythmbox)$

# Floating apps
windowrulev2 = float, class:^(org.gnome.Settings)$
windowrulev2 = float, class:^(pavucontrol)$
windowrulev2 = float, class:^(nm-connection-editor)$
windowrulev2 = float, class:^(gnome-system-monitor)$

################
### BINDINGS ###
################

# Layout switching
bind = $mainMod, slash, togglesplit,
bind = $mainMod, comma, layoutmsg, togglesplit

# Focus navigation
bind = $mainMod, H, movefocus, l
bind = $mainMod, J, movefocus, d
bind = $mainMod, K, movefocus, u
bind = $mainMod, L, movefocus, r

# Move windows
bind = $mainMod SHIFT, H, movewindow, l
bind = $mainMod SHIFT, J, movewindow, d
bind = $mainMod SHIFT, K, movewindow, u
bind = $mainMod SHIFT, L, movewindow, r

# Workspace switching
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9

# Move windows to workspaces
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9

# App launchers — swap commands to match what you have installed
bind = $mainMod, M, exec, rhythmbox              # Music (was: Apple Music)
bind = $mainMod, S, exec, firefox                # Browser (was: Safari)
bind = $mainMod, O, exec, obsidian               # Obsidian
bind = $mainMod, G, exec, ghostty                # Ghostty
bind = $mainMod, C, exec, code                   # VS Code
bind = $mainMod, W, exec, whatsapp-for-linux     # WhatsApp
bind = $mainMod SHIFT, D, exec, nautilus ~/Desktop

# Window management
bind = $mainMod, equal, layoutmsg, redistribute  # balance-sizes
bind = $mainMod, F, fullscreen, 0
bind = $mainMod, Q, killactive,

# Workspace back-and-forth (was: workspace-back-and-forth)
bind = $mainMod, Tab, workspace, previous

# Reload config
bind = $mainMod SHIFT, C, exec, hyprctl reload

#################
### RESIZE MODE #
#################

bind = $mainMod, R, submap, resize

submap = resize

binde = , H, resizeactive, -50 0
binde = , J, resizeactive, 0 50
binde = , K, resizeactive, 0 -50
binde = , L, resizeactive, 50 0

binde = SHIFT, H, resizeactive, -200 0
binde = SHIFT, J, resizeactive, 0 200
binde = SHIFT, K, resizeactive, 0 -200
binde = SHIFT, L, resizeactive, 200 0

bind = , Return, submap, reset
bind = , Escape, submap, reset

submap = reset

##################
### SERVICE MODE #
##################

bind = $mainMod SHIFT, semicolon, submap, service

submap = service

bind = , Escape, exec, hyprctl reload
bind = , Escape, submap, reset
bind = , F, togglefloating,
bind = , F, submap, reset

bind = ALT SHIFT, H, swapwindow, l
bind = ALT SHIFT, H, submap, reset
bind = ALT SHIFT, J, swapwindow, d
bind = ALT SHIFT, J, submap, reset
bind = ALT SHIFT, K, swapwindow, u
bind = ALT SHIFT, K, submap, reset
bind = ALT SHIFT, L, swapwindow, r
bind = ALT SHIFT, L, submap, reset

submap = reset
