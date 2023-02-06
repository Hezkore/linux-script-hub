#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

### Variables ###
title="Linux Script Hub"

distro_path="data/distros/"

interface_default="text"
interfaces=("zenity" "dialog") # In the order of preference
interface_path="data/interfaces/"

distro_categories=()
distro_packages=()

packages_success=()
packages_failed=()

_user_must_restart=0

### Functions ###

# Error handing function
error() {
	echo
	echo "Error: $1"
	read -p "Press [Enter] to exit..."
	exit 1
}
export -f error

# Verify if application is installed
# Returns 0 if installed, 1 if not
verify_app() {
	if command -v "$1" &>/dev/null; then
		return 0
	else
		return 1
	fi
}

# Loop through the interfaces and select the first one that is available
# Default to text interface if none are available
# Return the interface name
get_interface() {
	for i in "${interfaces[@]}"; do
		if verify_app "$i"; then
			if verify_interface "$i"; then
				echo "$i"
				return 0
			fi
		fi
	done
	# Verify the default interface
	if verify_interface "$interface_default"; then
		echo "$interface_default"
	else
		error "The default interface script is missing or not executable!"
	fi
	return 0
}

# Verify if an interface is valid
# Determined by the existence of a file named 'data/interfaces/<interface>.sh'
# And if it's executable or if we can make it executable
verify_interface() {
	if [ -f "$interface_path$1.sh" ]; then # Exists?
		if [ -x "$interface_path$1.sh" ]; then # Executable?
			return 0
		else
			chmod +x "$interface_path$1.sh"
			# Check again if it's executable, otherwise we give up
			if [ -x "$interface_path$1.sh" ]; then
				return 0
			else
				return 1
			fi
		fi
	else
		return 1
	fi
}

# Get (and cache) the list of categories for the current distro
get_distro_categories() {
	# Cache the distro_categories array if it's empty
	if [ ${#distro_categories[@]} -eq 0 ]; then
		# Get the category directories
		distro_categories=($(ls -d $distro_path$distro/*/))
		# Strip path from category names
		distro_categories=(${distro_categories[@]#$distro_path$distro/})
		# Strip trailing slash from category names
		distro_categories=(${distro_categories[@]%/})
	fi
	echo "${distro_categories[@]}"
	return 0
}

# Get (and cache) the list of packages for the current distro and category
# Pass category as the first argument
get_distro_packages() {
	# Cache the distro_packages array if it's empty
	if [ ${#distro_packages[@]} -eq 0 ]; then
		# Get the package files
		distro_packages=($(ls -d $1/*.sh))
		# Strip path from package names
		distro_packages=(${distro_packages[@]#$1/})
		# Strip .sh extension from package names
		#distro_packages=(${distro_packages[@]%.sh})
	fi
	echo "${distro_packages[@]}"
	return 0
}

# Get package name from script file
# Pass script file path as the first argument
get_package_name() {
	# Get the package name
	name=$(cat "$1" | grep -m 1 "^# Name: ")
	# Did we get a name?
	if [ -z "$name" ]; then
		# No, use the filename
		name=$(basename "$1")
		# Strip .sh extension
		name=${name%.sh}
	else
		# Strip the comment
		name=${name:8}
		# Strip leading and trailing whitespace
		name=$(echo -e "${name}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
	fi
	echo "$name"
	return 0
}

# Get package description from script file
# First we get the description from reading the line "# Description: "
# If the line AFTER that is a comment, we append it to the description
# Otherwise we return the description
get_package_description() {
	found_description=false
	script_lines=()
	i=0
	while read line; do
		script_lines[i]="$line"
		i=$((i + 1))
	done < "$1"
	
	for line in "${script_lines[@]}"; do
		if [ "$found_description" = true ]; then
			if [[ "$line" == "# "* ]]; then
				description+="
${line:2}"
			else
				break
			fi
		else
			if [[ "$line" == "# Description: "* ]]; then
				description="${line:14}"
				found_description=true
			fi
		fi
	done
	
	# Is the description empty?
	if [ -z "$description" ]; then
		description="No description available available for this package."
	fi
	
	echo "$description"
	return 0
}

# Reset package run status
reset_package_status() {
	packages_success=()
	packages_failed=()
}

# Get successful packages
get_packages_success() {
	echo "${packages_success[@]}"
	return 0
}

# Get successful packages count
get_packages_success_count() {
	echo "${#packages_success[@]}"
	return 0
}

# Get failed packages
get_packages_failed() {
	echo "${packages_failed[@]}"
	return 0
}

# Get failed packages count
get_packages_failed_count() {
	echo "${#packages_failed[@]}"
	return 0
}

# Run selected package
# Pass script file path as the first argument
run_package() {
	# Clean slate
	clear
	echo "Running package '$1'..."
	
	# Make sure the package is executable
	if [ ! -x "$1" ]; then
		chmod +x "$1"
		# Success?
		if [ ! -x "$1" ]; then
			error "The package '$1' is not executable!"
		fi
	fi
	
	# Run the package and see if it returns an error
	source "$1"
	if [ $? -ne 0 ]; then
		#error "The package '$1' returned an error!"
		echo "The package '$1' returned an error!"
		read -p "Press [Enter] to continue or Ctrl+C to exit..."
		# Add to failed packages
		packages_failed+=("$1")
		return 1
	fi
	# Add to successful packages
	packages_success+=("$1")
	return 0
}

restart_required() {
	_user_must_restart=1
}

awaiting_restart() {
	echo "$_user_must_restart"
	return 0
}