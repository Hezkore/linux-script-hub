#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

# Name: Install Visual Studio Code
# Description: Adds the repository and installs VSCode.

# Add the repo
rpm --import https://packages.microsoft.com/keys/microsoft.asc
zypper --non-interactive addrepo --refresh -cfp 95 'https://packages.microsoft.com/yumrepos/vscode' vscode
zypper --gpg-auto-import-keys refresh

# Install VSCode (aka. code)
zypper --non-interactive install -l code