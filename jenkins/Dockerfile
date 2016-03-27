

FROM java:8-jdk

ENV JENKINS_HOME /var/jenkins/home
ENV JENKINS_WAR /var/jenkins/war

ARG JENKINS_VERSION
ENV JENKINS_VERSION ${JENKINS_VERSION:-1.654}
ENV JENKINS_UC https://updates.jenkins-ci.org
ENV JENKINS_SLAVE_AGENT_PORT 50000

ENV JENKINS_URL http://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war

RUN mkdir -p ${JENKINS_HOME}
RUN mkdir -p ${JENKINS_WAR}

# Jenkins home directory is a volume, so configuration and build history
# can be persisted and survive image upgrades
VOLUME ${JENKINS_HOME}

RUN apt-get update \
 && apt-get install -y curl \
 && rm -rf /var/lib/apt/lists/* \
 && curl -fL ${JENKINS_URL} -o ${JENKINS_WAR}/jenkins.war \
 && (cd ${JENKINS_WAR} && jar xvf jenkins.war) \
 && rm ${JENKINS_WAR}/jenkins.war

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

# `/usr/share/jenkins/ref/` contains all reference configuration we want
# to set on a fresh new installation. Use it to bundle additional plugins
# or config file with your custom jenkins Docker image.
RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d

#ENV COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log
#COPY jenkins.sh /usr/local/bin/jenkins.sh

ENTRYPOINT ["/bin/tini", "--"]
#CMD java --webroot=/var/jenkins $JAVA_OPTS -jar /usr/share/jenkins/jenkins.war --webroot=/var/jenkins $JENKINS_OPTS
CMD java -jar $JENKINS_WAR/winstone.jar --webroot=$JENKINS_WAR

# from a derived Dockerfile, can use `RUN plugins.sh active.txt` to setup /usr/share/jenkins/ref/plugins from a support bundle
COPY plugins.sh /var/jenkins/plugins.sh
