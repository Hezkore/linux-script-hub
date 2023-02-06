#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

source data/common.sh

# Set the working directory to the script's directory
cd "$(dirname "$0")"

# Sanity check for 'data' directory
# I'm looking at you Linus!
if [ ! -d data ] || [ -z "$(ls -A data)" ]; then
	error "The 'data' directory is missing or empty!"
fi

# Verify elevated privileges for necessary operations
if [ "$EUID" -ne 0 ]; then
	# Check if sudo is available
	if command -v sudo &>/dev/null; then
		# Explain what's going on and run the script with sudo
		echo "This script requires elevated permissions"
		echo "Please enter your password to run it with 'sudo'"
		sudo "$0" "$@"
		exit
	else
		# Check if su is available
		if command -v su &>/dev/null; then
			# Explain what's going on and run the script with su
			echo "This script requires elevated permissions"
			echo "Please enter your password to run it with 'su'"
			su -c "$0 $@"
			exit
		else
			# Error out if no option is available
			error "This script requires elevated privileges and neither sudo nor su is available"
			exit 1
		fi
	fi
fi

# Clear the screen
clear

# Detect linux distribution
export distro="unknown"
if ! command -v lsb_release >/dev/null 2>&1; then
	#error "lsb_release is not installed!"
	echo "Could not detect the Linux distribution"
else
	# Detect the Linux distribution in an exportable variable
	distro=$(lsb_release -sd)
	# Remove any quotes
	distro=$(echo "$distro" | tr -d '"')
	# Convert to lowercase
	distro=$(echo "$distro" | tr '[:upper:]' '[:lower:]')
	# Replace spaces with underscores
	distro=$(echo "$distro" | tr ' ' '_')
fi

# The directory exists, right?
if [ ! -d "$distro_path$distro" ]; then
	echo "Your Linux distribution might not be supported"
	# Ask the user to pick a distribution
	echo "Please select the Linux distribution you are using"
	echo
	
	# List all the available distributions by directory name
	all_distro=$(ls -1 "$distro_path")
	# Show all distro options, list by number and wait for user to pick one
	select distro in $all_distro; do
		# Check if the user picked a valid option
		if [ -d "$distro_path$distro" ]; then
			clear
			# Break out of the loop
			break
		else
			# Ask the user to pick a valid option
			echo "Please select a valid option"
		fi
	done
fi

# Display the detected distribution info.txt file
# Otherwise error out and assume the distribution is not supported
if [ -f "$distro_path$distro/info.txt" ]; then
	cat "$distro_path$distro/info.txt"; echo
else
	error "Distribution $distro not supported!"
fi

# Determine the interface to use
interface="$(get_interface)"
echo
echo "Continuing with the $interface interface"
read -p "Press [Enter] to continue or Ctrl+C to exit..."

# Continue with the selected interface
if [ -f "$interface_path$interface.sh" ]; then
	# Source the interface script
	source $interface_path$interface.sh
	
	# Start the interface
	reset_package_status
	start_interface
	while [ "$?" -eq 0 ]; do
		reset_package_status
		start_interface
	done
else
	error "Interface $interface not supported!"
fi

# Clear the screen
#clear

# Exit with success
exit 0