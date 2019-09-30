FROM alpine:3.10.2

VOLUME /var/www/app/data
VOLUME /var/www/app/plugins
VOLUME /etc/nginx/ssl

EXPOSE 80 443

ARG VERSION

RUN apk --no-cache --update add \
    openssl unzip nginx bash ca-certificates s6 curl ssmtp mailx php7 php7-phar php7-curl \
    php7-fpm php7-json php7-zlib php7-xml php7-dom php7-ctype php7-opcache php7-zip php7-iconv \
    php7-pdo php7-pdo_mysql php7-pdo_sqlite php7-pdo_pgsql php7-mbstring php7-session php7-bcmath \
    php7-gd php7-mcrypt php7-openssl php7-sockets php7-posix php7-ldap php7-simplexml && \
    rm -rf /var/www/localhost && \
    rm -f /etc/php7/php-fpm.d/www.conf

ADD . /var/www/app
ADD docker/ /

RUN rm -rf /var/www/app/docker && echo $VERSION > /version.txt

ARG DB_RUN_MIGRATIONS
ARG DB_DRIVER
ARG DB_USERNAME
ARG DB_PASSWORD
ARG DB_HOSTNAME
ARG MAIL_FROM
ARG MAIL_TRANSPORT
ARG MAIL_SMTP_HOSTNAME
ARG MAIL_SMTP_PORT
ARG MAIL_SMTP_USERNAME
ARG MAIL_SMTP_PASSWORD
ARG MAIL_SMTP_ENCRYPTION

# config.default.php
RUN sed -i -e "s#define('DB_RUN_MIGRATIONS', true);#define('DB_RUN_MIGRATIONS', $DB_RUN_MIGRATIONS);#" /var/www/app/config.default.php
RUN sed -i -e "s#define('DB_DRIVER', 'sqlite');#define('DB_DRIVER', '$DB_DRIVER');#"                   /var/www/app/config.default.php
RUN sed -i -e "s#define('DB_USERNAME', 'root');#define('DB_USERNAME', '$DB_USERNAME');#"               /var/www/app/config.default.php
RUN sed -i -e "s#define('DB_PASSWORD', '');#define('DB_PASSWORD', '$DB_PASSWORD');#"                   /var/www/app/config.default.php
RUN sed -i -e "s#define('DB_HOSTNAME', 'localhost');#define('DB_HOSTNAME', '$DB_HOSTNAME');#"          /var/www/app/config.default.php

# config.php
RUN echo "define('MAIL_FROM', '$MAIL_FROM');"                     >> /var/www/app/config.php
RUN echo "define('MAIL_TRANSPORT', '$MAIL_TRANSPORT');"           >> /var/www/app/config.php
RUN echo "define('MAIL_SMTP_HOSTNAME', '$MAIL_SMTP_HOSTNAME');"   >> /var/www/app/config.php
RUN echo "define('MAIL_SMTP_PORT', $MAIL_SMTP_PORT);"             >> /var/www/app/config.php
RUN echo "define('MAIL_SMTP_USERNAME', '$MAIL_SMTP_USERNAME');"   >> /var/www/app/config.php
RUN echo "define('MAIL_SMTP_PASSWORD', '$MAIL_SMTP_PASSWORD');"   >> /var/www/app/config.php
RUN echo "define('MAIL_SMTP_ENCRYPTION', $MAIL_SMTP_ENCRYPTION);" >> /var/www/app/config.php

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD []
