# Use the official Ubuntu 20.04 image
FROM ubuntu:jammy

ARG SOURCE_BRANCH
ARG TARGET_MACHINE

# Set the maintainer label
LABEL maintainer="Jan Esser"

# Set environment variable to prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    file \
    git \
    diffstat \
    unzip \
    texinfo \
    gawk \
    chrpath \
    wget \
    nano \
    cpio \
    zstd \
    python3 \
    python3-pip \
    python3-pexpect \
    xz-utils \
    debianutils \
    iputils-ping \
    lz4 \
    sudo \
    locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user to run Yocto builds
RUN useradd -ms /bin/bash yoctouser

# Create the workspace directory
RUN mkdir -p /workspace

# Change ownership of the workspace directory
RUN chown -R yoctouser:yoctouser /workspace

# Switch to the non-root user
USER yoctouser

# Set the working directory & clone repo
WORKDIR /workspace
RUN git clone https://github.com/OE4T/tegra-demo-distro.git --branch "${SOURCE_BRANCH}" --single-branch

WORKDIR /workspace/tegra-demo-distro
RUN git submodule update --init
RUN chmod +x ./setup-env
RUN ./setup-env --machine "${TARGET_MACHINE}" # jetson-nano-devkit-emmc

# Set CMD to run the shell script
CMD ["/bin/bash"]
