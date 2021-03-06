FROM openjdk:jre
MAINTAINER Rafal Wojdyla <rav@spotify.com>

RUN wget -q http://central.maven.org/maven2/org/jmxtrans/jmxtrans/259/jmxtrans-259-all.jar

RUN mkdir -p /var/log/jmxtrans

ENV JMXTRANS_GRAPHITE_HOST localhost
ENV JMXTRANS_GRAPHITE_PORT 2003
ENV JMXTRANS_POOL_SIZE 10
ENV JMXTRANS_WORK_QUEUE_SIZE 100000
ENV JMXTRANS_RESULT_POOL_SIZE 10
ENV JMXTRANS_RESULT_WORK_QUEUE_SIZE 100000

ENTRYPOINT ["/bin/sh", "-c", "java \
            -DJMXTRANS_GRAPHITE_HOST=$JMXTRANS_GRAPHITE_HOST \
            -DJMXTRANS_GRAPHITE_PORT=$JMXTRANS_GRAPHITE_PORT \
            -Djmxtrans.log.dir=/var/log/jmxtrans \
            -jar /jmxtrans-259-all.jar -j /etc/jmxtrans -e -s 10 \
              --query-processor-executor-pool-size $JMXTRANS_POOL_SIZE \
              --query-processor-executor-work-queue-capacity. $JMXTRANS_WORK_QUEUE_SIZE \
              --result-processor-executor-pool-size $JMXTRANS_RESULT_POOL_SIZE \
              --result-processor-executor-work-queue-capacity. $JMXTRANS_RESULT_WORK_QUEUE_SIZE"]
