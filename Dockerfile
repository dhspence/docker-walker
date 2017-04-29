FROM ubuntu:xenial
MAINTAINER David Spencer <dspencer@wustl.edu>

LABEL \
    description="Haley's Walkers"

RUN apt-get update -y && apt-get install -y \
    ant \
    apt-utils \
    build-essential \
    bzip2 \
    default-jdk \
    default-jre \
    gcc-multilib \
    git \
    libncurses5-dev \
    libnss-sss \
    nodejs \
    tzdata \
    unzip \
    wget \
    zlib1g-dev

##########
#Haley's GATK 3.6#
##########
ENV maven_package_name apache-maven-3.3.9
RUN cd /tmp/ && wget -q http://mirror.nohup.it/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.zip

RUN cd /opt/ \
    && git clone --recursive https://github.com/abelhj/gatk.git
    
RUN cd /opt/ && unzip /tmp/${maven_package_name}-bin.zip \
    && rm -rf /tmp/${maven_package_name}-bin.zip LICENSE NOTICE README.txt \
    && cd /opt/ \
    && cd /opt/gatk && /opt/${maven_package_name}/bin/mvn verify -P\!queue
