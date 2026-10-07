FROM php:8.3-apache

RUN apt-get update \
    && apt-get install -y git unzip libzip-dev libsqlite3-dev \
    && docker-php-ext-install zip pdo_sqlite \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Pasang Laravel baru, lalu timpa dengan file Cookies Ku
RUN composer create-project laravel/laravel . --no-interaction --prefer-dist

COPY app/ app/
COPY database/ database/
COPY resources/ resources/
COPY routes/ routes/

ENV APP_ENV=production \
    APP_DEBUG=false \
    LOG_CHANNEL=stderr \
    DB_CONNECTION=sqlite \
    APACHE_DOCUMENT_ROOT=/var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
