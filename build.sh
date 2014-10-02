#!/bin/bash

docker pull barebones/buildroot

docker run --rm -v $(pwd)/config:/buildroot/configs -v $(pwd)/output:/buildroot/output/images -e CONFIG=nodejs barebones/buildroot