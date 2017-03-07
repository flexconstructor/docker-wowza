FROM wowzamedia/wowza-streaming-engine-linux:latest
MAINTAINER flexconstructor@gmail.com

ENV WOWZA_VERSION=4.6.0
ENV JAVA_HOME=/usr/local/WowzaStreamingEngine-${WOWZA_VERSION}/java
ENV PATH=$PATH:$JAVA_HOME/bin

RUN apt-get -y update && apt-get -y install openssl

WORKDIR /usr/local/WowzaStreamingEngine-${WOWZA_VERSION}/conf
RUN keytool -genkey -keysize 2048 -alias wowzaprivatekey -keyalg RSA \
    -keystore ssl.instrumentisto.com.jks \
    -dNAME "CN=localhost, \
            OU=http://localhost, \
            O=localhost, \
            L=Sofia, S=Sofia, \
            C=Bulgaria" \
    -storepass qwerty123 -alias wowzaprivatekey -keypass qwerty123

RUN mkdir webrtc && chmod +x webrtc
RUN mkdir -p /usr/local/WowzaStreamingEngine-${WOWZA_VERSION}/applications/webrtc \
&& chmod +x  /usr/local/WowzaStreamingEngine-${WOWZA_VERSION}/applications/webrtc
COPY ./conf/Application.xml webrtc/Application.xml
COPY ./conf/VHost.xml VHost.xml
COPY ./conf/Server.xml Server.xml
WORKDIR /usr/local/WowzaStreamingEngine
RUN mkdir -p htdocs/webrtc
COPY ./html htdocs/webrtc



