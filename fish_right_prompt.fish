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

# Time stamp block
function _block_time_stamp -d 'Returns time stamp block'
	set block (set_color -b (_time_bg) -o (_time_fg))' '(date +%H:%M)' '
	echo $block
end

# Status block
function _block_status -d 'Returns status block'
	if not test $prev_status -eq 0
		set_color $fish_color_error
		echo -n (set_color -b red yellow) '✘ '
	else
		echo -n (set_color -b black green) '✔ '
	end
	set_color normal
end

# Git block
function _block_git -d 'Returns Git block'
	if [ (__fish_git_prompt) ]
		set git_bg (_git_status)
		set block (__fish_git_prompt) ' '
	else
		set git_bg normal
		set block (__fish_git_prompt)
	end
	echo (set_color -b $git_bg -o black) $block
end

# Private mode block
function _block_private -d 'Returns private mode block'
	if  not test -z $fish_private_mode
		set block (set_color -b black white) '﫸'
	else
		set block
	end
	echo $block
end

# ░█▀▄░▀█▀░█▀▀░█░█░▀█▀░░░░░█░█░█▀█░█▀█░█▀▄░░░█▀█░█▀▄░█▀█░█▄█░█▀█░▀█▀
# ░█▀▄░░█░░█░█░█▀█░░█░░▄▄▄░█▀█░█▀█░█░█░█░█░░░█▀▀░█▀▄░█░█░█░█░█▀▀░░█░
# ░▀░▀░▀▀▀░▀▀▀░▀░▀░░▀░░░░░░▀░▀░▀░▀░▀░▀░▀▀░░░░▀░░░▀░▀░▀▀▀░▀░▀░▀░░░░▀░

# Right-hand prompt
function fish_right_prompt -d 'Right-hand prompt'
	printf '%s%s%s%s%s' (_block_status) (_block_git) (_block_time_stamp) (_block_private)
	set_color normal
end
