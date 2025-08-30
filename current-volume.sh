#!/bin/bash

# current-volume

# Version:    0.0.1
# Author:     KeyofBlueS
# Repository: https://github.com/KeyofBlueS/current-volume
# License:    GNU General Public License v3.0, https://opensource.org/licenses/GPL-3.0


if [[ -n "${SteamEnv}" ]]; then
	srlc_cmd=(steam-runtime-launch-client --alongside-steam --host -- /usr/bin/)
fi

wpctl_out="$("${srlc_cmd[@]}wpctl" get-volume @DEFAULT_AUDIO_SINK@)" || {
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

exit 0
