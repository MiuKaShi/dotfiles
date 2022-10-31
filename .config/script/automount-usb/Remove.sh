#!/usr/bin/env bash
# If you are executing this script in cron with a restricted environment,
# modify the shebang to specify appropriate path; /bin/bash in most distros.
# And, also if you aren't comfortable using(abuse?) env command.
PATH="$PATH:/usr/bin:/usr/local/bin:/usr/sbin:/usr/local/sbin:/bin:/sbin"

rm -f /usr/local/bin/usb-mount
rm -f /etc/systemd/system/usb-mount@.service

# Remove udev rule
sed -i "/systemctl\sstart\susb-mount/d" /etc/udev/rules.d/99-local.rules
sed -i "/systemctl\sstop\susb-mount/d" /etc/udev/rules.d/99-local.rules

systemctl daemon-reload
udevadm control --reload-rules
