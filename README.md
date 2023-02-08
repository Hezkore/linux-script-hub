# Linux Script Hub

A collection of standard scripts to install and configure various Linux applications and services across different distributions. The scripts cover a wide range of topics, including proprietary NVIDIA drivers, media codecs, games, development tools, text editors, and more.

![demo](https://github.com/Hezkore/linux-script-hub/blob/master/demo.png?raw=true)

## How to Use

Follow these steps to use the script hub:
1. Open a terminal in the directory where `main.sh` is located.
2. Ensure `main.sh` is executable. If not, use the command `chmod +x main.sh` to change its permissions.
3. Run the script with the command `./main.sh`.
4. The script will automatically detect your Linux distribution and present the appropriate interface.

You can also run the distribution-specific scripts directly from the `data/distros/` directory. Just remember to run them with `sudo` or `su` if you are not already running as root.

## Adherence to Standards

This repository strives to maintain a high level of standardization in its scripts, written in accordance with the POSIX-compliant bash shell script syntax. It uses `lsb_release` from the Linux Standard Base to accurately detect the running Linux distribution and `sudo` or `su` to run with elevated permissions if necessary.

The distribution-specific scripts use the relevant package manager and tools specific to the distribution to ensure proper installation and configuration of applications and services.

## Available Scripts and Categories

The following scripts and categories are currently available:

### Essentials
- Install NVIDIA Drivers
- Install Media Codecs
- Install Wine

### Development
- Install Git
- Install Visual Studio Code

### Gaming
- Install Steam

### Generic

The generic category contains scripts that can be run on any Linux distribution, and currently includes:

- Configure Git
- Configure GNOME Desktop
- Shortcut to `.local/share`
- Shortcut to `.wine/drive_c`
- Create Projects folder
- Install Telegram Messenger

## Contributing

You are welcome to contribute to this repository by submitting a pull request with your changes or additions, ensuring they adhere to the established script standards.

### Adding a New Distribution
To add a new distribution, run `lsb_release -d` in a terminal to determine the distribution, then create a new directory in `data/distros/` with the distribution name using lowercase letters, underscores instead of spaces and remove any disallowed characters, such as `\/,:*?"<>'`. Create a `info.txt` file in the new directory and enter the distribution name first, followed by any additional information to be displayed in the script hub.

### Adding a New Distribution-Specific Script
To add a new distribution-specific script, create a new script in the directory for your distribution and add the following header to the top of the file:
```bash
#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-
# Ensure POSIX compliance

# Name: My Script
# Description: A description of my script
# More description text here
```
The description should inform the user of any external dependencies required to run the script and describe what the script does.\
Add your script code below the header.

Remember that the script is running as root, so you do not need to use `sudo` or `su` to run commands with elevated permissions.\
This also means that `~` will refer to the root user's home directory, so you should use `$HOME` instead.

A non-zero exit code from any command will be considered a failure, and the script will exit with an error message. You can manually trigger an error with `return 1`.

Call `restart_required` to prompt the user to restart their system after the script has finished running.

### Adding a New Generic Script

To add a new generic script, follow the same steps as for adding a new distribution-specific script, but create the script in the `data/generic` directory instead.
