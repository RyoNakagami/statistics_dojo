#!/bin/bash


# COLOR
RESETCOLOR=$'\e[0m'
CYAN=$'\e[36m'
RED=$'\e[31m'

# ARGS
TAG=$1

if [ -z $TAG ]; then
    TAG="latest"
fi

read -p "${CYAN}Are you sure to build ryonak/statistics-dojo:$TAG? (T/F): ${RESETCOLOR}" tf
case "$tf" in
    [tT]*) 
        docker buildx build --platform "linux/amd64" \
                            --file ./Dockerfile \
                            --tag "ryonak/statistics-dojo:$TAG" --push .
        exit 0 ;;
    [fF]*)
        echo "${RED}Abort${RESETCOLOR}"
        exit 1;;
    *) 
        echo "${RED}This is yes/no question. Abort${RESETCOLOR}"
        exit 1;;
esac
