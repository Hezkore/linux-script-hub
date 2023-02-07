#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

# Name: Install Steam
# Description: This script installs Steam via zypper.
# Since Steam Tricks is also available from the package manager, we'll install that too.

# Install
zypper --non-interactive install -l steam steamtricks