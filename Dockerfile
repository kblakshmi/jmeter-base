#
# Dockerfile for a base jmeter image
# 
# Usage:
# It is unlikely that you will need to run this image.
# It forms the basis for other images.
#

FROM fedora
MAINTAINER Sri Sankaran sri@redhat.com

# Describe the environment
ENV JDK_VERSION 1.7.0
ENV JMETER_VERSION 3.1

# Install the JDK
RUN yum install -y java-$JDK_VERSION-openjdk-devel.x86_64 && rm -rf /var/cache/yum

# Install JMeter
RUN cd /var/lib && \
  curl http://psg.mtu.edu/pub/apache/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz -o /var/lib/jmeter-$JMETER_VERSION.tgz && \
  tar xf jmeter-$JMETER_VERSION.tgz && \
  rm -f jmeter-$JMETER_VERSION.tgz

ENV EXTRAS_LIBS_SET_VERSION=1.3.0

RUN apt-get -y update && \
	apt-get -y install \
	wget \
	unzip 

RUN wget http://jmeter-plugins.org/downloads/file/JMeterPlugins-ExtrasLibs-${EXTRAS_LIBS_SET_VERSION}.zip && \
	unzip -o JMeterPlugins-ExtrasLibs-${EXTRAS_LIBS_SET_VERSION}.zip -d ${JMETER_HOME}

RUN rm -rf JMeterPlugins-ExtrasLibs-${EXTRAS_LIBS_SET_VERSION}.zip && \
	apt-get -y remove wget unzip && \
	apt-get -y --purge autoremove && \
	apt-get -y clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
