FROM arm32v6/tomcat:8-alpine
LABEL maintainer "Benjamin Weder <Benjamin.Weder@web.de>"

# add qemu binary to build on circle ci
COPY qemu/qemu-arm-static /usr/bin/qemu-arm-static

RUN rm /dev/random && ln -s /dev/urandom /dev/random \
    && rm -rf ${CATALINA_HOME}/webapps/*

# add the prebuild ui
COPY code/target/opentosca-ui.war ${CATALINA_HOME}/webapps/ROOT.war
   
EXPOSE 8080

CMD ${CATALINA_HOME}/bin/catalina.sh run