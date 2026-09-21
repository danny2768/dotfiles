#!/bin/bash

# Try to disable and enable both mouse entries (id=9 and id=15)
# If this stops working use xinput list to find mouse entry
for MOUSE_ID in 9 15; do
    echo "Attempting to disable and re-enable mouse with ID $MOUSE_ID"
    xinput --disable "$MOUSE_ID" && xinput --enable "$MOUSE_ID"
done

