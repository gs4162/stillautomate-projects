Webtop Docker Setup
-------------------

This project provides a Docker Compose setup for running a Webtop container. Webtop allows you to access a lightweight graphical desktop environment within a container.

### Requirements

-   Docker Engine installed (<https://www.docker.com/>)

### Usage

1.  **Copy the `.env.example` file to `.env` and update the variables:**
    -   Edit the `.env` file according to your needs. Refer to the descriptions below for each variable.
2.  **Start the container:**
    -   Run `docker-compose up -d` to start the container in detached mode.

### .env file explanation

The `.env` file stores sensitive configuration data for the container. Here's a breakdown of the variables:

-   `PERSISTENCE`: Set to `true` to persist container data between restarts. Defaults to `false`.
-   `PUID`: User ID for the container. Defaults to `1000`.
-   `PGID`: Group ID for the container. Defaults to `1000`.
-   `TZ`: Timezone for the container (refer to <https://www.iana.org/time-zones> for valid values). Defaults to `Pacific/Auckland`.
-   `VOLUME_PATH`: Path to the directory on your host machine that will be mounted as `/config` inside the container. This directory will store persistent data if `PERSISTENCE` is set to `true`. Defaults to `./webtop_volume`.
-   `USER`: Username for Webtop login (optional).
-   `PASSWORD`: Password for Webtop login (optional).

**Important:** It's recommended to set `USER` and `PASSWORD` for enhanced security. Leaving them blank might expose the container to unauthorized access.

### Flavor Selection

The `FLAVOR` variable in the `docker-compose.yaml` file specifies the Webtop image variant. Uncomment the desired flavor from the provided options in the file. Each flavor offers a different desktop environment (e.g., XFCE, KDE). Refer to the official Webtop documentation for detailed information on available flavors: <https://docs.linuxserver.io/images/docker-webtop/>

### Stopping and Removing the Container

-   Run `docker-compose down -v` to stop the container and remove volumes (persistent data will be lost).

### Persistence Note

If you set `PERSISTENCE` to `true` in the `.env` file, container data will be persisted in the directory specified by `VOLUME_PATH`.

### Additional Notes

-   The `docker-compose.yaml` file mounts the Docker socket (`/var/run/docker.sock`) into the container (commented out by default). This allows Docker commands to be executed from within the container if needed. Uncomment the line in the `docker-compose.yaml` file to enable this functionality.
-   The `docker-up.sh` script is a convenience script that helps manage the container lifecycle (stopping, removing, starting).
