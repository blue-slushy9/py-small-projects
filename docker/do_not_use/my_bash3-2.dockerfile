# Base image is Alpine Linux version 3.16
FROM alpine:3.16

# Alpine package manager will install bash version we need, as well as git;
# '--no-cache' prevents Alpine from downloading any packages that are already
# cached locally
RUN apk add --no-cache bash=3.2.57 giti

# 

