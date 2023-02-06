#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

# Name: Create Projects folder
# Description: Create a Projects folder in the home directory.
# Will not overwrite existing folders or files.

# Make the directories
create_dir $HOME/Projects/Others
create_dir $HOME/Projects/3D
create_dir $HOME/Projects/Code
create_dir $HOME/Projects/Images
create_dir $HOME/Projects/Audio
create_dir $HOME/Projects/Video
create_dir $HOME/Projects/Misc