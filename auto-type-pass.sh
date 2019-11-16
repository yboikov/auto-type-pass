#!/usr/bin/env bash

win_id=$(xdotool getactivewindow)
name=$(xdotool getwindowname ${win_id})

# strip everything before @ and after :
name=${name#*@}
name=${name%:*}
find ~/.password-store/ -name "*.gpg" -print0 | 
	while IFS= read -r -d '' line; 
	do 
		kname=`basename ${line%.gpg}`; 
		if grep -q ${kname} <<<${name};
		then 
			PASSWORD_STORE_CLIP_TIME=1 pass -c ${kname} 
			xdotool key --delay 50 --clearmodifiers "ctrl+v" "Return"
		fi; 
	done
