FROM centos:7

MAINTAINER PRASANJIT SINGH <mailprasanjit@gmail.com>

ENV S3_TMP /tmp/s3cmd.zip
ENV S3_ZIP /tmp/s3cmd-master
ENV RDS_VERSION 1.19.004
ENV JAVA_HOME /usr/lib/jvm/default-jvm
ENV AWS_RDS_HOME /usr/local/RDSCli-${RDS_VERSION}
ENV PATH ${PATH}:${AWS_RDS_HOME}/bin:${JAVA_HOME}/bin:${AWS_RDS_HOME}/bin
ENV PAGER more

WORKDIR /tmp

RUN yum update -y
RUN yum install -y epel-release
RUN yum install -y telnet net-tools wget openssh openssh-server openssh-clients openssl-libs
RUN yum install -y python-setuptools python-dev python-pip gcc openssl openssl-devel python-devel
RUN pip install --upgrade pip && \
    pip install butterfly && \
    pip install libsass
RUN yum install -y \
      bash \
      bash-completion \
      groff \
      less \
      curl \
      jq \
      unzip \
      python \
      python-pip \
      openssh &&\
    pip install --upgrade \
      awscli \
	  aws-tools \
      pip \
      python-dateutil &&\
    ln -s /usr/bin/aws_bash_completer /etc/profile.d/aws_bash_completer.sh &&\
    curl -sSL --output ${S3_TMP} https://github.com/s3tools/s3cmd/archive/master.zip &&\
    unzip -q ${S3_TMP} -d /tmp &&\
    mv ${S3_ZIP}/S3 ${S3_ZIP}/s3cmd /usr/bin/ &&\
    rm -rf /tmp/* &&\
    mkdir ~/.aws &&\
    chmod 700 ~/.aws

# Expose volume for adding credentials
VOLUME ["~/.aws"]
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
