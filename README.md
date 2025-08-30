# current-volume

# Version:    0.1.0
# Author:     KeyofBlueS
# Repository: https://github.com/KeyofBlueS/current-volume
# License:    GNU General Public License v3.0, https://opensource.org/licenses/GPL-3.0

### DESCRIPTION
A tiny, lightweight and fast Bash script to show your system's audio volume.

I mainly wrote this to show the volume in MangoHud, but you can use it anywhere you like, for example in Conky.

### FEATURES
- Uses `wpctl` (PipeWire) to get the default audio sink/source volume.
- Compatible with Steam runtime environments - automatically wraps `wpctl` command in `steam-runtime-launch-client` if SteamEnv is set.
- Shows volume as a simple percentage, e.g., `5%`, `60%` or `150%`.
- Adds `(MUTE)` if the audio is muted.

### INSTALL
```sh
curl -o /tmp/current-volume.sh 'https://raw.githubusercontent.com/KeyofBlueS/current-volume/main/current-volume.sh'
sudo mkdir -p /opt/current-volume/
sudo mv /tmp/current-volume.sh /opt/current-volume/
sudo chown root:root /opt/current-volume/current-volume.sh
sudo chmod 755 /opt/current-volume/current-volume.sh
sudo chmod +x /opt/current-volume/current-volume.sh
sudo ln -s /opt/current-volume/current-volume.sh /usr/local/bin/current-volume
```
### USAGE
```sh
$ current-volume
```
```
Options:
-s, --sink      Show the default sink (e.g. speakers, headphones) volume (default).
-m, --mic       Show the default source (e.g. microphone) volume.
-h, --help      Show this help.
```
### USING WITH MangoHud
You can display the current volume in MangoHud by adding a custom command to your MangoHud configuration file (usually `~/.config/mangohud/MangoHud.conf`):
```
custom_text=Volume
exec=/opt/current-volume/current-volume.sh

custom_text=Mic
exec=/opt/current-volume/current-volume.sh -m
```
`custom_text` is the label that will appear in the overlay.

`exec` should point to the path where you saved the `current-volume.sh` script.

The script will automatically detect if you're running in Steam ($SteamEnv) and display the correct volume with (MUTE) if muted.

This makes it easy to see your system volume directly in games.


