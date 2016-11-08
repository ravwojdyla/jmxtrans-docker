FROM openjdk:jre
MAINTAINER Rafal Wojdyla <rav@spotify.com>

RUN wget -q http://central.maven.org/maven2/org/jmxtrans/jmxtrans/259/jmxtrans-259-all.jar

RUN mkdir -p /var/log/jmxtrans

ENV JMXTRANS_GRAPHITE_HOST localhost
ENV JMXTRANS_GRAPHITE_PORT 3000 

ENTRYPOINT ["java", \
            "-DJMXTRANS_GRAPHITE_HOST=$JMXTRANS_GRAPHITE_HOST", \
            "-DJMXTRANS_GRAPHITE_PORT=3000", \
            "-Djmxtrans.log.dir='/var/log/jmxtrans'", \
            "-jar", "/jmxtrans-259-all.jar", "-j", "/etc/jmxtrans", "-e"]