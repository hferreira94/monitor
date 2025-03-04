#!/bin/bash

#####  Disk space checker
#
#  prompts for a disk partition and checks for the available space.
#
#
#
###############################
analyze_disk() {
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
}

#### Main menu
#
# creates an interactive main menu to access the features of the monitor script
#
#
#
##############################

while true; do
	echo "################################"
	echo "       Monitoring Menu          "
	echo "################################"
	echo "1) Analyze disk space"
	echo "2) Exit"
	echo "################################"
	read -p "Select an option: " user_choice
	
	case $user_choice in
		1) analyze_disk ;;
		2) echo "Exiting the monitor program."; exit 0 ;;
		*) echo "Invalid option. Please try again." ;;
	esac

	echo -e "\nPress Enter to return to the menu."
	read
done
