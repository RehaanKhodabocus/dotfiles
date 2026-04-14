#!/bin/bash

# Ask for the password once at the beginning
echo "Please enter your admin password:"
read -s password
echo

# Validate password and keep sudo session alive
echo "$password" | sudo -S -v
if [ $? -ne 0 ]; then
    echo "Incorrect password. Exiting."
    exit 1
fi

# Keep sudo session alive in the background
while true; do
    sudo -n true
    sleep 50
    kill -0 "$$" || exit
done 2>/dev/null &

echo "Updating Homebrew"
brew update

# Installing applications
echo "Installing Applications"
echo "Installing Zen Browser"
brew install --cask zen

echo "Installing Whatsapp"
brew install --cask whatsapp

echo "Installing Obsidian"
brew install --cask obsidian

echo "Installing Free Download Manager"
brew install --cask free-download-manager

echo "Installing Ghostty"
brew install --cask ghostty

echo "Installing Visual Studio Code"
brew install --cask visual-studio-code

echo "Installing Discord"
brew install --cask discord

echo "Installing NTFS Support (Mounty)"
brew install --cask macfuse
brew install gromgit/fuse/ntfs-3g-mac
brew install --cask mounty

echo "Installing IINA"
brew install --cask iina

echo "Installing MesloLG Nerd Font"
brew install --cask font-meslo-lg-nerd-font

echo "Installing OBS"
brew install --cask obs

echo "Installing Logitech G Hub"
brew install --cask logitech-g-hub

echo "Installing Zotero"
brew install --cask zotero

echo "Installing Aerospace"
brew install --cask nikitabobko/tap/aerospace

echo "All applications have been installed."

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
printf '\u2728\e[1;33m Installation completed! \u2728\e[m\n'
echo ""
read -r -p "Press any key to reboot your computer: "

# Use the stored password for reboot
echo "$password" | sudo -S reboot
