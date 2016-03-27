FROM java:8-jdk

ENV SLAVE_PATH=/var/jenkins-slave \
    JENKINS_HOST_PORT=8080

RUN mkdir -p ${SLAVE_PATH}
COPY connect.sh ${SLAVE_PATH}/connect.sh
RUN chmod 755 ${SLAVE_PATH}/connect.sh

CMD ${SLAVE_PATH}/connect.sh

