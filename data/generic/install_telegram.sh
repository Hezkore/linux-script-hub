#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

# Name: Install Telegram Messenger
# Description: This will install Telegram Messenger from the official homepage.
# Because it's a portable installation you'll have to start it yourself.
# A shortcut will be created once you start the application.
# You can either start it by calling "telegram-desktop" or running it from "~/.local/bin/telegram-desktop".

# Grab the tar.xz
create_dir "$HOME/Downloads"
curl -o "$HOME/Downloads/telegram.tar.xz" https://telegram.org/dl/desktop/linux -L

# Extract the tar.xz
tar -xf "$HOME/Downloads/telegram.tar.xz" -C "$HOME/.local/share"

# Remove the tar.xz
rm "$HOME/Downloads/telegram.tar.xz"

# Add to bin
add_to_bin "$HOME/.local/share/Telegram/Telegram" "telegram-desktop"