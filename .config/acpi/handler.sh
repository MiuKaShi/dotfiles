#!/bin/bash
# Default acpi script that takes an entry for all actions

noti() {
    local display=":$(ls /tmp/.X11-unix/* | sed 's#/tmp/.X11-unix/X##' | head -n 1)"
    sudo -u miuka DISPLAY=$display notify-send -h string:x-canonical-private-synchronous:anything "$@"
}

case "$1" in
    button/power)
        case "$2" in
            PBTN | PWRF)
                logger 'PowerButton pressed'
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    button/sleep)
        case "$2" in
            SLPB | SBTN)
                logger 'SleepButton pressed'
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    ac_adapter)
        case "$2" in
            AC | ACAD | ADP0 | ACPI0003:00)
                case "$4" in
                    00000000)
                        logger 'AC unpluged'
                        noti AC unplugged
                        ;;
                    00000001)
                        logger 'AC pluged'
                        noti AC plugged
                        ;;
                esac
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    battery)
        case "$2" in
            BAT0)
                case "$4" in
                    00000000)
                        logger 'Battery online'
                        ;;
                    00000001)
                        logger 'Battery offline'
                        ;;
                esac
                ;;
            CPU0) ;;
            *) logger "ACPI action undefined: $2" ;;
        esac
        ;;
    button/lid)
        case "$3" in
            close)
                logger 'LID closed'

                # Closed on Battery (suspend)
                acpi -a | grep -q "off-line"
                if [ $? = 0 ]; then
                    sv down iwd
                    sv down bluetoothd
                    zzz
                # Ignore if external display connected
                elif [ "$(xrandr -q | grep ' connected' | wc -l)" != "1" ]; then
                    logger 'LID closed, External display connected'
                # Otherwise lock screen
                else
                    sudo -u $(ps -o ruser= -C xinit) xset s activate
                fi
                ;;
            open)
                logger 'LID opened'
                sv up iwd
                sv up bluetoothd
                # Force monitor on
                sudo -u $(ps -o ruser= -C xinit) xset dpms force on
                ;;
            *)
                logger "ACPI action undefined: $3"
                ;;
        esac
        ;;
    *)
        logger "ACPI group/action undefined: $1 / $2"
        ;;
esac

# vim:set ts=4 sw=4 ft=sh et:
