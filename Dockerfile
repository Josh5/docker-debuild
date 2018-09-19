FROM ubuntu:16.04
MAINTAINER Josh.5 "jsunnex@gmail.com"


# Install
RUN \
    echo "**** install base packages ****" \
        && apt-get update \
        && apt-get install -y \
            cron \
            openssl \
            bzip2 \
            nano \
            ca-certificates \
            curl \
            wget \
            software-properties-common \
            dialog \
            htop \
            apt-utils \
            git \
            binutils \
            libstring-shellquote-perl \
            build-essential \
            libfontconfig \
            rsyslog \
            language-pack-en-base \
    && \
    echo "**** install php packages ****" \
        && apt-get install -y \
            php7.0 \
            php7.0-fpm \
            php7.0-json \
            php7.0-mbstring \
            php7.0-xml \
            php7.0-bz2 \
            php7.0-curl \
            php7.0-gd \
            php7.0-mcrypt \
            php7.0-soap \
            php7.0-xml \
            php7.0-zip \
            php7.0-intl \
            php7.0-dev \
            composer \
    && \
    echo "**** install Debuild ****" \
        && apt-get install -y \
            devscripts \
            rpm \
    && \
    echo "**** create docker user and make our folders ****" \
        && groupmod -g 1000 users \
        && useradd -u 1000 -U -d /config -s /bin/false docker \
        && usermod -G users docker \
        && mkdir -p \
            /app \
            /config \
            /defaults \
    && \
    echo "**** cleanup ****" && \
        rm -rf /tmp/* \
        && \
        rm -rf /var/lib/apt/lists/*


# environment settings
ENV HOME="/config" \
    PATH="$HOME/.composer/vendor/bin/:${PATH}" \
    COMPOSER_HOME=/config/.composer


# intended ports and volumes
VOLUME \
    /config \
    /app