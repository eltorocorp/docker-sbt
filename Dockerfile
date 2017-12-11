FROM openjdk:8-alpine

# The bash shell is required by Scala utilities
RUN apk add --no-cache bash

# Install build dependencies
RUN apk add --no-cache --virtual=.dependencies tar wget

# Install Scala
RUN wget -O- "http://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.tgz" \
    | tar xzf - -C /usr/local --strip-components=1

# Install SBT
RUN wget -O- "https://cocl.us/sbt-0.13.16.tgz" \
    |  tar xzf - -C /usr/local --strip-components=1 \
    && sbt exit

# Configure and Prefetch SBT
RUN mkdir -p /app
ENV SBT_OPTS=-Duser.home=/app
RUN sbt exit
RUN chmod a+w /app -R

# add git
RUN apk add --no-cache git

# add glibc for protoc
RUN apk add --no-cache ca-certificates openssl wget
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.26-r0/glibc-2.26-r0.apk
RUN apk add --no-cache glibc-2.26-r0.apk
RUN rm glibc-2.26-r0.apk

# Remove build dependencies
RUN apk del --no-cache .dependencies

VOLUME /app
WORKDIR /app

CMD ["sbt"]
