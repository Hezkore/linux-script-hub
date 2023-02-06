#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

# Name: Install media codecs
# Description: Adds the Packman repository and installs the media codecs.

zypper --non-interactive addrepo --refresh -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/' packman
zypper --non-interactive dist-upgrade --from packman --allow-vendor-change
zypper --non-interactive install --from packman ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec-full vlc-codecs

restart_required