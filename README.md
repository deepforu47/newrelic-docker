# newrelic-docker
Docker integration with New Relic

## Build Docker Image
docker build -t newrelicinfra1.11.45/tomcat8.5.57 .

## Start Docker container
docker run --rm        --name newrelic-infra        --cap-add=SYS_PTRACE     -v "/:/host:ro"     -v "/var/run/docker.sock:/var/run/docker.sock"  -e  NRIA_LICENSE_KEY=$NRIA_LICENSE_KEY    -p 8180:8080 newrelicinfra1.11.45/tomcat8.5.57


## Try to access tomcat on http://localhost:8180

## Check New Relic Infrastructure Section for new container statistics
