# speedtest

Small shell script inspired by tmkrth for logging download speeds over time.

## Installation

### Copy files and stuff

After cloning the repository locally you should copy the `speedtest.sh` file to:
`/usr/local/bin/`. Therefore you only have to copy the remaining `.timer` and `.service`
files without further changes to: `~/.local/share/systemd/user/`. If you choose
another location for the script don't forget to change the path in `speedtest.service`.

Make the script executable: `sudo chown 755 /usr/local/bin/speedtest.sh`.

Create a folder for the log file: `sudo mkdir -p /var/log/speedtest/`.

### Testing and configuring systemd

Based on [this](https://wiki.gentoo.org/wiki/Systemd#Timer_services) documentation by
the gentoo community you can configure your systemd service to act almost exactly like
a cron service.

* Reload systemd so it recognises our new service files:
`systemctl --user daemon-reload`.

* Before enabling it we want to be sure the script is working correct:
`systemctl --user start speedtest.service` (There should be a log file 
filled with a first result by now)

* Activate the systemd timer so it starts when your system boots (it runs every 30 minutes,
please keep that in mind! So it basically downloads 240MB per hour! I have warned you.):
`systemctl --user enable speedtest.timer`

Thats it.
Enjoy
