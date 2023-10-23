#!/bin/bash

# Function to check the package manager and update/upgrade accordingly
update_os() {
    if command -v apt-get &>/dev/null; then
        echo "Detected APT package manager. Updating and upgrading..."
        sudo apt-get update
        sudo apt-get upgrade -y
    elif command -v apk &>/dev/null; then
        echo "Detected APK package manager. Updating and upgrading..."
        sudo apk update
        sudo apk upgrade
    elif command -v yum &>/dev/null; then
        echo "Detected YUM package manager. Updating and upgrading..."
        sudo yum update -y
    else
        echo "Unsupported package manager. Exiting..."
        exit 1
    fi
}

# Function to install or upgrade additional packages
install_packages() {
    echo "Installing or upgrading additional packages..."

    # List the packages you want to install or upgrade here
    packages=("nano") # packages=("nano" "package2" "package3")

    if command -v apt-get &>/dev/null; then
        sudo apt-get install -y "${packages[@]}"
    elif command -v apk &>/dev/null; then
        sudo apk add --no-cache "${packages[@]}"
    elif command -v yum &>/dev/null; then
        sudo yum install -y "${packages[@]}"
    else
        echo "Unsupported package manager. Skipping package installation."
    fi
}

# Check the system architecture
architecture=$(uname -m)

echo "Detected system architecture: $architecture"

# Update the OS
update_os

# Install or upgrade additional packages
install_packages

echo "Script completed."
