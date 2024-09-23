#!/bin/bash

# Get the names of your displays
INTERNAL="eDP-1"  # Typically the internal laptop display
EXTERNAL="HDMI-1" # Your external display, adjust as needed

# Check if the external display is connected
if xrandr | grep "$EXTERNAL connected"; then
  # If external is active, switch to internal only
  if xrandr | grep "$EXTERNAL connected primary"; then
    xrandr --output "$EXTERNAL" --off --output "$INTERNAL" --auto --primary
  # If internal is active, switch to external only
  else
    xrandr --output "$INTERNAL" --off --output "$EXTERNAL" --auto --primary
  fi
else
  # If no external display, ensure internal is on
  xrandr --output "$INTERNAL" --auto --primary
fi

# Restart i3 to apply changes
i3-msg restart
