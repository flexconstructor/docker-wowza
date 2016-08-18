#FROM nimmis/java-centos:openjdk-7-jdk
FROM centos
MAINTAINER sameer@damagehead.com

ENV WOWZA_VERSION=4.3.0 \
    WOWZA_DATA_DIR=/var/lib/wowza \
    WOWZA_LOG_DIR=/var/log/wowza
RUN yum update -y \
 && yum install -y wget openjdk-7-jre expect tar python-setuptools
RUN easy_install supervisor
RUN mkdir -p /var/log/supervisor
RUN echo_supervisord_conf > /etc/supervisord.conf


COPY prepare.sh interaction.exp /app/
RUN /app/prepare.sh

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 1935/tcp 8086/tcp 8087/tcp 8088/tcp
VOLUME ["${WOWZA_DATA_DIR}", "${WOWZA_LOG_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
