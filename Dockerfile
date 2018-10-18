FROM josh5/ubuntu-oracle-java7-jdk
LABEL maintainer="Josh.5 <jsunnex@gmail.com>"


# Install
RUN \
    echo "**** install base packages ****" \
        && apt-get update \
        && apt-get install -y \
            ant \
            apt-utils \
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
            language-pack-en-base \
            libfontconfig \
            libstring-shellquote-perl \
            mercurial \
            nano \
            openssl \
            rsyslog \
            software-properties-common \
            wget \
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
    echo "**** cleanup ****" \
        && apt-get clean \
        && rm -rf /tmp/* \
        && rm -rf /var/lib/apt/lists/*


# environment settings
ENV HOME="/config" \
    PATH="$HOME/.composer/vendor/bin/:${PATH}" \
    COMPOSER_HOME=/config/.composer


# intended ports and volumes
VOLUME \
    /config \
    /app
