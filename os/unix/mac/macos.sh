#!/bin/bash
set -euo pipefail 

###############################################################################
# Initial Setup                                                               #
###############################################################################

# Create a symbolic link for VsCode settings
rm -rf ~/Library/Application\ Support/Code/User/keybindings.json
rm -rf ~/Library/Application\ Support/Code/User/settings.json

ln -s ~/.dotfiles/os/unix/packages/vscode/.config/Code/User/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -s ~/.dotfiles/os/unix/packages/vscode/.config/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings.json

# Close any open System Preferences panes to prevent settings overrides
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` timestamp until the script finishes
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

###############################################################################
# General System Settings                                                     #
###############################################################################

# Show scrollbars only when scrolling
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# Disable "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable automatic capitalization and autocorrect
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g WebAutomaticTextReplacementEnabled -bool false

###############################################################################
# Input Devices: Trackpad, Keyboard, and Mouse                                #
###############################################################################

# Enable tap-to-click for this user and login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

###############################################################################
# Localization                                                                #
###############################################################################

# Set language and measurement units
defaults write NSGlobalDomain AppleLanguages -array "en-US" "es-US" "en"
defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '{ "InputSourceKind" = "Keyboard Layout"; "KeyboardLayout ID" = 89; "KeyboardLayout Name" = "Latin American"; }'
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

###############################################################################
# Security                                                                    #
###############################################################################

# Require password immediately after sleep or screen saver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

###############################################################################
# Finder                                                                      #
###############################################################################

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show status bar and path bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable warnings for changing file extensions and emptying the Trash
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false


###############################################################################
# Dock                                                                        #
###############################################################################

# Use the "genie" effect for minimizing windows
defaults write com.apple.dock mineffect -string "genie"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool false

# Show indicator lights for open applications
defaults write com.apple.dock show-process-indicators -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# TODOs and Customizations
defaults write -g NSUserKeyEquivalents '{
  Bottom = "@^\\U2193";
  "Bottom & Top" = "@^k";
  "Bottom Left" = "@^}";
  "Bottom Right" = "@^{";
  Center = "@^c";
  Fill = "@^f";
  Left = "@^\\U2190";
  "Left & Right" = "@^p";
  "Paste and Match Style" = "@$v";
  Quarters = "@^l";
  Right = "@^\\U2192";
  "Right & Left" = "@^o";
  Top = "@^\\U2191";
  "Top & Bottom" = "@^\\U00f1";
  "Top Right" = "@^\\U00b4";
  "Top left" = "@^+";
}'

# Apply Changes                                                               #
###############################################################################

# Restart Finder and Dock to apply changes
killall Finder
killall Dock
