#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

# Name: Configure Git
# Description: Set your name and email for Git

# Make sure Git is installed
if ! verify_app "git"; then
	echo "Git is not installed!"
	return 1
fi

# Set name
read -r -p "Enter your name for Git: " name
git config --global user.name "$name"
echo "Your name is now set to: $(git config --global user.name)"

echo

# Set email
read -r -p "Enter your email for Git: " email
git config --global user.email "$email"
echo "Your email is now set to: $(git config --global user.email)"

# Set permissions
chown $USER "$HOME/.gitconfig"
chmod 644 "$HOME/.gitconfig"