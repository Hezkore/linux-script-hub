#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

# Name: Configure GNOME desktop
# Description: Configures GNOME desktop to use more logical settings.
# Removes the mouse acceleration.
# Sets the mouse speed to 0.65 to adjust for lower acceleration.
# Disables middle mouse click pasting.
# Enables right mouse button resizing.
# Center new windows.
# Disable model dialogs attachment.
# Increase the check-alive timeout.
# Nautilus sort directories first and extra options.

# Make sure gsettings is installed
if ! verify_app "gsettings"; then
	echo "gsettings is not installed!"
	return 1
fi

# Remove mouse acceleration
su $USER -c 'gsettings set org.gnome.desktop.peripherals.mouse accel-profile "flat"'

# Set mouse speed
su $USER -c 'gsettings set org.gnome.desktop.peripherals.mouse speed 0.065'

# Disable middle-click paste
su $USER -c 'gsettings set org.gnome.desktop.interface gtk-enable-primary-paste "false"'

# Enable resize with right click
su $USER -c 'gsettings set org.gnome.desktop.wm.preferences resize-with-right-button "true"'

# Disable large window auto maximize
su $USER -c 'gsettings set org.gnome.mutter auto-maximize "false"'

# Center new windows
su $USER -c 'gsettings set org.gnome.mutter center-new-windows "true"'

# Disable attached dialogs
su $USER -c 'gsettings set org.gnome.mutter attach-modal-dialogs "false"'
su $USER -c 'gsettings set org.gnome.shell.overrides attach-modal-dialogs "false"'

# Increase check-alive
su $USER -c 'gsettings set org.gnome.mutter check-alive-timeout 10000'

# Nautilus
su $USER -c 'gsettings set org.gtk.Settings.FileChooser show-hidden "false"'
su $USER -c 'gsettings set org.gtk.Settings.FileChooser sort-directories-first "true"'

su $USER -c 'gsettings set org.gnome.nautilus.preferences show-create-link "true"'
su $USER -c 'gsettings set org.gnome.nautilus.preferences default-folder-viewer "icon-view"'
su $USER -c 'gsettings set org.gnome.nautilus.icon-view default-zoom-level "small"'