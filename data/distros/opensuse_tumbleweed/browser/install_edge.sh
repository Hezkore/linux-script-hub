#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

# Name: Install Microsoft Edge Browser
# Description: Adds the repository and installs Edge.

# Add the repo
rpm --import https://packages.microsoft.com/keys/microsoft.asc
zypper --non-interactive addrepo --refresh -cfp 95 'https://packages.microsoft.com/yumrepos/edge' edge
zypper --gpg-auto-import-keys refresh

# Install Edge
zypper --non-interactive install -l microsoft-edge-stable