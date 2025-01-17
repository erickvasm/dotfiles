#!/usr/bin/env bash

# This script is modified but is based on CodelyTV's dotfiles.
# It manages macOS system preferences by exporting and importing configurations using .plist files.
# Usage:
#   ./script.sh export [<path_to>] - Exports system preferences to .plist files in the specified or default path.
#   ./script.sh import [<path_from>] - Imports system preferences from .plist files in the specified or default path.

# Set the default path for dotfiles settings.
dotfiles_settings_path=${2:-"$HOME/.dotfiles/os/mac/settings"}

# Validate arguments.
if [ $# -eq 0 ]; then
    echo "Error: No command provided. Usage: $0 {export|import}"
    echo "Usage:
    export [<path_to>]
    import [<path_from>]"
    exit 1
fi

case $1 in
"export")
    # Export system preferences to .plist files.
    export_plist_path="${dotfiles_settings_path}"
    mkdir -p "$export_plist_path"
    defaults domains | tr ", " "\n" | sed -r '/^\s*$/d' | xargs -I_ defaults export _ "$export_plist_path/_.plist"
    ;;
"import")
    # Import system preferences from .plist files.
    import_plist_path="${dotfiles_settings_path}"

    killall System\ Preferences  # Close System Preferences to prevent conflicts.
    sudo -v  # Refresh sudo privileges.

    # Check for .plist files and import them.
    if [[ -n $(find "$import_plist_path" -name "*.plist" -print -quit) ]]; then
        for plist in "$import_plist_path"/*.plist; do
            defaults import "$(basename "${plist%.*}")" "$plist"
        done
    else
        echo "No .plist files found in $import_plist_path."
    fi
    ;;
*)
    # Handle invalid commands.
    echo "Error: Invalid command. Usage: $0 {export|import}"
    echo "Usage:
    export [<path_to>]
    import [<path_from>]"
    exit 1
    ;;
esac
