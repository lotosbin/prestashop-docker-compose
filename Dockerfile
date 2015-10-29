FROM php:5.6-apache
# Install modules
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libjpeg-dev \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd
RUN docker-php-ext-install mysql mysqli pdo pdo_mysql
RUN docker-php-ext-install zip sockets mbstring
RUN echo 'magic_quotes_gpc = Off' >> /usr/local/etc/php/conf.d/php.ini \
    && echo 'magic_quotes_runtime = Off' >> /usr/local/etc/php/conf.d/php.ini \
    && echo 'magic_quotes_sybase = Off' >> /usr/local/etc/php/conf.d/php.ini

CMD ["apache2-foreground"]
