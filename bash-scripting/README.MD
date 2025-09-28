# Bash Script to Run Health Check on The Remote Host
This script is used to check the health of a remote server. It verifies connectivity to the server, connectivity to the specified port, and disk usage of the root directory (/). The results of these checks are logged in the /var/log/healthcheck directory.

## Getting Started
I use a shebang `(#!/bin/bash)` to ensure the script is always executed with /bin/bash, since some commands may not be available in other shells.

I have also added a `--help` flag to provide usage instructions for the script.

When running the script to check a remote server, you need to create an SSH user named `healthcheck` for it to work. You must also configure passwordless SSH authentication using a public-private key pair to connect to the server. In addition, the privileges of this user should be set to the minimum required—just enough to perform the necessary tasks.

To run this script, run the following lines in the terminal:
```
sudo ./health_check 127.0.0.1 80
```
The ip address and the port can be anything you want. You can see the the full information on how to use this script by running the following line in a terminal:
```
sudo ./health_check -h
```