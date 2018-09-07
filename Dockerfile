FROM       docker.io/centos:centos7.5.1804
MAINTAINER verdyr

ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=0 \
    JAVA_VERSION_BUILD=15

RUN yum install -y less more git wget curl httpd java-1.${JAVA_VERSION_MAJOR}.${JAVA_VERSION_MINOR} maven gradle unzip make which nano vim gdb gcc strace route iproute traceroute ethtool net-tools && yum -q clean all

LABEL df.os=centos7 df.version=0.0.1 df.client_version=0.0.1

#COPY df_client_setup.sh /opt/df/setup/df_client_setup.sh 

RUN useradd verdyr

ENV JAVA_MAX_MEM=1200m \
    JAVA_MIN_MEM=1200m

CMD ["/bin/bash"]
