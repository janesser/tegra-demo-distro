#!/bin/bash

# https://oneuptime.com/blog/post/2026-03-16-set-cpu-limits-podman-container/view

# TODO https://stackoverflow.com/questions/78810525/load-environment-variables-from-env-file-in-bash
source .env

if [[ -n "$EXT_DRIVE_NAME" ]]; then
  podman run -d -t \
    -v /media/$USER/$EXT_DRIVE_NAME/$PATH_PREFIX-tmp:/workspace/$PROJ_NAME/build/tmp:rw \
    -v /media/$USER/$EXT_DRIVE_NAME/$PATH_PREFIX-downloads:/workspace/$PROJ_NAME/build/downloads:rw \
    -v /media/$USER/$EXT_DRIVE_NAME/$PATH_PREFIX-deploy:/workspace/$PROJ_NAME/build/deploy:rw \
    --userns=keep-id \
    --replace --name $BUILDER_NAME $BUILDER_NAME
else
  podman run -d -t \
    --replace --name $BUILDER_NAME $BUILDER_NAME
fi
