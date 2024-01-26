# Prerequisites

> [!NOTE]
> Note
>  If you use ufw or firewalld to manage firewall settings, be aware that when you expose container ports using Docker, these ports bypass your firewall rules. For more information, refer to Docker and ufw.
>    

Set up Docker's apt repository.

# Add Docker's official GPG key:
```sh
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

# Add the repository to Apt sources:
```sh
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

> [!NOTE]
> 
>  If you use a derivative distro, such as Kali Linux, you may need to substitute the part of this command that's expected to print the version codename:
> 
>  (. /etc/os-release && echo "$VERSION_CODENAME")
>
>  Replace this part with the codename of the corresponding Debian release, such as bookworm.
>


# Install the Docker packages.

## To install the latest version, run:
```sh
 sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Verify that the installation is successful by running the hello-world image:
```
 sudo docker run hello-world
```

This command downloads a test image and runs it in a container. When the container runs, it prints a confirmation message and exits.


