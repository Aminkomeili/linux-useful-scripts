#!/usr/bin/env bash
#set -x
#set -e
if [ "$EUID" -ne 0 ]
then echo "Please run as root"
exit
fi
RULES_FILE=/etc/udev/rules.d/veryshinynew.rules
if [[ -e $RULES_FILE ]]; then
read -p "$RULES_FILE found. a to append. r to replace: "
case $REPLY in
'a')
true
;;
'r')
rm -f $RULES_FILE
;;
*)
exit 1
;;
esac
fi
for SYSDEVPATH in $(find /sys/bus/usb/devices/usb*/ -name dev|sort); do (
SYSPATH="${SYSDEVPATH%/dev}"
DEVNAME="$(udevadm info -q name -p $SYSPATH)"
[[ "$DEVNAME" == "ttyUSB" ]] || exit 1
USER_NAME=y${DEVNAME#ttyUSB}
if id "$USER_NAME" &>/dev/null; then
echo "User $USER_NAME exists"
exit 1
else
USER_SHELL="/home/$USER_NAME/.ts"
adduser --disabled-password --gecos '' --shell $USER_SHELL $USER_NAME
echo "$USER_NAME:yY"|chpasswd
echo '#!/usr/bin/env -S bash --noprofile --norc --restricted' >$USER_SHELL
echo "select SERIAL_SPEED in 9600 115200; do if [[ -z \$SERIAL_SPEED ]] ; then exit 1; else cu -l /dev/$USER_NAME -s \$SERIAL_SPEED; exit; fi; done" >>$USER_SHELL
chmod +x $USER_SHELL
CHOICE_KERNEL=$(udevadm info --attribute-walk /dev/$DEVNAME|awk '/KERNELS/ {$1=$1;print}'|head -2|tail -1)
echo -e "$CHOICE_KERNEL, SUBSYSTEMS==\"usb\", SYMLINK+=\"$USER_NAME\", MODE=\"600\", OWNER=\"$USER_NAME\"" >>$RULES_FILE
fi
)
done
"${VISUAL:-"${EDITOR:-nano}"}" $RULES_FILE
udevadm control --reload-rules && udevadm trigger
