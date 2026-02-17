#!/usr/bin/env sh

echo "polybar script ran just now" >> /tmp/foobar

# Prefer polybar if available
if command -v polybar >/dev/null 2>&1; then
  pkill polybar
  while pgrep -u "$UID" -x polybar >/dev/null; do sleep 0.2; done
  # primary=$(polybar --list-monitors | grep '(primary)' | cut -d":" -f1)
  # for m in $(polybar --list-monitors | cut -d":" -f1); do
  #     if [ "$m" = "$primary" ]; then
  #         MONITOR=$m polybar --reload main &
  #     else
  #         MONITOR=$m polybar --reload secondary &
  #     fi
  # done
  polybar -r main &
  i3-msg 'gaps top all set -2'
  exit 0
fi

i3-msg 'gaps top all set 0'

i3-msg 'bar {
  output primary
  tray_output primary
  position top

  status_command i3status
}

bar {
  position top
  output nonprimary
  tray_output none
}
'
