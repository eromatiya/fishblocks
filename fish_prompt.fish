# ░█▀▀░▀█▀░█▀▀░█░█░█▀▄░█░░░█▀█░█▀▀░█░█░█▀▀
# ░█▀▀░░█░░▀▀█░█▀█░█▀▄░█░░░█░█░█░░░█▀▄░▀▀█
# ░▀░░░▀▀▀░▀▀▀░▀░▀░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀
#
# A dead simple fishshell prompt
# Created by Gerome Matilla

# ░█░█░█▀▀░█░░░█▀█░█▀▀░█▀▄░█▀▀
# ░█▀█░█▀▀░█░░░█▀▀░█▀▀░█▀▄░▀▀█
# ░▀░▀░▀▀▀░▀▀▀░▀░░░▀▀▀░▀░▀░▀▀▀

# Is git dirty?
function _git_dirty -d 'Checks if git is dirty'
	echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

# Is git has untracked files?
function _git_untracked -d 'Checks if git has untracked files'
	echo (command git status -s --ignore-submodules=untracked ^/dev/null)
end

# Is PWD a git directory?
function _git_directory -d 'Checks if $PWD is a git repository'
	if git rev-parse --git-dir > /dev/null 2>&1
		echo 0
	end
end

# Set git status color
function _git_status -d 'Returns color based on the previous command status'
	if [ (_git_directory) ]
		# Check if dirty
		if [ (_git_dirty) ] || [ (_git_untracked) ]
			set git_color yellow
		else
			set git_color green
		end
	else
		set git_color white
	end
	echo $git_color
end

# OS type
function _os_type -d 'Returns OS type'
	set os_type ($SHELL -c "echo \$OSTYPE")
	echo $os_type
end

# Distro name
function _distro_name -d 'Returns linux distribution name'
	set distro_name
	if test -z $distro_name && test -r /etc/os-release
		set distro_name (awk -F '=' '$1=="ID" { print $2 ;}' /etc/os-release)
	end
	if test -z $distro_name && test -r /usr/lib/os-release
		set distro_name (awk -F '=' '$1=="ID" { print $2 ;}' /usr/lib/os-release)
	end
	if test -z $distro_name && [ (command -v lsb_release) ]
		set distro_name (lsb_release -i)
	end
	if test -z $distro_name
		set distro_name 'unknown'
	end
	set distro_name (string lower $distro_name)
	echo $distro_name
end

# Distro icon
function _distro_icon -d 'Returns linux distribution icon'
	switch (_distro_name)
		case '*arch*'
			set icon ''
		case '*debian*'
			set icon ''
		case '*ubuntu*'
			set icon ''
		case '*raspbian*'
			set icon ''
		case '*mint*'
			set icon ''
		case '*manjaro*'
			set icon ''
		case '*elementary*'
			set icon ''
		case '*fedora*'
			set icon ''
		case '*coreos*'
			set icon ''
		case '*gentoo*'
			set icon ''
		case '*centos*'
			set icon ''
		case '*mageia*'
			set icon ''
		case '*opensuse*' '*tumbleweed*'
			set icon ''
		case '*sabayon*'
			set icon ''
		case '*slackware*'
			set icon ''
		case '*alpine*'
			set icon ''
		case '*devuan*'
			set icon ''
		case '*redhat*'
			set icon ''
		case '*aosc*'
			set icon ''
		case '*nixos*'
			set icon ''
		case '*void*'
			set icon ''
		case '*artix*'
			set icon ''
		case '*'
			set icon ''
	end
	echo $icon
end

# OS icon
function _os_icon -d 'Returns OS icon'
	# Icons sauce: https://nerdfonts.com/cheat-sheet
	switch (_os_type)
		case linux-gnu
			set icon (_distro_icon)
		case darwin
			set icon ''
		case CYGWIN_NT-'*' MSYS_NT-'*'
			set icon ''
		case freebsd openbsd dragonfly
			set icon ''
		case sunos
			set icon ''
		case '*'
			set icon ''
	end
	echo $icon
end

# ░█▀█░█▀▄░█▀█░█▄█░█▀█░▀█▀░█▀▀
# ░█▀▀░█▀▄░█░█░█░█░█▀▀░░█░░▀▀█
# ░▀░░░▀░▀░▀▀▀░▀░▀░▀░░░░▀░░▀▀▀

# Distro/OS icon prompt
function _icon_prompt -d 'Returns icon display'
	set prompt_icon (set_color -b blue white)' '(_os_icon)' '
	echo $prompt_icon
end

# SSH Prompt
function _ssh_prompt -d 'Returns SSH display'
	set prompt
	if set -q SSH_TTY
		set prompt (set_color -b bryellow -o black)' SSH '
	end
	echo $prompt
end

# user@host prompt
function _user_host_prompt -d 'Returns username and hostname display'
	set -l user_hostname $USER@(prompt_hostname)
	if [ $USER = 'root' ]
		set user_bg red
	else if [ $USER != (logname) ]
		set user_bg yellow
	else
		set user_bg white
	end
	
	# If we're running via SSH.
	if set -q SSH_TTY
		set user_bg brblack
		set user_hostname (set_color -o brblue)$USER(set_color -o brred)@(set_color -o brgreen)(prompt_hostname)
	end

	set prompt_user (set_color -b $user_bg -o black)' '$user_hostname' '
	echo $prompt_user
end

# PWD prompt
function _pwd_prompt -d 'Returns PWD display'
	# Check working directory if writable
	if test -w $PWD
		set pwd_color (_git_status)
	else
		set pwd_color red
	end
	set prompt_pwd (set_color -b black -o $pwd_color)' '(prompt_pwd)' '
	echo $prompt_pwd
end

# ░█░░░█▀▀░█▀▀░▀█▀░░░░░█░█░█▀█░█▀█░█▀▄░░░█▀█░█▀▄░█▀█░█▄█░█▀█░▀█▀
# ░█░░░█▀▀░█▀▀░░█░░▄▄▄░█▀█░█▀█░█░█░█░█░░░█▀▀░█▀▄░█░█░█░█░█▀▀░░█░
# ░▀▀▀░▀▀▀░▀░░░░▀░░░░░░▀░▀░▀░▀░▀░▀░▀▀░░░░▀░░░▀░▀░▀▀▀░▀░▀░▀░░░░▀░

function fish_prompt
	set -g prev_status $status

	# Window title
	switch $TERM;
		case xterm'*' vte'*';
			printf '\033]0;[ '(prompt_pwd)' ]\007';
		case screen'*';
			printf '\033k[ '(prompt_pwd)' ]\033\\';
	end

	# Print right-hand prompt
	printf '%s%s%s%s%s ' (_icon_prompt) (_ssh_prompt) (_user_host_prompt) (_pwd_prompt) (set_color normal)
end
