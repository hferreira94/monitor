#!/bin/bash

#####  Disk space checker
#
#  prompts for a disk partition and checks for the available space.
#
#
#
###############################

read -p "Enter a directory path: " dir
if [ -z "$dir" ]; then
	echo "No input directory provided. Please try again."
	return
fi
if [ ! -d "$dir" ]; then
	echo "Error: Directory '$dir' not found! Please try again."
	return
fi
total_size=$(du -sh "$dir" | awk '{print $1}')
echo "Total size of '$dir': $total_size"
echo "Top 5 largest files in '$dir' are:"
find "$dir" -type f -exec du -h {} + | sort -rh | head -5
