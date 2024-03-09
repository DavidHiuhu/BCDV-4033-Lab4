terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 2.16.0"
    }
  }
}

provider "docker" {
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  name  = "nginx"
  image = docker_image.nginx.name 
  ports {
    internal = 80
    external = 8081
  }
}

resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"
}

resource "docker_container" "ubuntu" {
  name  = "ubuntu"
  image = docker_image.ubuntu.name 

  command = ["/bin/bash", "-c", "tail -f /dev/null"]
}
