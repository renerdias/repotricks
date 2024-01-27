https://www.virtualizationhowto.com/2023/03/docker-compose-static-ip-configuration/

 Docker Compose Static IP configuration
Brandon LeeMarch 6, 2023
4 minutes read
Facebook X LinkedIn Tumblr Pinterest Reddit Share via Email
259b2f16 77d1 4897 8831 920dbbca990f

The Docker Compose static IP address mechanism is a great way to stay in total control of the network configuration of your Docker containers created using your Docker compose process. Docker compose enables creating multiple containers in bulk and configuring the network settings for each container as they are provisioned. By default, it dynamically assigns IP addresses. However, you can use a Docker Compose static IP address configuration to assign the IP addresses configured for your docker containers manually.
Docker Compose Static IP

Docker containers communicate with other containers through a network connection between them. Docker creates a private virtual network to allow containers to communicate with each other using private IP addresses. Docker Compose Static IP enables defining static IP addresses for containers on a Docker network.

Take note of the docker-compose.yml file below. The file is creating two containers: web and DB, with static IP addresses. It uses private IP address configurations, which are always environment based and need to be managed along with other network IP ranges in the environment:

version: '3'
services:
  web:
    image: nginx
    networks:
      test_network:
        ipv4_address: 172.16.238.10
  db:
    image: postgres
    networks:
      test_network:
        ipv4_address: 172.16.238.11
networks:
  test_network:
    ipam:
      driver: default
      config:
        - subnet: 172.16.238.0/24

We are creating a custom network called test_network and configuring it to use the IP address range 172.16.238.0/24. We assign the IP address 172.16.238.10 to the web container and the IP address 172.16.238.11 to the db container.

Docker Compose will create the two containers as defined and use the IP addresses specified in the Docker Compose file. Below is a simple docker-compose.yml configuration used to deploy containers in the home lab environment.
Docker Static IP Benefits

Docker Compose Static IP has several benefits:

    It allows you to know the IP addresses for each container easily and simplifies container management

    It places you in control of network addressing, allowing you to define custom IP address ranges and define how your application communicates across the network

    When you use static IP addresses for your containers, you can ensure their IP addresses remain the same when the container restarts or is recreated using Docker Compose

    It simplifies connecting to a container’s ports. By specifying the container’s IP address and port number, you can connect to a container’s ports directly

Container names for connectivity

In addition to using static IP addresses, you can also use container names to connect to containers. Docker automatically assigns these when you create a container, and it can be used to reference a container in a Docker network.

For example, you can use the container name to specify the connection string when accessing containers directly.
Docker default network

Docker compose creates a default network when you use it to create your containers. All containers on a host are connected to this default network if you don’t define a static IP address configuration.

The docker network create command is used to create a custom network. You can also set the driver to be used by the network and configure the IP address management settings.

For example, you can use the bridge IPAM driver to assign IP addresses to network containers automatically.

For example, if you have a container running a web server, you can connect to it by specifying its IP address and port number in a web browser.
Other network details

In addition to static IP addresses, Docker Compose allows you to configure other networking details, such as DNS settings, gateway settings, and environment variables.

You can customize your network configuration to meet your specific needs by configuring these details in your Docker Compose file.
Driver and IPAM details

When you define a network in Docker Compose, you can specify its name and the driver for the network. You can also configure the network’s IP address management (IPAM) settings.

IPAM settings allow you to specify the subnet and gateway for the network and any additional options required for the network configuration.
Connecting containers to a Docker network

To connect containers to a network, you can specify the network name in the container’s configuration. As shown, you can specify the test_network network in the web and db containers in the example.
Connect a single container to multiple networks

When you connect a single container to multiple networks, you can configure the Docker container to connect to multiple networks defined on the Docker host. When you do, you can specify the external network driver for connecting a container to an existing network managed by Docker Compose.yml file.
Unique IP addresses

It is extremely important to understand that IP addresses must be unique. When you decide to configure static IP addresses for your Docker containers, you must understand you are taking management of the IP addresses into your hands instead of these being handled automatically.
Docker Compose IP FAQs

What is Docker Compose? Docker Compose is a way to configure multiple containers using a single configuration file. You can define which containers you want to include and the network configuration for one or multiple containers.

Why set static IPs for your Docker container configuration? Static IPs ensure your containers have the same network configuration each recomposed time. This is great for database services where you must point your frontend web services to a specific database container.

Why do IP addresses need to be unique? IP addresses must be unique. This requirement is not unique to Docker. It is a requirement for TCP/IP networks in general.
Wrapping Up

Docker Compose is a robust way to manage your Docker container creation, deployment, and configuration. It allows the creation of new Docker containers in a single configuration file. In addition to allowing Docker to manage IP addresses for the provisioned containers automatically, you can also set static IP addresses on your Docker containers within the Docker Compose file.

In addition to configuring static IP addresses, you can also configure additional networking details. These additional network configuration parameters include DNS server settings, default gateway, and other network environment variables.
