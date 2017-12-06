FROM openjdk:8-alpine

# The bash shell is required by Scala utilities
RUN apk add --no-cache bash

# Install build dependencies
RUN apk add --no-cache --virtual=.dependencies tar wget

# Install Scala
RUN wget -O- "http://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.tgz" \
    | tar xzf - -C /usr/local --strip-components=1

# Install SBT
#RUN wget -O- "https://github.com/sbt/sbt/releases/download/v0.13.16/sbt-0.13.16.tgz" \
#    |  tar xzf - -C /usr/local --strip-components=1
RUN wget -O- "https://cocl.us/sbt-0.13.16.tgz" \
    |  tar xzf - -C /usr/local --strip-components=1

# Configure and Prefetch SBT
COPY assets/sbtopts /usr/local/conf/sbtopts
RUN sbt exit
RUN chmod a+w /app -R

# add git
RUN apk add --no-cache git

# Remove build dependencies
RUN apk del --no-cache .dependencies

VOLUME /app
WORKDIR /app

CMD ["sbt"]
