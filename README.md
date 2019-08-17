# fdroid-mirror-docker
Small dockerfile to support the fdroid network with an additional repo mirror.

## Table of Contents
* [About the Project](#about-the-project)
* [Getting Started](#getting-started)
  * [Requirements](#requirements)
  * [Installation](#installation)
* [Usage](#usage)
* [Contact](#contact)
* [Todo](#todo)
* [Fix](#fix)

## About the Project

I want to contribute to a project i personally use. So i started to wirte a
dockerfile to easily support the fdroid network with another mirror.

## Getting Started

Have ~50GB free space for the "main" repo and optional ~150 GB space for the
archive. Create an docker volume, get some monitoring environment done and
start the container.
For more information visit https://f-droid.org/en/docs/Running_a_Mirror/

### Requirements

* docker
* rsync password from fdroid

### Installation

```
docker build -t fdroid-mirror --build-arg domain=fdroid.fi-do.io --build-arg \
RSYNC_PASSWORD=thepassword --no-cache .

docker volume create fdroid-repo
```

## Usage

```
docker run --name fdroid-mirror-repo -d --cap-add NET_ADMIN \
-v fdroid-repo:/var/www/fdroid/fdroid/repo/ fdroid-mirror:latest
```

## Example


## Contact

Dominik

## Todo
* Complete the readme
* Checkout some docker best practices to make a proper docker file
* Improve fixes

## Fix
* Limit Bandwidth docker exec -t containername  tc qdisc add dev eth0 root tbf rate 5mbit burst 32kbit latency 400ms
