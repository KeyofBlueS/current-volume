#!/bin/bash

# current-volume

# Version:    0.1.0
# Author:     KeyofBlueS
# Repository: https://github.com/KeyofBlueS/current-volume
# License:    GNU General Public License v3.0, https://opensource.org/licenses/GPL-3.0


function show_volume() {

	if [[ -n "${SteamEnv}" ]]; then
		srlc_cmd=(steam-runtime-launch-client --alongside-steam --host -- /usr/bin/)
	fi

	wpctl_out="$("${srlc_cmd[@]}wpctl" get-volume "${device}")" || {
		echo 'ERROR' >&2
		exit 1
	}

	set -- ${wpctl_out}
	vol_float="${2}"

	vol_percent="${vol_float#0}"
	vol_percent="${vol_percent/.}"
	vol_percent="${vol_percent#0}"

	if [[ "${wpctl_out}" == *MUTED* ]]; then
		echo "${vol_percent}% (MUTE)"
	else
		echo "${vol_percent}%"
	fi
}

function givemehelp() {

current_volume_name="$(readlink -f "${0}")"

	echo "
# current-volume

# Version:    0.1.0
# Author:     KeyofBlueS
# Repository: https://github.com/KeyofBlueS/current-volume
# License:    GNU General Public License v3.0, https://opensource.org/licenses/GPL-3.0

### DESCRIPTION
A tiny, lightweight and fast Bash script to show your system's audio volume.

I mainly wrote this to show the volume in MangoHud, but you can use it anywhere you like, for example in Conky.

### FEATURES
- Uses wpctl (PipeWire) to get the default audio sink/source volume.
- Compatible with Steam runtime environments - automatically wraps wpctl command in steam-runtime-launch-client if SteamEnv is set.
- Shows volume as a simple percentage, e.g., 5%, 60% or 150%.
- Adds (MUTE) if the audio is muted.

### USAGE

$ current-volume <option>

Options:
-s, --sink      Show the default sink (e.g. speakers, headphones) volume (default).
-m, --mic       Show the default source (e.g. microphone) volume.
-h, --help      Show this help.

### USING WITH MangoHud
You can display the current volume in MangoHud by adding a custom command to your MangoHud configuration file (usually ~/.config/mangohud/MangoHud.conf):

custom_text=Volume
exec=${current_volume_name}

custom_text=Mic
exec=${current_volume_name} -m


custom_text is the label that will appear in the overlay.

exec should point to the path where you saved the current-volume.sh script.

The script will automatically detect if you're running in Steam (\$SteamEnv) and display the correct volume with (MUTE) if muted.

This makes it easy to see your system volume directly in games.
"
}

device='@DEFAULT_AUDIO_SINK@'

for opt in "$@"; do
	shift
	case "$opt" in
		'--sink')		set -- "$@" '-s' ;;
		'--mic')		set -- "$@" '-m' ;;
		'--help')		set -- "$@" '-h' ;;
		*)				set -- "$@" "$opt"
	esac
done

while getopts "smh" opt; do
	case ${opt} in
		s ) device='@DEFAULT_AUDIO_SINK@'
		;;
		m ) device='@DEFAULT_AUDIO_SOURCE@'
		;;
		h ) givemehelp; exit 0
		;;
		*) echo -e "\e[1;31m## ERROR\e[0m"; givemehelp; exit 1
	esac
done

show_volume

exit 0
