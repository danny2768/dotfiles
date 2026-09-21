#!/usr/bin/env bash
set -euo pipefail

# ————————————————
# CONFIGURATION
STEP=20           # percent step size
MAX=100           # percent max

# ————————————————
# FUNCTIONS

setFanSpeed() {
    # $1: integer speed percent
    nbfc set -s "$1"
}

setFanToAuto() {
    nbfc set --auto
}

getCurrentFanSpeed() {
    # actual RPM-derived speed when in auto mode
    nbfc status \
      | grep -m1 "Current Fan Speed" \
      | awk '{print int($NF)}'
}

getRequestedFanSpeed() {
    # the speed percent previously requested (when not in auto)
    nbfc status \
      | grep -m1 "Requested Fan Speed" \
      | awk '{print int($NF)}'
}

getCurrentSpeed() {
    # returns the current percent (regardless of auto/custom)
    local auto
    auto=$(nbfc status | grep -m1 "Auto Control Enabled" | awk '{print $NF}')
    if [[ "$auto" == "true" ]]; then
        getCurrentFanSpeed
    else
        getRequestedFanSpeed
    fi
}

nextSpeed() {
    local current next

    # getCurrentSpeed already handles auto vs. custom for us
    current=$(getCurrentSpeed)

    # compute next step (never 0)
    if (( current < STEP )); then
        next=$STEP
    else
        next=$(( (current / STEP + 1) * STEP ))
    fi

    if (( next <= MAX )); then
        echo "⟳ Setting fan speed to ${next}%"
        setFanSpeed "$next"
    else
        echo "✔ Reached >${MAX}%, reverting to auto mode"
        setFanToAuto
    fi
}


# ————————————————
# MAIN
nextSpeed

