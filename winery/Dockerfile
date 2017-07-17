FROM armv7/armhf-ubuntu as winery_builder

# add qemu binary to build on circle ci
COPY qemu/qemu-arm-static /usr/bin/qemu-arm-static

ARG GIT_REPO_URL=https://github.com/OpenTOSCA/winery.git
ARG GIT_BRANCH=master

#### TODO: build current Winery version ####
# Get prebuild Winery wars
RUN mkdir -p /opt/${NAME} \
    && apt-get install -qqy wget \
    && wget -P /tmp/winery/org.eclipse.winery.repository/target \
        https://github.com/OpenTOSCA/winery/releases/download/v2.0.0-M1-OpenTOSCA/winery.war \
    && wget -P /tmp/winery/org.eclipse.winery.topologymodeler/target \
        https://github.com/OpenTOSCA/winery/releases/download/v2.0.0-M1-OpenTOSCA/winery-topologymodeler.war
        
# Injecting base URL for BPMN4TOSCA Modeler
RUN apt-get update -qq && apt-get install -qqy unzip \
    && unzip /tmp/winery/org.eclipse.winery.repository/target/winery.war -d /opt/winery \
    && unzip /tmp/winery/org.eclipse.winery.topologymodeler/target/winery-topologymodeler.war -d /opt/winery-topologymodeler \
    && sed -i "sXbpmn4toscamodelerBaseURI=.*Xbpmn4toscamodelerBaseURI=../bpmn4toscaX" /opt/winery/WEB-INF/classes/winery.properties \
    && sed -i "sX#repositoryPath=.*XrepositoryPath=/var/opentosca/repositoryX" /opt/winery/WEB-INF/classes/winery.properties
    

    
FROM armv7/armhf-ubuntu as bpmn4tosca_builder

ARG GIT_REPO_URL=https://github.com/winery/BPMN4TOSCAModeler.git
ARG GIT_BRANCH=master

RUN apt-get update -qq && apt-get install -qqy software-properties-common
RUN apt-get install -qqy git && apt-get install -qqy wget

# Install nodejs for ARM
RUN wget https://nodejs.org/dist/v6.11.1/node-v6.11.1-linux-armv7l.tar.xz \
    && tar -xJf node-v6.11.1-linux-armv7l.tar.xz \
    && rm node-v6.11.1-linux-armv7l.tar.xz \
    && cp -R node-v6.11.1-linux-armv7l/* /usr/local/

RUN git clone --recursive --depth=1 ${GIT_REPO_URL} -b ${GIT_BRANCH} /opt/bpmn4tosca \
    && cd /opt/bpmn4tosca \
    && npm install -g grunt-cli \
    && npm install && grunt

   
   
FROM arm32v6/tomcat:8-alpine
LABEL maintainer "Johannes Wettinger <jowettinger@gmail.com>, Oliver Kopp <kopp.dev@gmail.com>, Michael Wurster <miwurster@gmail.com>, Benjamin Weder <Benjamin.Weder@web.de>"

RUN rm /dev/random && ln -s /dev/urandom /dev/random \
    && rm -rf ${CATALINA_HOME}/webapps/*

COPY --from=winery_builder /opt/winery ${CATALINA_HOME}/webapps/ROOT
COPY --from=winery_builder /opt/winery-topologymodeler ${CATALINA_HOME}/webapps/winery-topologymodeler
COPY --from=bpmn4tosca_builder /opt/bpmn4tosca/dist ${CATALINA_HOME}/webapps/bpmn4tosca

EXPOSE 8080

CMD ${CATALINA_HOME}/bin/catalina.sh run