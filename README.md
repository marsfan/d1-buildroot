# D1 Buildroot

[![Build Containers](https://github.com/marsfan/d1-buildroot/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/marsfan/d1-buildroot/actions/workflows/docker-publish.yml)

This repository contains the files necessary to create Docker containers
that can then be used to build Linux Images for the D1 Nezha

Building the Containers is automated using GitHub actions. The containers are
re-built automatically once a week, or whenever a push is made to the master
branch.

## Container Tags

Containers are built for each full release of Buildroot that supports the
D1-Nezha. Pre-release and release candidates for Buildroot are not created.
All containers are currently based on the
[ubuntu:20.04](https://hub.docker.com/_/ubuntu) container created by Docker.
For each version of Buildroot, three containers are generated.

* base: Buildroot and dependencies installed, `nezha_defconfig` selected
* toolchain: Everying in the base image, plus the toolchain is pre-compiled
    by running `make toolchain`
* prebuilt: Everything in the toolchain image, plus a base Linux system is
    pre-compiled by running `make`.

## Manually Building Containers

If you want to manually build a container, using `docker build` will create
a container based on the newest version of Buildroot, with a Linux image
pre-compiled.


### Specifying Pre-Compilation

If you just want your container to have Buildroot and its dependencies 
installed and configured for the D1 Nezha, without pre-compiling the toolchain
or a Linux image, set Docker's `--target` option to `base`, like so:

```shell
docker build --target base .
```

If you want the container to have a pre-built toolchain, but not a pre-built
Linux image, set the `--target` option to `toolchain`, like so:

```shell
docker build --target toolchain .
```

### Specifying Buildroot Version

To specify a custom Buildroot version, use pass `BUILDROOT_VERSION` as a build
argument to Docker, and the specified version of buildroot will be
downloaded during the build process. For example, to create a container based 
on Buildroot 2021.11-rc2, run the following command:

```shell
docker build --build BUILDROOT_VERSION=2021.11-rc2 .
```
