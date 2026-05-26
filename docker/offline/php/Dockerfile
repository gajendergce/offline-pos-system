FROM php:7.4-fpm

# System dependencies
RUN apt-get update && apt-get install -y \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configure GD with freetype + jpeg support
RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg

# Install core PHP extensions
RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    zip \
    xml \
    opcache \
    tokenizer \
    ctype \
    json


# Install Composer 2.2 (last version supporting PHP 7.4)
COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer

# PHP config: opcache
RUN echo "opcache.enable=1"                    >> /usr/local/etc/php/conf.d/opcache.ini \
 && echo "opcache.memory_consumption=128"      >> /usr/local/etc/php/conf.d/opcache.ini \
 && echo "opcache.max_accelerated_files=10000" >> /usr/local/etc/php/conf.d/opcache.ini \
 && echo "opcache.validate_timestamps=1"       >> /usr/local/etc/php/conf.d/opcache.ini

# PHP config: upload/memory limits
RUN echo "upload_max_filesize=50M" >> /usr/local/etc/php/conf.d/limits.ini \
 && echo "post_max_size=50M"       >> /usr/local/etc/php/conf.d/limits.ini \
 && echo "memory_limit=256M"       >> /usr/local/etc/php/conf.d/limits.ini \
 && echo "max_execution_time=120"  >> /usr/local/etc/php/conf.d/limits.ini

# Set working directory
WORKDIR /var/www/html

# Step 1: Copy composer files first and install WITHOUT scripts
#         (scripts need bootstrap/app.php which isn't copied yet)
COPY composer.json composer.lock ./
COPY database/seeds ./database/seeds
COPY database/factories ./database/factories

RUN composer install \
    --no-interaction \
    --no-dev \
    --optimize-autoloader \
    --prefer-dist \
    --no-scripts

# Step 2: Copy the full application source
COPY . .

# Step 3: Now run composer scripts (package:discover etc.)
#         bootstrap/app.php is available at this point
RUN composer dump-autoload --optimize \
 && php artisan package:discover --ansi || true

# Ensure storage directory structure exists
RUN mkdir -p storage/framework/sessions \
             storage/framework/views \
             storage/framework/cache/data \
             storage/logs \
             bootstrap/cache

# Fix permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage \
    && chmod -R 775 /var/www/html/bootstrap/cache

# Cache Laravel config/routes/views for performance
RUN php artisan config:cache || true \
 && php artisan route:cache  || true \
 && php artisan view:cache   || true

EXPOSE 9000

CMD ["php-fpm"]
