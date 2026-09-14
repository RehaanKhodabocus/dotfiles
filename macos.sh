#!/bin/bash
#
# macos.sh - Apply macOS settings, then reboot.
#
# Apps are installed from the Brewfile (see setup.sh), not here.

# -- password ------------------------------------------------------------------
# Ask for the password once. A "keep sudo alive" loop doesn't work reliably
# (`brew` resets the sudo timestamp every time it runs), so sudo gets an askpass
# helper that answers with this password instead. The password lives in a
# private temp folder that is deleted when the script exits.

SETUP_TMP="$(mktemp -d)"
trap 'rm -rf "$SETUP_TMP"' EXIT
chmod 700 "$SETUP_TMP"

read -r -s -p "Please enter your admin password: " password < /dev/tty
echo
(umask 077 && printf '%s\n' "$password" > "$SETUP_TMP/password")
unset password

cat > "$SETUP_TMP/askpass" <<EOF
#!/bin/sh
cat "$SETUP_TMP/password"
EOF
chmod 700 "$SETUP_TMP/askpass"
export SUDO_ASKPASS="$SETUP_TMP/askpass"

if ! sudo -k -A true 2>/dev/null; then
    echo "Incorrect password. Exiting."
    exit 1
fi

# Changing Computer Settings
echo ""
echo "Changing Mac Settings"

echo "Changing Dock Settings"
# Sets dock size to 30
# Enables auto-hide
# Sets instant opening of dock on mouse hover
# Hides recent apps
# Sets minimize effect to genie
defaults write com.apple.dock tilesize -int 30
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mineffect -string "genie"

echo "Changing Finder Settings"
# Hide file extensions by default
# Show Path Bar
# Show Status Bar
# Sets Finder to List View
# Keep folders on top in windows
# Search entire Mac by default
# Warn before changing file extensions
# Show icons on title bar
# Remove hover delay on title bar icons
# Sets icon size in sidebar
# Hide recent tags in sidebar
defaults write NSGlobalDomain AppleShowAllExtensions -bool false
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCev"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool true
defaults write com.apple.universalaccess showWindowTitlebarIcons -bool true
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2
defaults write com.apple.finder ShowRecentTags -bool false

echo "Changing Desktop Settings"
# Keep folders at the top on desktop
# Show icons on desktop
# Show hard disks on desktop
# Show external disks on desktop
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true
defaults write com.apple.finder CreateDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

echo "Changing Menu Bar & System Settings"
# Flash time separator every second
# Set date and time format (e.g., "Mon 13 Feb 14:30")
# Disable mouse acceleration (linear movement)
# Set mouse tracking speed
# Don't prompt to use new disks for Time Machine
defaults write com.apple.menuextra.clock FlashDateSeparators -bool true
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm"
defaults write NSGlobalDomain com.apple.mouse.linear -bool false
defaults write NSGlobalDomain com.apple.mouse.scaling -float 3
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Restart affected applications
echo ""
echo "Restarting Finder and Dock to apply changes..."
killall Finder
killall Dock

echo ""
printf '✨\033[1;33m Settings applied! \033[m✨\n'
echo ""
read -r -p "Press Enter to reboot your computer: " < /dev/tty

# Uses the password entered at the start
sudo -A reboot
