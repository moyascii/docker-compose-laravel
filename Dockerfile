FROM php:8.2-apache

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    nano \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    npm \
    nodejs

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Activar mod_rewrite
RUN a2enmod rewrite

# Configurar permisos de trabajo
RUN chown -R www-data:www-data /var/www && chmod -R 755 /var/www

# Copiar archivo de configuración de Apache
COPY .docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
# Instalar dependencias PHP
RUN docker-php-ext-install pdo pdo_mysql