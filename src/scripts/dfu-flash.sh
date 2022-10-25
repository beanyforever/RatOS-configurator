#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "ERROR: Please run as root"
  exit
fi
pushd /home/pi/klipper
service klipper stop
if [ -h $MCU ]; then
    echo "Flashing Octopus via path"
    make flash FLASH_DEVICE=0483:df11
fi
sleep 5
if [ -h $MCU ]; then
    echo "Flashing Successful!"
else
    echo "Flashing failed :("
    service klipper start
    popd
    chown pi:pi -R /home/pi/klipper
    exit 1
fi
chown pi:pi -R /home/pi/klipper
service klipper start
popd
