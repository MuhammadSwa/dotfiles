#!/bin/bash

systemctl enable --now cronie.service

(crontab -l 2>/dev/null; echo "*/30 * * * * $HOME/scripts/syncVault.sh") | crontab -
(crontab -l 2>/dev/null; echo "*/30 * * * * $HOME/scripts/syncDotfiles.sh") | crontab -
(crontab -l 2>/dev/null; echo "* */2 * * * $HOME/scripts/syncZotero.sh") | crontab -
