!#/bin/bash

sudo modprobe uinput

sudo groupadd uinput
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER

sudo cp ./99-input.rules /etc/udev/rules.d

echo "Please reboot for changes to take effect"
