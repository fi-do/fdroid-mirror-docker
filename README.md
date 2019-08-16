# fdroid-mirror-docker
Small dockerfile to support the fdroid network with an additional repo mirror.

## Table of Contents
* [About the Project](#about-the-project)
* [Getting Started](#getting-started)
  * [Requirements](#requirements)
  * [Installation](#installation)
* [Usage](#usage)
* [Contact](#contact)

## About the Project

Try to contribute to a project i used a lot. So i started to work on an docker container to support the fdroid network
with additional bandwidth.

## Getting Started

My goal is to release a simple docker file.

### Requirements

* docker
* rsync password from fdroid

### Installation

Clone module in your python path.

## Usage


## Example


```

## Contact

Dominik

## Todo
* Include a volume to persistence the rsync folder
* Complete the readme
* Checkout some docker best practices to make a proper docker file
* Improve fixes

## Fix
* Limit Bandwith docker exec -t containername  tc qdisc add dev eth0 root tbf rate 5mbit burst 32kbit latency 400ms && \
