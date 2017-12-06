## docker-sbt
This is a docker image for building SBT projects.  It is especially useful when using Jenkins Pipelines, as this image explicitly works properly even when the UID:GID is overridden, as Jenkins Pipeline does.

### Using local ivy caches
To use a local ivy2 cache, map it to /app/.ivy2 within the image:

    -v /var/lib/jenkins/.ivy2:/app/.ivy2

### Using local sbt configuration
To use a local sbt configuration, map it to /app/.sbt within the image:

    -v /var/lib/jenkins/.sbt:/app/.sbt
