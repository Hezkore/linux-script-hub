#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

# Name: Shortcut to .local/share
# Description: Create a shortcut to ".local/share" named "App Data" in the home directory.
# ".local/share" is a common directory for storing applications and their data.

# Make the symlink
create_symlink "$HOME/.local/share" "$HOME/App Data"