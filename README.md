# Linux Script Hub

A collection of standard scripts for installing and configuring various Linux applications and services across multiple distributions.\
The scripts cover a range of topics including proprietary NVIDIA drivers, media codecs, games, development tools, text editors, and more.

## Usage

To run the script hub, follow these steps:
1. Open a terminal window in the directory where `main.sh` is located.
2. Make sure `main.sh` is set as executable. If not, use the command `chmod +x main.sh` to change its permissions.
3. Run the script with the command `./main.sh`.
4. The script will automatically detect your Linux distribution and present the appropriate interface.

Alternatively, you can run the distribution-specific script directly from the `data/distros/` directory.

## Script Adherence and Standardization

This repository aims to maintain a high level of standardization in its scripts, written in accordance with the POSIX-compliant bash shell script syntax.\
The script hub uses the Linux Standard Base tool `lsb_release` to accurately detect the running Linux distribution, as well as `sudo` or `su` to run with elevated permissions if necessary.

Distribution-specific scripts make use of the relevant package manager and tools specific to the distribution, to ensure proper installation and configuration of applications and services.

## Scripts and Categories

The following scripts and categories are currently available:

### Essentials
* NVIDIA Drivers
* Media Codecs

## Contribution

Feel free to contribute to this repository by submitting a pull request with your changes or additions, ensuring they adhere to the established script standards.