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

# Create an Nginx Docker image
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

# Create an Nginx Docker container with explicit dependency on the Nginx image
resource "docker_container" "nginx" {
  name  = "nginx"
  image = docker_image.nginx.name

  ports {
    internal = 80
    external = 8081
  }
}

# Create an Ubuntu Docker image
resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"
}

# Create an Ubuntu Docker container with explicit dependency on the Ubuntu image
resource "docker_container" "ubuntu" {
  name  = "ubuntu"
  image = docker_image.ubuntu.name

  command = ["/bin/bash", "-c", "tail -f /dev/null"]
}

# Implicit dependency: Ubuntu container depends on Nginx container
resource "docker_container" "ubuntu_with_dependency" {
  name  = "ubuntu_with_dependency"
  image = docker_image.ubuntu.name

  command = ["/bin/bash", "-c", "tail -f /dev/null"]

  # Implicit dependency on the Nginx container
  depends_on = [
    docker_container.nginx,
  ]
}

