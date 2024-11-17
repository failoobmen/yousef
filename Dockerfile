# Используем образ Ubuntu 22.04
FROM ubuntu:22.04

# Устанавливаем необходимые пакеты
RUN apt-get update && apt-get install -y \
    apache2 \
    mysql-server \
    git \
    wget \
    curl \
    lsb-release \
    ca-certificates \
    apt-transport-https \
    software-properties-common \
    debconf-utils 


RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Устанавливаем PHP 8.3
RUN add-apt-repository ppa:ondrej/php -y && \
    apt-get update && apt-get install -y \
    php8.3 \
    libapache2-mod-php8.3 \
    php8.3-mysql \
    php-mbstring \
    php-zip \
    php-gd \
    php-json \
    php-curl

# Настраиваем Apache
RUN a2enmod php8.3
RUN a2enmod rewrite

# Настройка MySQL
# Изменение bind-address для разрешения подключений
RUN sed -i "s/bind-address\s*=.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

# Обновляем права на каталог с сокетом MySQL
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld

# Запуск MySQL и создание пользователя и базы данных
RUN service mysql start && \
    mysql -e "CREATE USER 'admin'@'%' IDENTIFIED BY 'admin_password';" && \
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;" && \
    mysql -e "FLUSH PRIVILEGES;" && \
    mysql -e "CREATE DATABASE phpmyadmin;"

# Настройка автоматических ответов для phpMyAdmin через debconf
RUN echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections && \
    echo 'phpmyadmin phpmyadmin/app-password-confirm password admin_password' | debconf-set-selections && \
    echo 'phpmyadmin phpmyadmin/mysql/admin-pass password admin_password' | debconf-set-selections && \
    echo 'phpmyadmin phpmyadmin/mysql/app-pass password admin_password' | debconf-set-selections && \
    echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections && \
    echo 'phpmyadmin phpmyadmin/db/dbname string phpmyadmin' | debconf-set-selections

# Устанавливаем phpMyAdmin без интерактивных запросов
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y phpmyadmin

# Ссылка phpMyAdmin в Apache
RUN ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin

# Обновляем конфигурацию phpMyAdmin для использования localhost вместо сокета
RUN sed -i "s/localhost/127.0.0.1/" /etc/phpmyadmin/config-db.php

# Клонируем репозиторий с использованием access token
# Замените <your_access_token> и <your_repo> на реальные значения
RUN rm -rf /var/www/html/*
#RUN git clone https://kzm-dev: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@github.com/DrTiget/kzm_blog.git /var/www/html/
RUN git clone https://github.com/failoobmen/yousef.git /var/www/html/
# Настраиваем права доступа
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Открываем порты для Apache и MySQL
EXPOSE 80
EXPOSE 3306

# Запускаем MySQL и Apache
CMD service mysql start && service apache2 start && tail -f /dev/null
