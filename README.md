# Blynk Server Configs

Repository containing configuration for running a Blynk server locally using Docker and helper files for running the server without using Docker.

## Overview

This repository holds a minimal setup to run a Blynk server with persistent configuration and data. It uses Docker Compose to run the server service, keeps the server properties in `blynk/config/server.properties`, and stores user data in `blynk/data`. 

## Prerequisites

- Docker
- Docker Compose

## Repository structure

- `blynk/` : Docker persistent folder
  - `blynk/docker-compose.yml` : Compose definition for the Blynk server
  - `blynk/config/server.properties` : Blynk server settings (edit to change ports, auth, etc.)
  - `blynk/data/` : Persistent data mounted into the container (users, tokens, etc.)
- `scripts/` : Convenience start scripts when not using docker
  - `scripts/StartBlynkServer.sh` : Shell script to start the server (local helper)
  - `scripts/StartBlynkServer.cmd` : Windows batch equivalent

## Quick Start

Clone the repository, copy the blynk directory to a persistent location of your choosing, edit the `docker-compose.yml` file, from within the blynk directory bring up the server with:

```bash
docker-compose up -d
```

Check logs with:

```bash
docker-compose logs -f
```

To stop and remove containers:

```bash
docker-compose down
```

If you prefer the helper script Download the `server-0.41.17.jar` file from [this repository](https://github.com/Peterkn2001/blynk-server/releases) :

Linux
```bash
/path/to/.jar/file/StartBlynkServer.sh
```

Windows
```bat
\path\to\.jar\file\StartBlynkServer.cmd
```

## Configuration

- Edit `blynk/config/server.properties` to adjust server settings such as HTTP port, SSL, data retention, or SMTP settings.
- Changes to `server.properties` will be picked up after restarting the container.

```bash
docker restart blynk
```

## ⚙️ Manual User Creation

This process requires direct access to your server's data folder and a restart of the Blynk server.

| Step | Action | Description |
| :--- | :--- | :--- |
| **1. Locate Data** | Find the **Blynk data folder** (specified by the `-dataFolder` argument). | |
| **2. Copy File** | Copy an existing user file (e.g., `admin@blynk.cc.Blynk.user`). | |
| **3. Rename File** | Rename the copied file to the new user's email: `newuser@example.com.Blynk.user`. | New user account created. |
| **4. Edit File** | Open the new `.Blynk.user` file and **replace all instances** of the old email with the new email. | *Save and close the file.* |
| **5. Restart Server** | Stop the Blynk server process (e.g., `Ctrl+C` with script) and then restart it. | The server will load the new user data. Docker: `docker restart blynk`. |
| **6. Set Password** | Log into the **Admin UI** (e.g., `https://<YourServerIP>:9443/admin`). | Locate the new user and set their initial password. |

## Data persistence and backups

The `blynk/data` directory contains user data and should be regularly backed up if you don't wanna start over everytime. Copy the `blynk/data` directory to your backup location or use a scheduled job.

## Troubleshooting

- If ports are already in use, change them in `server.properties` and the Compose file.
- If the server fails to start, inspect logs for stack traces:

```bash
docker-compose logs
```

- Ensure Docker daemon is running and you have permissions to run Docker commands.
