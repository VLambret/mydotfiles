#! /bin/bash

DISPLAY_ID="HEAD-1"

PEN="Wacom Cintiq 27QHD Pen stylus"
PAD="Wacom Cintiq 27QHD Pad pad"
PAD="Wacom Express Key Remote Pad pad"

# Source: https://github.com/linuxwacom/input-wacom/issues/104
function workarround_usb_pen()
{
	for WACOM_DEVICE in $(grep -i '056a' /sys/bus/usb/devices/*/idVendor | xargs -n 1 dirname)
	do
		sudo sh -c "echo 0 > '$WACOM_DEVICE/authorized'"
		echo "$WACOM_DEVICE turned OFF"
		sudo sh -c "echo 1 > '$WACOM_DEVICE/authorized'"
		echo "$WACOM_DEVICE turned ON"
	done
}

function map_to_display()
{
	for x in $(xsetwacom --list devices | grep -o -P "id: \d+" | cut -f2 -d' ')
	do
		xsetwacom set $x MapToOutput $DISPLAY_ID
	done
}


function configure_remote_pad()
{
	xsetwacom --set "Wacom Express Key Remote Pad pad" Touch on

	# settings for krita (with some extra key configuration there)

	## zoom (ctrl +/-) (not in diagram) (bottom buttons)
	xsetwacom --set "Wacom Express Key Remote Pad pad" Button 21 "key ctrl plus"
	xsetwacom --set "Wacom Express Key Remote Pad pad" Button 22 "key ctrl minus"

	## rotation over touch wheel (ctrl ö/ä)
	#xsetwacom --set "Wacom Express Key Remote Pad pad" AbsWheelUp "key ctrl 0xd6"
	#xsetwacom --set "Wacom Express Key Remote Pad pad" AbsWheelDown "key ctrl 0xe4"

	## wheel button left/right for undo/redo
	xsetwacom --set "Wacom Express Key Remote Pad pad" Button 2 "key ctrl z"
	xsetwacom --set "Wacom Express Key Remote Pad pad" Button 9 "key ctrl shift z"

	## Mode resets rotation and tool to brush and zoom (no modes yet)
	#xsetwacom --set "Wacom Express Key Remote Pad pad" Button 1 "key 5 b 1"

	## wheel down: reset zoom only
	xsetwacom --set "Wacom Express Key Remote Pad pad" Button 10 "key 1"

	## 1st row: Brush size ö/ä
	#xsetwacom --set "Wacom Express Key Remote Pad pad" Button 11 "key +0xd6"
	#xsetwacom --set "Wacom Express Key Remote Pad pad" Button 13 "key +0xe4"

	## 2nd row: opacity
	#xsetwacom --set "Wacom Express Key Remote Pad pad" Button 14 "key +i"
	#xsetwacom --set "Wacom Express Key Remote Pad pad" Button 16 "key +o"

	## 3rd row: color brightness 
	#xsetwacom --set "Wacom Express Key Remote Pad pad" Button 17 "key +k"
	#xsetwacom --set "Wacom Express Key Remote Pad pad" Button 19 "key +l"

	## bottom buttons: ctrl + shift
	#xsetwacom --set "Wacom Express Key Remote Pad pad" Button 21 "key +ctrl"
	#xsetwacom --set "Wacom Express Key Remote Pad pad" Button 22 "key +shift"
}

#workarround_usb_pen
map_to_display
configure_remote_pad

