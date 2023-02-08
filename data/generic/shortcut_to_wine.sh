#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

# Name: Shortcut to .wine/drive_c
# Description: Create a shortcut to ".wine/drive_c" named "Windows" in the home directory.
# ".wine/drive_c" is the default location for Windows applications installed by Wine.
# Make sure you've installed and run Wine at least once before running this script.

# Check if the .wine/drive_c directory exists
if [ ! -d "$HOME/.wine/drive_c" ]; then
	# If it doesn't exist, exit
	echo "The .wine/drive_c directory doesn't exist. Make sure you've installed and run Wine at least once before running this script."
	return 1
fi

# Make the symlink
create_symlink "$HOME/.wine/drive_c" "$HOME/Windows"