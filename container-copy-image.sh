#!/bin/bash

source .env

podman cp $BUILDER_NAME:/workspace/tegra-demo-distro/build/tmp/deploy/images/$TARGET_MACHINE/Image .
