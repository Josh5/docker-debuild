FROM ubuntu:16.04
LABEL maintainer="Josh.5 <jsunnex@gmail.com>"


ARG ORACLE_INSTALLER_URL="https://launchpad.net/~webupd8team/+archive/ubuntu/java/+build/7520848/+files/oracle-java7-installer_7u80+7u60arm-0~webupd8~1_all.deb"
ARG CLOSURE_COMPILER_URL="https://dl.google.com/closure-compiler/compiler-20131014.tar.gz"


# Add local files
COPY root/ /


# Install
RUN \
    echo "**** install base packages ****" \
        && apt-get update \
        && apt-get install -y --no-install-recommends \
            software-properties-common \
        && apt-get install -y \
            ant \
            apt-utils \
            bash-completion \
            binutils \
            build-essential \
            bzip2 \
            ca-certificates \
            cron \
            curl \
            dialog \
            git \
            htop \
            imagemagick \
            iputils-ping \
            java-common \
            language-pack-en-base \
            libfontconfig \
            libstring-shellquote-perl \
            locales \
            mercurial \
            nano \
            openssh-server \
            openssl \
            rsyslog \
            software-properties-common \
            unzip \
            wget \
    && \
    echo "**** install java 7 ****" \
        && wget -q --show-progress -O "/tmp/oracle-java7-installer.deb" ${ORACLE_INSTALLER_URL} \
        && echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
        && dpkg -i /tmp/oracle-java7-installer.deb \
    && \
    echo "**** install php packages ****" \
        && apt-get install -y \
            php7.0 \
            php7.0-bz2 \
            php7.0-curl \
            php7.0-dev \
            php7.0-fpm \
            php7.0-gd \
            php7.0-intl \
            php7.0-json \
            php7.0-mbstring \
            php7.0-mcrypt \
            php7.0-soap \
            php7.0-xml \
            php7.0-xml \
            php7.0-zip \
            composer \
    && \
    echo "**** install Debuild ****" \
        && apt-get install -y \
            devscripts \
            rpm \
    && \
    echo "**** install requirejs ****" \
        && apt-get install -y \
            npm \
        && npm install -g requirejs \
    && \
    echo "**** install closure compiler ****" \
        && mkdir -p /opt/closure-compiler \
        && curl -L -o /tmp/closure-compiler.tar.gz ${CLOSURE_COMPILER_URL} \
        && tar zxfp "/tmp/closure-compiler.tar.gz" -C /opt/closure-compiler \
        && chmod a+rw /opt/closure-compiler/* \
    && \
    echo "**** cleanup ****" \
        && apt-get clean \
        && rm -rf /tmp/* \
        && rm -rf /var/tmp/* \
        && rm -rf /var/tmp/* \
        && rm -rf /var/cache/oracle-jdk7-installer/* \
        && rm -rf /var/lib/apt/lists/*


# environment settings
ENV HOME="/config" \
    PATH="$HOME/.composer/vendor/bin/:${PATH}" \
    COMPOSER_HOME=/config/.composer


# intended ports and volumes
VOLUME \
    /config \
    /app
