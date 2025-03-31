#!/bin/bash
paru -S bluez bluez-utils blueberry
sudo modprobe btusb
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

paru -S cups cups-pdf
sudo systemctl enable cups.service
sudo systemctl start cups.service

paru -S system-config-printer
