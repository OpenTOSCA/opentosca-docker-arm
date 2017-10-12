FROM armv7/armhf-ubuntu
LABEL maintainer "Benjamin Weder <Benjamin.Weder@web.de>"

# add qemu binary to build on circle ci
COPY qemu/qemu-arm-static /usr/bin/qemu-arm-static

# add the prebuild ui
COPY code/target /opt/opentosca/ui
WORKDIR /opt/opentosca/ui

# install Java
RUN apt-get update -qq && apt-get install -qqy software-properties-common
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update -qq && \
  apt-get install -qqy oracle-java8-installer
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN ls
    
# run UI on container start
CMD java -jar opentosca-ui.war --server.port=8080