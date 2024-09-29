#!/bin/bash

# Checks if mullvad is enabled.
check_mullvad_status() {
    local status=$(mullvad status)

    if [[ "$status" == *"Disconnected"* ]]; then
        return 0 # Not running
    else
        return 1 # Running 
    fi
}

check_firefox() {
    result=$(ps -e | grep -i firefox)
    if [[ "$result" == *'firefox'* ]]; then
        return 1 # Running
    else
        return 0 # Not running
    fi
}

check_firefox
firefox_status=$?

check_mullvad_status
mullvad_status=$?

if [ $mullvad_status -eq 0 ] && [ $firefox_status -eq 1 ]; then
    unset $mullvad_status
    
    echo "Mullvad is disconnected and Firefox is running. Running mullvad!"
    mullvad connect
    
    check_mullvad_status
    mullvad_status=$?

    if [ $mullvad_status -eq 1 ]; then
        echo "Connected to mullvad. You are now protected."
    else
        echo "Failed to connect to mullvad."
    fi
else
    echo "Mullvad is already running or Firefox is not being used."
fi
