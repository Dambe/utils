#!/bin/bash

# Script to change settings of Logitech MX Master 3
# This script requires ratbagctl
# $ sudo apt install libratbag-tools
# The piper GUI can be used to change settings as well
# but settings are not persistent
# $ sudo apt install piper

LOG_FILE="/home/jahu/src/utils/logitech.log"

# Make sure only root can run our script
#if [[ $EUID -ne 0 ]]; then
#	echo "$(date) - This script must be run as root" >> ${LOG_FILE}
#   exit 1
#fi

mouse_name() {
	LIST=$(ratbagctl list)
	echo ${LIST%:*}
}

check_mouse() {
	# echo $(ratbagctl list) >> ${LOG_FILE}
	if [[ $(mouse_name) == *"No devices available"* ]]; then
		sudo service ratbagd restart
		sleep 2
		echo "ratbagd restarted" >> ${LOG_FILE}
		echo $(ratbagctl list) >> ${LOG_FILE}
	fi
}

get_dpi() {
	echo $(ratbagctl $(mouse_name) dpi get)
}

set_dpi() {
	ratbagctl $(mouse_name) dpi set 2400
	echo "DPI set to 2400" >> ${LOG_FILE}
	echo "$(date) - logitech done" >> ${LOG_FILE}
}

dbus() {
	# make sure script runs after screen lock/unlock as well
	dbus-monitor --session "type='signal',interface='org.gnome.ScreenSaver'" |
	while read x; do
		case "$x" in
			*"boolean false"*)
				echo "$(date) - SCREEN_UNLOCKED" >> ${LOG_FILE}
				set_dpi
				;;
			*"boolean true"*)
				echo "$(date) - SCREEN_LOCKED" >> ${LOG_FILE}
				;;
		esac
	done
}

main() {
	while true; do
		check_mouse
		if [[ $(get_dpi) != *"2400dpi"*  ]]; then
			set_dpi
		fi
		sleep 2
	done

}

# clear log file
> ${LOG_FILE}

echo "$(date) - Logitech script executed" >> ${LOG_FILE}

main

