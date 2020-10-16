#!/bin/bash

# for ease of converting screens
function portrait() {
  # figure out the name of the touchscreen with xinput -list

  # rotate screen left
  xrandr -o right     

  # adjust touchscreen with it
  xinput set-prop "Wacom HID 481A Finger touch" --type=float "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
  # can also be applied to touchpad, etc, if needed
}

function landscape() {
  # rotate screen back to normal
  xrandr -o normal

  # adjust screen with it
  xinput set-prop "Wacom HID 481A Finger touch" --type=float "Coordinate Transformation Matrix" 0 0 0 0 0 0 0 0 0
}

#x11vnc with multiple displays, TODO: WIP
function virtualdisp() {
  gtf 1920 1080 60
  xrandr --newmode "1920x1080_60.00"  172.80  1920 2040 2248 2576  1080 1081 1084 1118  -HSync +Vsync  
  xrandr --addmode $1 1920x1080_60.00 
}
