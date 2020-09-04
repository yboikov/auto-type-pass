#!/usr/bin/env bash

win_id=$(xdotool getactivewindow)
name=$(xdotool getwindowname ${win_id})

# strip everything before @ and after :
name=${name#*@}
name=${name%:*}
function main() {
	find ~/.password-store/ -name "*.gpg" -print0 | 
		while IFS= read -r -d '' line; 
		do 
			kname=`basename ${line%.gpg}`; 
			if grep -iq ${kname} <<<${name};
			then
				secretname=${line#*.password-store/}
				secretname=${secretname%.gpg}
				commands=$(PASSWORD_STORE_CLIP_TIME=1 pass show ${secretname})
				while read -r value;
				do
					read -r key
					xdotool sleep 0.2 type ${value}
					# if there is no command after type hit enter and exit from script
					[[ -z ${key} ]] && xdotool key --delay 50 --clearmodifiers "Return" && exit 0
					xdotool key --delay 50 --clearmodifiers "${key}"
				done < <(printf '%s\n' "$commands")
				exit 0
				#xdotool key --delay 50 --clearmodifiers "ctrl+v" "Return"
			fi; 
		done
}
function manual_selection() {
	password_list=$(for line in $(find ~/.password-store/ -name "*.gpg"); do echo `basename ${line%.gpg}`; done)
	selection=$(zenity --list --text=`echo "$password_list"` --title="Choose password..." --column="Passwords" --width=600 --height=600) && selected_password=$(pass show $selection)
	xdotool sleep 0.2 type ${selected_password}
	xdotool key --delay 50 --clearmodifiers "Return" && exit 0
}

if [ "$1" == "--manual" ]; then
	manual_selection
else
	main
fi
