# Linux Script Hub

A collection of standard scripts for installing and configuring various Linux applications and services across multiple distributions.\
The scripts cover a range of topics including proprietary NVIDIA drivers, media codecs, games, development tools, text editors, and more.

![demo](https://github.com/Hezkore/linux-script-hub/blob/master/demo.png?raw=true)

## Usage

To run the script hub, follow these steps:
1. Open a terminal window in the directory where `main.sh` is located.
2. Make sure `main.sh` is set as executable. If not, use the command `chmod +x main.sh` to change its permissions.
3. Run the script with the command `./main.sh`.
4. The script will automatically detect your Linux distribution and present the appropriate interface.

Alternatively, you can run the distribution-specific scripts directly from the `data/distros/` directory.

## Script Adherence and Standardization

This repository aims to maintain a high level of standardization in its scripts, written in accordance with the POSIX-compliant bash shell script syntax.\
The script hub attempts to use the Linux Standard Base tool `lsb_release` to accurately detect the running Linux distribution, as well as `sudo` or `su` to run with elevated permissions if necessary.

Distribution-specific scripts make use of the relevant package manager and tools specific to the distribution, to ensure proper installation and configuration of applications and services.

## Scripts and Categories

The following scripts and categories are currently available:

### Essentials
* NVIDIA Drivers
* Media Codecs

## Generic Category

The generic category contains scripts that are not specific to any particular distribution, and can be run on any Linux distribution.

It currently contains the following scripts:

* Configure Git

## Contribution

Feel free to contribute to this repository by submitting a pull request with your changes or additions, ensuring they adhere to the established script standards.


### Adding a New Distribution
Run `lsb_release -d` in a terminal to check your Linux distribution. Then create a new directory in `data/distros/` with the name of your distribution, remember to use lowercase letters and underscores instead of spaces. Then create a `info.txt` file in the new directory, enter the distribution name first and then add any information you want to be displayed in the script hub.

### Adding a New Distribution-Specific Script
Create a new script in the directory of your distribution, and add the following header to the top of the file:
```bash
#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

# Name: My Script
# Description: A description of my script
# More description text here
```
Remember that the description text should tell the user which external dependencies are required for the script to run, and what the script does.

Then add your script code below the header.

Any command returning a non-zero exit code will be considered a failure, and the script will exit with an error message.\
You can manually trigger an error with `return 1`.

Call `restart_required` to prompt the user to restart their system after the script has finished running.

### Adding a New Generic Script
Same as adding a new distribution-specific script, but create the script in the `data/generic/` directory instead.