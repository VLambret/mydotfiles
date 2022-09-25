#! /bin/bash

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


function configure_remote_pad()
{
	xsetwacom set "$PAD" StripLeftDown "key minus"  # zoom out
	xsetwacom set "$PAD" StripLeftUp "key shift plus"  # zoom in
	xsetwacom set "$PAD" Button 1 "key r"  # rectangular selections
	xsetwacom set "$PAD" Button 2 "key ctrl shift a"  # select none
	xsetwacom set "$PAD" Button 3 "key p"  # paintbrush
	xsetwacom set "$PAD" Button 4 "key tab"  # toggle docks
	xsetwacom set "$PAD" AbsWheelDown "key shift plus"
	xsetwacom set "$PAD" AbsWheelUp "key minus"
	xsetwacom set "$PAD" Button 5 "key shift control left"  # prev/next brush (must be mapped in GIMP)
	xsetwacom set "$PAD" Button 6 "key shift control right"
	xsetwacom set "$PAD" Button 7 "key ctrl shift e"  #  fit Image in window
	xsetwacom set "$PAD" Button 8 "key F11"  # fullscreen

	xsetwacom set "$PAD" StripRightDown "key alt down"  # brush radius (must be mapped in GIMP)
	xsetwacom set "$PAD" StripRightUp "key alt up"
	xsetwacom set "$PAD" Button 9 "key ctrl"
	xsetwacom set "$PAD" Button 10 "key alt"
	xsetwacom set "$PAD" Button 11 "key shift"
	xsetwacom set "$PAD" Button 12 "key tab"
	xsetwacom set "$PAD" AbsWheelDown "key alt up"  # Increase brush radius (must be mapped in GIMP)
	xsetwacom set "$PAD" AbsWheelUp "key alt down"  # Decrease brush radius (must be mapped in GIMP)
	xsetwacom set "$PAD" Button 13 "key apostrophe"
	xsetwacom set "$PAD" Button 14 "key backspace"
	xsetwacom set "$PAD" Button 15 "key backslash"
	xsetwacom set "$PAD" Button 16 "key ctrl z"  # Undo in Gimp
}

workarround_usb_pen
#configure_remote_pad

