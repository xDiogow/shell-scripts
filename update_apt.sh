#!/bin/bash

# Checks if user is root
if [ "$EUID" -ne 0 ]; then
  echo "You are not running as root. Please run as root."
  exit 1
else
    # Updates everything
    apt-get update
    apt-get upgrade

    # How tf I send notification properly
    echo "Finished to update everything! Enjoy."
fi