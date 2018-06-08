FROM armv7/armhf-ubuntu:14.04
LABEL maintainer "Benjamin Weder <Benjamin.Weder@web.de>"

ARG DOCKERIZE_VERSION=v0.3.0

ENV PUBLIC_HOSTNAME localhost
ENV CONTAINER_REPOSITORY_HOSTNAME localhost
ENV ENGINE_PLAN_HOSTNAME localhost
ENV ENGINE_PLAN_PORT 9443
ENV ENGINE_PLAN_SERVICES_PORT 9763
ENV ENGINE_IA_HOSTNAME localhost
ENV ENGINE_IA_PORT 8080
ENV CONTAINER_DEPLOYMENT_TESTS false

# add qemu binary to build on circle ci
COPY qemu/qemu-arm-static /usr/bin/qemu-arm-static

# add the prebuild container
COPY code/org.opentosca.container.product/target/products/org.opentosca.container.product/linux/gtk/x86_64 /opt/opentosca/container

WORKDIR /opt/opentosca/container

# Install wget 
RUN apt-get update -qq && apt-get install -qqy wget && apt-get install -qqy software-properties-common

# Install Java
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update -qq && \
  apt-get install -qqy oracle-java8-installer
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Install dockerize
RUN rm /dev/random && ln -s /dev/urandom /dev/random \
    && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-armhf-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-armhf-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-armhf-$DOCKERIZE_VERSION.tar.gz

# Add config file with placeholders
ADD config.ini.tpl /opt/opentosca/container/config.ini.tpl
    
EXPOSE 1337

# Replace the config file with environment variables. Find the equinox launcher jar in the product and execute it on startup.
CMD dockerize -template /opt/opentosca/container/config.ini.tpl:/opt/opentosca/container/configuration/config.ini \
    java -Declipse.ignoreApp=true -Dosgi.noShutdown=true -Dorg.osgi.service.http.port=1337 \
    -jar $(find ./plugins -type f -name "org.eclipse.equinox.launcher_*.jar")
