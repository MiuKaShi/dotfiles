#!/usr/bin/env bash
# If you are executing this script in cron with a restricted environment,
# modify the shebang to specify appropriate path; /bin/bash in most distros.
# And, also if you aren't comfortable using(abuse?) env command.
PATH="$PATH:/usr/bin:/usr/local/bin:/usr/sbin:/usr/local/sbin:/bin:/sbin"
chmod 755 ./*.sh

cp ./usb-mount /usr/local/bin/

# Create udev rule to start/stop usb-mount@.service on hotplug/unplug
cat ./99-local.rules.usb-mount >>/etc/udev/rules.d/99-local.rules

udevadm control --reload-rules
