#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

# Name: Keybinds for GNOME desktop
# Description: Sets up keybinds for GNOME desktop.
# Terminal opens with Ctrl + Alt + T and Super + T.
# Nautilus (Files) opens with Ctrl + Alt + E and Super + E.
# System Monitor opens with Ctrl + Alt + Delete and Ctrl + Shift + Esc.
# Changes Switch Application to Switch Window.

# Helper function to add a keybinding
add_keybinding() {
	name=$1
	command=$2
	binding=$3

	keybindings_output=$(su $USER -c 'gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings')
	if [ "$keybindings_output" == "@as []" ]; then
		keybindings=()
	else
		keybindings=($(echo $keybindings_output | tr -d '[]' | tr , '\n'))
	fi
	num_keybindings=${#keybindings[@]}
	index=0
	
	while [[ "$(su $USER -c "gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$index/ name")" != "''" ]]; do
		# Is this the same name as the one we're trying to add?
		if [[ "$(su $USER -c "gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$index/ name")" == "'$name'" ]]; then
			# If so, update the command and binding
			su $USER -c "gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$index/ command '$command'"
			su $USER -c "gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$index/ binding '$binding'"
			return 0
		fi
		
		index=$((index + 1))
	done
	
	keybindings+=("/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$index/")
	
	su $USER -c "gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$index/ binding '$binding'"
	su $USER -c "gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$index/ command '$command'"
	su $USER -c "gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$index/ name '$name'"
	
	keybindings_string="["
	for i in "${keybindings[@]}"; do
		keybindings_string="$keybindings_string\"$i\","
	done
	keybindings_string="${keybindings_string%,}]"
	su $USER -c "gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings '$keybindings_string'"

	echo "Keybinding added: $name"
}

# Terminal
add_keybinding "Terminal" "gnome-terminal" "<Control><Alt>t"
add_keybinding "Terminal Alternative" "gnome-terminal" "<Super>t"

# Nautilus (Files)
add_keybinding "Files" "nautilus -w" "<Control><Alt>e"
add_keybinding "Files Alternative" "nautilus -w" "<Super>e"

# System Monitor
add_keybinding "System Monitor" "gnome-system-monitor" "<Control><Alt>Delete"
add_keybinding "System Monitor Alternative" "gnome-system-monitor" "<Control><Shift>Escape"

# Switch Window
su $USER -c "gsettings set org.gnome.desktop.wm.keybindings switch-applications []"
su $USER -c "gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward []"
su $USER -c "gsettings set org.gnome.desktop.wm.keybindings switch-windows '[\"<Alt>Tab\"]'"
su $USER -c "gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward '[\"<Shift><Alt>Tab\"]'"