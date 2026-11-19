FROM php:8.1-apache

# Встановлюємо системні залежності та розширення для роботи з архівами та MySQL
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo_mysql mysqli zip

# Вмикаємо mod_rewrite для Apache
RUN a2enmod rewrite

# Змінюємо DocumentRoot на /var/www/html/public
RUN sed -i 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/000-default.conf

# Встановлюємо Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html