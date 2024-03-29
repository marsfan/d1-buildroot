
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# NOTE: Use --target argument to specify which stage to stop build at
# Will allow making multiple containers from one dockerfile
FROM ubuntu:20.04 as base
LABEL maintainer="Gabriel Roper <gabrielcroper@gmail.com"
LABEL license="Mozilla Public License 2.0"
LABEL source="https://github.com/marsfan/d1-buildroot"
RUN apt update && \
    apt upgrade -y && \
    apt install -y sed make binutils build-essential gcc g++ bash patch python3-minimal \
    gzip bzip2 perl tar cpio unzip rsync file bc wget libncurses-dev \
    && apt autoremove --purge -y \
    && rm -rf /var/lib/apt/lists/* 
ARG BUILDROOT_VERSION=2021.11
RUN wget https://buildroot.org/downloads/buildroot-${BUILDROOT_VERSION}.tar.gz \
    && tar xf buildroot-${BUILDROOT_VERSION}.tar.gz -C /home \
    && rm buildroot-${BUILDROOT_VERSION}.tar.gz
WORKDIR /home/buildroot-${BUILDROOT_VERSION}
RUN make nezha_defconfig
CMD [ "/bin/bash" ]

FROM base as toolchain
RUN make toolchain
CMD ["/bin/bash"]

FROM toolchain as prebuilt
RUN make
CMD ["/bin/bash"]

