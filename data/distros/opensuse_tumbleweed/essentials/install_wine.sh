#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

# Name: Install Wine
# Description: This script installs Wine and Wine dependencies.
# wine-gecok, wine-mono, DOSBox, and Winetricks are also installed.
# You can right click .exe files and select to always run them with Wine.

# Install
zypper --non-interactive install -l wine wine-gecko wine-mono dosbox winetricks