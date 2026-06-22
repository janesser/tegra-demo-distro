#!/bin/bash

source .env

podman build --build-arg-file .env --no-cache -t $BUILDER_NAME .
