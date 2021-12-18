
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# NOTE: Use --target argument to specify which stage to stop build at
# Will allow making multiple containers from one dockerfile
FROM ubuntu:20.04 as base
RUN apt update && \
    apt install -y sed make binutils build-essential gcc g++ bash patch python3-minimal \
    gzip bzip2 perl tar cpio unzip rsync file bc wget libncurses-dev \
    && rm -rf /var/lib/apt/lists/* 
ARG BUILDROOT_VERSION
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

