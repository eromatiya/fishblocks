# ░█░█░█▀▀░█░░░█▀█░█▀▀░█▀▄░█▀▀
# ░█▀█░█▀▀░█░░░█▀▀░█▀▀░█▀▄░▀▀█
# ░▀░▀░▀▀▀░▀▀▀░▀░░░▀▀▀░▀░▀░▀▀▀

# Set time background color
function _time_bg -d 'Returns background color based on time'
	set hour (date +%H)
	if test $hour -ge 6 && test $hour -lt 12
		echo brblue
	else if test $hour -ge 12 && test $hour -lt 18
		echo brgreen
	else
		echo brblack	
	end
end

# Set time foreground color
function _time_fg -d 'Returns foreground color based on time'
	set hour (date +%H)
	if test $hour -ge 6 && test $hour -lt 12
		echo black
	else if test $hour -ge 12 && test $hour -lt 18
		echo black
	else
		echo white	
	end
end

# ░█▀█░█▀▄░█▀█░█▄█░█▀█░▀█▀░█▀▀
# ░█▀▀░█▀▄░█░█░█░█░█▀▀░░█░░▀▀█
# ░▀░░░▀░▀░▀▀▀░▀░▀░▀░░░░▀░░▀▀▀

# Time prompt
function _time_prompt -d 'Returns time display'
	set prompt_time (set_color -b (_time_bg) -o (_time_fg))' '(date +%H:%M)' '
	echo $prompt_time
end

# Status prompt
function _status_prompt -d 'Returns status display'
	if not test $prev_status -eq 0
		set_color $fish_color_error
		echo -n (set_color -b red yellow) '✘ '
	else
		echo -n (set_color -b black green) '✔ '
	end
	set_color normal
end

function _git_prompt -d 'Returns Git display'
	if [ (__fish_git_prompt) ]
		set git_bg (_git_status)
		set prompt (__fish_git_prompt) ' '
	else
		set git_bg normal
		set prompt (__fish_git_prompt)
	end
	echo (set_color -b $git_bg -o black) $prompt
end

function _private_prompt -d 'Returns private mode display'
	if  not test -z $fish_private_mode
		set prompt (set_color -b black white) '﫸'
	else
		set prompt
	end
	echo $prompt
end

# ░█▀▄░▀█▀░█▀▀░█░█░▀█▀░░░░░█░█░█▀█░█▀█░█▀▄░░░█▀█░█▀▄░█▀█░█▄█░█▀█░▀█▀
# ░█▀▄░░█░░█░█░█▀█░░█░░▄▄▄░█▀█░█▀█░█░█░█░█░░░█▀▀░█▀▄░█░█░█░█░█▀▀░░█░
# ░▀░▀░▀▀▀░▀▀▀░▀░▀░░▀░░░░░░▀░▀░▀░▀░▀░▀░▀▀░░░░▀░░░▀░▀░▀▀▀░▀░▀░▀░░░░▀░

# Right-hand prompt
function fish_right_prompt -d 'Right-hand prompt'
	printf '%s%s%s%s%s' (_status_prompt) (_git_prompt) (_time_prompt) (_private_prompt)
	set_color normal
end
