

if ( $(pamixer --get-mute) == true ); then
	dunstify "Audio muted" --replace 1
else
	dunstify "Audio unmuted" --replace 1
fi