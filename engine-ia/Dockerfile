FROM arm32v6/tomcat:8-alpine
LABEL maintainer "Johannes Wettinger <jowettinger@gmail.com>, Michael Wurster <miwurster@gmail.com>, Benjamin Weder <Benjamin.Weder@web.de>"

# add qemu binary to build on circle ci
COPY qemu/qemu-arm-static /usr/bin/qemu-arm-static

ARG DOCKERIZE_VERSION=v0.3.0

ENV TOMCAT_USERNAME admin
ENV TOMCAT_PASSWORD admin

# add certificates for alpine linux to enable wget on github
RUN apk update \                                                                                                                                                                                                                        
  &&   apk add ca-certificates wget \                                                                                                                                                                                                      
  &&   update-ca-certificates

RUN rm /dev/random && ln -s /dev/urandom /dev/random \
    && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-armhf-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-armhf-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-armhf-$DOCKERIZE_VERSION.tar.gz

ADD tomcat-users.xml.tpl ${CATALINA_HOME}/conf/tomcat-users.xml.tpl
ADD server.xml ${CATALINA_HOME}/conf/server.xml
ADD manager.xml ${CATALINA_HOME}/conf/Catalina/localhost/manager.xml

EXPOSE 8080

CMD dockerize -template ${CATALINA_HOME}/conf/tomcat-users.xml.tpl:${CATALINA_HOME}/conf/tomcat-users.xml \
    ${CATALINA_HOME}/bin/catalina.sh run
