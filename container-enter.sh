#!/bin/bash

source .env

podman exec -it $BUILDER_NAME bash -c ". ./setup-env --machine $TARGET_MACHINE; bash"
