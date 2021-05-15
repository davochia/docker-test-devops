FROM ubuntu:latest

RUN apt-get -y update --fix-missing
RUN apt-get -y upgrade
RUN apt-get -y install default-jdk
RUN apt-get -y install wget

WORKDIR /opt

ENV DLLINK https://downloads.apache.org/tomcat/tomcat-10/v10.0.6/bin/
ENV TOMCAT apache-tomcat-10.0.6
ENV TOMCATTZ ${TOMCAT}.tar.gz
ENV TARGETD /opt/${TOMCAT}

RUN wget ${DLLINK}/${TOMCATTZ}
RUN tar -xvf ${TOMCATTZ}


ENV WAR */test-tomcat.war

ADD ${WAR} ${TARGETD}/webapps

RUN sed -i 's/port="8080"/port="8088"/' ${TOMCAT}/conf/server.xml


#ADD */test-tomcat.war /opt/apache-tomcat-10.0.6/webapps


EXPOSE 8088


CMD [ "/opt/apache-tomcat-10.0.6/bin/catalina.sh", "run" ]
