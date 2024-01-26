
# Configure Docker to start on boot with systemd

Many modern Linux distributions use systemd to manage which services start when the system boots. On Debian and Ubuntu, the Docker service starts on boot by default. To automatically start Docker and containerd on boot for other Linux distributions using systemd, run the following commands:

```sh
 sudo systemctl enable docker.service

 sudo systemctl enable containerd.service
```

To stop this behavior, use disable instead.
```sh
 sudo systemctl disable docker.service

 sudo systemctl disable containerd.service
```

