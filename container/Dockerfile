FROM armv7/armhf-ubuntu:14.04
LABEL maintainer "Benjamin Weder <Benjamin.Weder@web.de>"

# add qemu binary to build on circle ci
COPY qemu/qemu-arm-static /usr/bin/qemu-arm-static

# add the prebuild container
COPY code/org.opentosca.container.product/target/products/org.opentosca.container.product/linux/gtk/x86_64 /opt/opentosca/container

WORKDIR /opt/opentosca/container

# Install Java
RUN apt-get update -qq && apt-get install -qqy software-properties-common
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update -qq && \
  apt-get install -qqy oracle-java8-installer
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
    
EXPOSE 1337

# Find the equinox launcher jar in the product and execute on startup
CMD java -Declipse.ignoreApp=true -Dosgi.noShutdown=true -Dorg.osgi.service.http.port=1337 \
    -jar $(find ./plugins -type f -name "org.eclipse.equinox.launcher_*.jar")
