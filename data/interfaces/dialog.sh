#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

# Dialog interface

start_interface() {
	### Category Selection ###
	
	# Create the options string for dialog from get_distro_categories
	all_categories=($(get_distro_categories))
	options=""
	count=0
	for category in "${all_categories[@]}"; do
		# Capitalize the first letter of the category
		category=$(echo "$category" | sed 's/\(.\)/\u\1/')
		options+=" $count $category"
		count=$((count+1))
	done
	
	# Pass the options string to dialog
	selected=$(dialog --stdout --ok-label "Select" --cancel-label "Exit" --title "$title" --backtitle "Script Categories" --menu "Select a category:" 0 0 0 $options)
	if [ $? -eq 0 ]; then
		category=$(get_category_path "${all_categories[$selected]}")
		
		### Package Selection ###
		
		# Create the options string for dialog
		all_packages=($(get_distro_packages $category))
		options=()
		count=0
		for package in "${all_packages[@]}"; do
			name=$(get_package_name "$category/$package")
			# Add the package to the options
			options+=("$count" "$name" "off")
			count=$((count+1))
		done
		
		selected=$(dialog --stdout --ok-label "Run" --cancel-label "Back" --backtitle "Script Selection" --checklist "Select scripts to run:" 0 0 0 "${options[@]}")
		# Did the user press back?
		if [ $? -eq 1 ]; then
			return 0
		fi
		# Check if selected is empty
		if [ -z "$selected" ]; then
			dialog --title "No Scripts Selected" --backtitle "Script Selection" --msgbox "No scripts were selected. Press [Space] to select a script." 0 0
			return 0
		fi
		
		# Show the description of the selected packages
		packages_to_run=()
		for i in $selected; do
			selected=$(dialog --stdout  --yes-label "Continue" --no-label "Cancel" --title "$(get_package_name "$category/${all_packages[$i]}")"  --backtitle "Script Information" --yesno "$(get_package_description "$category/${all_packages[$i]}")" 0 0)
			# If the user seelcted yes then we add it to the array of packages to be installed
			if [ $? -eq 0 ]; then
				packages_to_run+=("${all_packages[$i]}")
			fi
		done
		
		# Run packages_to_run
		for i in "${packages_to_run[@]}"; do
			run_package "$category/$i"
		done
		
		# Show the results of the packages
		# If get_packages_failed_count is 0 then all packages were successful
		if [ $(get_packages_failed_count) -eq 0 ]; then
			dialog --title "Success" --backtitle "Script Results" --msgbox "All script were installed successfully." 0 0
		else
			# Show a list of the failed packages
			dialog --title "Failed Scripts" --backtitle "Script Results" --msgbox "$(get_packages_failed)" 0 0
		fi
		
		# Awaits restart by checking awaiting_restart
		if [ $(awaiting_restart) -eq 1 ]; then
			# Ask if the user wants to restart
			selected=$(dialog --stdout --ok-label "Restart" --cancel-label "Later" --title "Restart Required" --backtitle "Script Results" --defaultno --yesno "A restart is required for some of the changes to take effect.\n\nWould you like to restart now?" 0 0)
			if [ $? -eq 0 ]; then
				shutdown -r now
				return 1
			fi
		fi
		
		return 0
	else
		return 1
	fi
	
	return 0
}
