
curl -o $SLAVE_PATH/slave.jar http://$JENKINS_HOST_NAME:$JENKINS_HOST_PORT/jnlpJars/slave.jar
java -jar $SLAVE_PATH/slave.jar -jnlpUrl http://$JENKINS_HOST_NAME:$JENKINS_HOST_PORT/computer/$JENKINS_SLAVE_NAME/slave-agent.jnlp
