![a rather large whale](https://cdn-images-1.medium.com/max/2000/1*GQ6CAclmEnGe7PX4pg6sSA.jpeg)

# A crash course on Docker

The quick start guide you are looking for.
You can take a look at the full article [here]() (issue #1, add article title once published).

## TL;DR
- "Why I need this?"
- Quick Start 
- Real-life scenario

## "Why I need this?"
- What is Docker?
- What is a VM?
- What is CaaS?
- Using automation

## Quick Start
- Installation

**Ubuntu**
```bash
$ sudo apt-get update
$ sudo apt-get install -y docker-ce
$ sudo systemctl status docker


// output //

● docker.service - Docker Application Container Engine
   Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
   Active: active (running) since Sun 2018-01-14 12:42:17 CET; 4h 46min ago
     Docs: https://docs.docker.com
 Main PID: 2156 (dockerd)
    Tasks: 26
   Memory: 63.0M
      CPU: 1min 57.541s
   CGroup: /system.slice/docker.service
           ├─2156 /usr/bin/dockerd -H fd://
           └─2204 docker-containerd --config /var/run/docker/containerd/containerd.toml
```

If the system service is stopped.
```bash
$ sudo systemctl start docker && sudo systemctl enable docker
```

Run Docker without **sudo**
```bash
$ sudo usermod -aG docker ${USER}
$ su - ${USER}
$ id -nG
```
If you see your username is the list of usernames, you're set.

**Mac**
Download and install.
- https://docs.docker.com/docker-for-mac/install/

**Windows**
Download and install.
- https://docs.docker.com/docker-for-windows/install/


- Create a container
```bash
$ docker create -it ubuntu:16.04 bash
```

- List all containers
```bash
$ docker ps -a

// output //
CONTAINER ID  IMAGE        COMMAND  CREATED    STATUS   PORTS  NAMES
7643dba89904  ubuntu:16.04 "bash"   X min ago  Created         name
```

- Start a container where in this case `7643dba89904` is the `<container_id>`
```bash
$ docker start 7643dba89904
```

- List only running containers
```bash
$ docker ps
```

- Connect to a container
```bash
$ docker attach 7643dba89904
```

- Delete a container
```bash
$ docker rm 7643dba89904
```

## Real-life scenario

- Create a container and bind a volume to the host machine
- In this case it will bind the current working directory from the host machine where you run the command in the terminal
```bash
$ docker create -it -v $(pwd):/var/www ubuntu:latest bash
```

- Create and start a container with a single command
- `-d` flag tells the container to run detached, in the background, meaning you can go ahead and attach to it right away.
```bash
$ docker run -it -d ubuntu:16.04 bash
```

- Stop a running container
```bash
$ docker stop <container_id>
```

### Using the config files
- Check out the **Dockerfile**, **docker-compose.yml**, and the **index.html**. 

#### Build an image from a **Dockerfile**
```bash
$ docker build . -t webserver:v1
```

- List created Docker images
```bash
$ docker images
```

### Run the created image
```bash
$ docker run -v $(pwd):/usr/share/nginx/html -d -p 8080:80 webserver:v1
```

#### Run with docker-compose
- The `-d` signals docker-compose to run detached, then you can use `$ docker-compose ps` to see what’s currently running, or stop docker-compose with `$ docker-compose stop`.
```bash
$ docker-compose up (-d)
```


### Deleting images and containers
```bash
$ docker rmi <image_id>
$ docker rm <container_id>
```

Happy Dockering! :D