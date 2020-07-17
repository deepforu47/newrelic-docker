FROM centos:8

RUN curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/8/x86_64/newrelic-infra.repo

RUN mkdir /opt/tomcat/ && yum -y --nogpgcheck install newrelic-infra && yum clean all

RUN yum install -y \
       java-1.8.0-openjdk \
       java-1.8.0-openjdk-devel

ENV JAVA_HOME /etc/alternatives/jre

ADD newrelic-infra.yml /etc/

# Set log level to a sane default
ENV NRIA_LOGLEVEL="info"
ENV NRIA_VERBOSE=0


# Really you ought to pass this at deployment time.
ENV NRIA_LICENSE_KEY="null"

WORKDIR /opt/tomcat
COPY apache-tomcat-8.5.57.tar .
RUN tar xvf apache*.tar
RUN mv apache-tomcat-8.5.57/* /opt/tomcat/.  && rm -rf apache*.tar

COPY start_tomcat my_first_process
COPY start_nria my_second_process
COPY wrapper.sh my_wrapper_script.sh
CMD ./my_wrapper_script.sh
