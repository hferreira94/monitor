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

#### Process Checker #####
#
# takes a pid or a process name and looks it up to see if it's running on the system.
#
#
#
##############################

process_checker() {
	read -p "Enter process name or PID: " proc
	if [ -z "$proc" ]; then
		echo "No input provided. Returning to the menu."
		return
	fi
	process_info=$(ps aux | grep -w "$proc" | grep -v grep)
	if [ -z "$process_info" ]; then
		echo "Process '$proc' is NOT running."
		return
	fi
	echo "Process '$proc' is running. Some details about this proc:"
	echo "-----------------------------------------------------------"
	echo "$process_info" | awk '{print "User: " $1 "\nPID: " $2 "\nCPU%: " $3 "\nMEM%: " $4 "\nCommand: " $11 "\n"}'
}

#### Connectivity Checker #####
#
# takes a hostname or ip address and pings it to check if it's reachable and returns average latency.
#
#
#
##############################
connectivity_checker() {
	read -p "Enter domain or IP address to test connectivity to: " target_domain
	if [ -z "$target_domain" ]; then
		echo "No input provided. Returning to the menu"
		return
	fi
	ping_output=$(ping -c 4 "$target_domain" | tail -1 | awk -F'/' '{print $5}')
	if [ -n "$ping_output" ]; then
		echo "Connected successfully. Average latency to $target_domain: $ping_output ms"
	else
		echo "Failed to connect to $target_domain. Please check your network connetivity and the address details and try again."
	fi
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
	echo "2) Process Checker"
	echo "3) Connectivity Checker"
	echo "4) Exit"
	echo "################################"
	read -p "Select an option: " user_choice
	
	case $user_choice in
		1) analyze_disk ;;
		2) process_checker ;;
		3) connectivity_checker ;;
		4) echo "Exiting the monitor program."; exit 0 ;;
		*) echo "Invalid option. Please try again." ;;
	esac

	echo "\nPress Enter to return to the menu."
done
