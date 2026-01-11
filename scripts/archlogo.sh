#!/bin/bash

clear

# Default color
color='reset'

# Parse command line options
while getopts "C:" opt; do
    case $opt in
        C)
            color=$OPTARG
            ;;
        *)
            echo "Usage: $0 [-C color]"
            exit 1
            ;;
    esac
done

python '/mnt/data/documents/dotfiles/scripts/asccilogo.py' -C "$color" -f '/mnt/data/documents/dotfiles/assets/archlogo.txt'
