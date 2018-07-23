FROM ubuntu:16.04
MAINTAINER Keiran Tai <tkeiran@gmail.com>

RUN apt-get update && apt-get install -y unzip \
  && rm -rf /tmp/* && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/local/src

COPY sources/jdk-8u144-linux-x64.tar.gz /usr/local/src
COPY sources/wso2am-2.5.0.zip /usr/local/src

RUN tar zxvf /usr/local/src/jdk-8u144-linux-x64.tar.gz -C /opt/ \
  && ln -s /opt/jdk1.8.0_144 /opt/java

ENV JAVA_HOME /opt/java
ENV PATH ${JAVA_HOME}/bin:${PATH}

RUN unzip /usr/local/src/wso2am-2.5.0.zip -d /opt

RUN rm -rf /usr/local/src/*

# Management Console
EXPOSE 9443 9763
# API Manager
EXPOSE 10397 8280 8243 7711

WORKDIR /opt/wso2am-2.5.0
CMD ["bin/wso2server.sh", "--console"]
