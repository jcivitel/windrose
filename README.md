[![](https://img.shields.io/maintenance/yes/2026)](https://github.com/jcivitel/)
[![Static Badge](https://img.shields.io/badge/GitHub-jcivitell-green?logo=github)](https://github.com/jcivitel/windrose)
[![Docker Pulls](https://img.shields.io/docker/pulls/jcivitell/windrose)](https://hub.docker.com/r/jcivitell/windrose)
[![Docker Stars](https://img.shields.io/docker/stars/jcivitell/windrose)](https://hub.docker.com/r/jcivitell/windrose)
[![Docker Image Size](https://img.shields.io/docker/image-size/jcivitell/windrose/latest)](https://hub.docker.com/r/jcivitell/windrose)


# What is Windrose?
Windrose is a survival crafting game where players explore mysterious islands, gather resources, build shelters, and survive against the elements. This Docker image contains the dedicated server for the game.

<a href="https://store.steampowered.com/app/3041230/Windrose/"><img src="https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/3041230/7e838d87d787735d5d29d72777c5ee55653dfb2b/header.jpg" alt="logo" width="400"/></img></a>

---

# How to use this image
## Setting up game server

**Running a Windrose dedicated server**

1. Run using a bind mount for data persistence on container recreation. Replace the following fields before executing the command:
```console
$ mkdir -p $(pwd)/windrose-data
$ chmod 777 $(pwd)/windrose-data # Makes sure the directory is writeable by the unprivileged container user
$ docker run -d --net=host \
    -v $(pwd)/windrose-data:/home/steam/windrose-dedicated/ \
    --name=windrose-dedicated jcivitell/windrose
```

**The container will automatically update the game on startup, so if there is a game update just restart the container.**

# Configuration
## Environment Variables
Feel free to overwrite these environment variables, using -e (--env):
```dockerfile
WR_SERVERNAME="Windrose Server"   (Set the visible name for your private server)
WR_PORT=7777                      (Windrose server listen port tcp_udp)
WR_PASSWORD=""                    (Server password, leave empty for no password)
WR_MAXPLAYERS=4                   (Max Players, recommended: 4)
WR_INVITECODE="CHANGE"            (Custom 6+ character join code, case-sensitive, alphanumeric)
WR_WORLDID="default"              (World Island ID, must match world folder)
```

## Server Configuration
The server uses `ServerDescription.json` for configuration which is automatically generated from environment variables.

For world configuration, you can mount your own `WorldDescription.json` in the appropriate directory.

# Contributors
[![Contributors Display](https://badges.pufler.dev/contributors/jcivitel/windrose?size=50&padding=5&bots=false)](https://github.com/jcivitel/windrose/graphs/contributors)
