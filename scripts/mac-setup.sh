#!/usr/bin/env bash

# This script is modified. But is based on CodelyTV's dotfiles

dotfiles_settings_path=${2:-"$HOME/.dotfiles/os/mac/settings"}

if [ $# -eq 0 ]; then
    echo "Error: No command provided. Usage: $0 {export|import}"
    echo "Usage:
    export [<path_to>]
    import [<path_from>]"
    exit 1
fi

case $1 in
"export")
    export_plist_path="${dotfiles_settings_path}"
    mkdir -p "$export_plist_path"
    defaults domains | tr ", " "\n" | sed -r '/^\s*$/d' | xargs -I_ defaults export _ "$export_plist_path/_.plist"
    ;;
"import")
    import_plist_path="${dotfiles_settings_path}"

    killall System\ Preferences
    sudo -v

    if [[ -n $(find "$import_plist_path" -name "*.plist" -print -quit) ]]; then
        for plist in "$import_plist_path"/*.plist; do
            defaults import "$(basename "${plist%.*}")" "$plist"
        done
    else
        echo "No .plist files found in $import_plist_path."
    fi
    ;;
*)
    echo "Error: Invalid command. Usage: $0 {export|import}"
    echo "Usage:
    export [<path_to>]
    import [<path_from>]"
    exit 1
    ;;
esac
