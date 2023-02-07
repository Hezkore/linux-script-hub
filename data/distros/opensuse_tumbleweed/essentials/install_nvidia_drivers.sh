#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

# Name: Install proprietary NVIDIA drivers
# Description: Adds the NVIDIA repository and installs the NVIDIA drivers, specifically the 64bit G06 version.
# Installs support for GPGPU computing, OpenGL libraries, driver tools, and the video driver.
# Version G06 is compatible with all cards GT700 and up.
# Note that this script assumes that the multiversion feature for kernel packages is enabled.

# Add the repo
zypper --non-interactive addrepo --refresh -cfp 98 https://download.nvidia.com/opensuse/tumbleweed NVIDIA
zypper --gpg-auto-import-keys refresh

# Install
zypper --non-interactive install -l nvidia-compute-G06 nvidia-gl-G06 nvidia-video-G06 nvidia-utils-G06

restart_required