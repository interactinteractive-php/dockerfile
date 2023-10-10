# Use the official PHP 7.4-FPM image as a base
FROM php:7.4.33-fpm

# Install required packages and dependencies
RUN apt-get update && apt-get install -y \
    supervisor \
    nginx

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/vhosts.conf

# Create a directory for your PHP application
WORKDIR /var/www/html

# Install additional PHP extensions
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libmcrypt-dev \
    libxml2-dev \
    libssl-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libcurl4-openssl-dev \
    libmariadb-dev-compat \
    libonig-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        mbstring \
        pdo \
        soap \
        xml \
        gd \
        opcache \
        zip \
        mysqli \
    && pecl install mcrypt-1.0.4 \
    && docker-php-ext-enable mcrypt

RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    git \
    openssh-client

# Set up SSH key for ERP
RUN mkdir -p /root/.ssh
COPY /erp/id_rsa.pub /root/.ssh/id_rsa.pub
COPY /erp/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa.pub
RUN chmod 600 /root/.ssh/id_rsa

# Clone your private ERP
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN git clone git@github.com:interactinteractive-php/php_erp.git /var/www/html/erp/
RUN rm /root/.ssh/id_rsa /root/.ssh/id_rsa.pub

# Set up SSH key for AssetsCore
RUN mkdir -p /root/.ssh
COPY /assetscore/id_rsa.pub /root/.ssh/id_rsa.pub
COPY /assetscore/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa.pub
RUN chmod 600 /root/.ssh/id_rsa

# Clone your private AssetsCore
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN git clone git@github.com:interactinteractive-php/php_assetscore.git /var/www/html/erp/assetscore/
RUN rm /root/.ssh/id_rsa /root/.ssh/id_rsa.pub

# Set up SSH key for Helper
RUN mkdir -p /root/.ssh
COPY /helper/id_rsa.pub /root/.ssh/id_rsa.pub
COPY /helper/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa.pub
RUN chmod 600 /root/.ssh/id_rsa

# Clone your private Helper
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN git clone git@github.com:interactinteractive-php/php_helper.git /var/www/html/erp/helper/
RUN rm /root/.ssh/id_rsa /root/.ssh/id_rsa.pub

# Set up SSH key for Libs
RUN mkdir -p /root/.ssh
COPY /libs/id_rsa.pub /root/.ssh/id_rsa.pub
COPY /libs/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa.pub
RUN chmod 600 /root/.ssh/id_rsa

# Clone your private Libs
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN git clone git@github.com:interactinteractive-php/php_libs.git /var/www/html/erp/libs/
RUN rm /root/.ssh/id_rsa /root/.ssh/id_rsa.pub

# Set up SSH key for Middleware
RUN mkdir -p /root/.ssh
COPY /middleware/id_rsa.pub /root/.ssh/id_rsa.pub
COPY /middleware/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa.pub
RUN chmod 600 /root/.ssh/id_rsa

# Clone your private Middleware
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN git clone git@github.com:interactinteractive-php/php_middleware.git /var/www/html/erp/middleware/
RUN rm /root/.ssh/id_rsa /root/.ssh/id_rsa.pub

# Copy the nginx config as default
RUN mkdir -p /var/www/html/erp/config
COPY config.php /var/www/html/erp/config/config.php
COPY nginx.conf /etc/nginx/sites-available/default
RUN chmod -R 777 /etc/nginx/sites-available/default

# Copy the supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy the nginx config as default
RUN unlink /etc/nginx/sites-available/default
COPY nginx.conf /etc/nginx/sites-available/default

# Expose ports for Nginx and PHP-FPM
EXPOSE 80
EXPOSE 443
EXPOSE 9000

# Start supervisor
CMD ["/usr/bin/supervisord"]