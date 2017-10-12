FROM arm32v6/tomcat:8-alpine
LABEL maintainer "Benjamin Weder <Benjamin.Weder@web.de>"

# add qemu binary to build on circle ci
COPY qemu/qemu-arm-static /usr/bin/qemu-arm-static

# add the prebuild winery
COPY code tmp/winery

RUN ls
     
# Injecting base URL for BPMN4TOSCA Modeler
RUN apk update && apk upgrade && apk add unzip \
    && unzip tmp/winery/org.eclipse.winery.repository/target/winery.war -d /opt/winery \
    && sed -i "sXbpmn4toscamodelerBaseURI=.*Xbpmn4toscamodelerBaseURI=/winery-workflowmodelerX" /opt/winery/WEB-INF/classes/winery.properties \
    && sed -i "sX#repositoryPath=.*XrepositoryPath=/var/opentosca/repositoryX" /opt/winery/WEB-INF/classes/winery.properties   

RUN rm /dev/random && ln -s /dev/urandom /dev/random \
    && rm -rf ${CATALINA_HOME}/webapps/*
    
RUN mkdir -p /var/opentosca/repository

RUN cp /opt/winery ${CATALINA_HOME}/webapps/winery \
    && cp tmp/winery/org.eclipse.winery.repository.ui/target/winery-ui.war ${CATALINA_HOME}/webapps/ROOT.war \
    && cp tmp/winery/org.eclipse.winery.topologymodeler/target/winery-topologymodeler.war ${CATALINA_HOME}/webapps \
    && cp tmp/winery/org.eclipse.winery.workflowmodeler/target/winery-workflowmodeler.war ${CATALINA_HOME}/webapps 

EXPOSE 8080

CMD ${CATALINA_HOME}/bin/catalina.sh run