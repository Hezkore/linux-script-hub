#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

# Name: Install media codecs
# Description: Adds the Packman repository and installs the media codecs.

# Add the repo
zypper --non-interactive addrepo --refresh -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/' packman
zypper --gpg-auto-import-keys refresh

# Install
zypper --non-interactive dist-upgrade -l --from packman --allow-vendor-change
zypper --non-interactive install -l --from packman ffmpeg libavcodec-full vlc-codecs gstreamer-plugins-bad-codecs gstreamer-plugins-ugly-codecs gstreamer-plugins-libav pipewire-aptx gstreamer-plugins-good gstreamer-plugins-good-extra gstreamer-plugins-bad gstreamer-plugins-ugly libavdevice56
zypper --non-interactive install-new-recommends --repo packman --allow-vendor-change
zypper --non-interactive install -l ffmpeg-5

restart_required