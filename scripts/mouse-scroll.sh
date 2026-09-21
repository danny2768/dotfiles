#!/bin/bash
sleep 2  # Wait for devices to be ready
xinput set-prop 9 "libinput Scroll Method Enabled" 0, 0, 1
xinput set-prop 9 "libinput Button Scrolling Button" 2

