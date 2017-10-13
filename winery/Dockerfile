FROM arm32v6/tomcat:8-alpine
LABEL maintainer "Benjamin Weder <Benjamin.Weder@web.de>"

# add qemu binary to build on circle ci
COPY qemu/qemu-arm-static /usr/bin/qemu-arm-static

# add the prebuild winery
COPY code/org.eclipse.winery.repository.rest/target/winery.war tmp/winery/winery.war
COPY code/org.eclipse.winery.repository.ui/target/winery-ui.war tmp/winery/winery-ui.war
COPY code/org.eclipse.winery.topologymodeler/target/winery-topologymodeler.war tmp/winery/winery-topologymodeler.war
COPY code/org.eclipse.winery.workflowmodeler/target/winery-workflowmodeler.war tmp/winery/winery-workflowmodeler.war

RUN cd tmp/winery && ls

RUN mkdir -p /opt/winery
     
# Injecting base URL for BPMN4TOSCA Modeler
RUN apk update && apk upgrade && apk add unzip \
    && unzip tmp/winery/winery.war -d /opt/winery \
    && sed -i "sXbpmn4toscamodelerBaseURI=.*Xbpmn4toscamodelerBaseURI=/winery-workflowmodelerX" /opt/winery/WEB-INF/classes/winery.properties \
    && sed -i "sX#repositoryPath=.*XrepositoryPath=/var/opentosca/repositoryX" /opt/winery/WEB-INF/classes/winery.properties   

RUN rm /dev/random && ln -s /dev/urandom /dev/random \
    && rm -rf ${CATALINA_HOME}/webapps/*
    
RUN mkdir -p /var/opentosca/repository

RUN cp -r /opt/winery ${CATALINA_HOME}/webapps/winery \
    && cp -r tmp/winery/winery-ui.war ${CATALINA_HOME}/webapps/ROOT.war \
    && cp -r tmp/winery/winery-topologymodeler.war ${CATALINA_HOME}/webapps \
    && cp -r tmp/winery/winery-workflowmodeler.war ${CATALINA_HOME}/webapps 

EXPOSE 8080

CMD ${CATALINA_HOME}/bin/catalina.sh run