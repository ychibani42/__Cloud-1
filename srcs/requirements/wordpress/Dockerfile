FROM debian:buster

ARG PHP_VERSION=8.2 \
	DB_NAME \
	DB_USER \
	DB_PASS

RUN	apt-get update -y;\
	apt-get upgrade -y;\
	apt-get install wget -y;\
	apt-get install -y wget gnupg2 lsb-release;\
	wget https://packages.sury.org/php/apt.gpg && apt-key add apt.gpg;\
	echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list;\
	apt update -y && apt install -y php8.2 \
	php8.2-fpm \
	php8.2-mysql \
	php8.2-redis \
	unzip && \
	sed -i "s|listen = /run/php/php8.2-fpm.sock|listen = 9000|g" \
	/etc/php/8.2/fpm/pool.d/www.conf && \
   	sed -i "s|;clear_env = no|clear_env = no|g" \
	/etc/php/8.2/fpm/pool.d/www.conf && \
    	rm -rf /var/cache/apt/*

WORKDIR /var/www

RUN	wget https://wordpress.org/latest.zip && \
    	unzip latest.zip && \
	cp -rf wordpress/* . && \
rm -rf wordpress latest.zip

COPY ./conf/wp-config-create.sh .

RUN bash wp-config-create.sh && rm wp-config-create.sh && \
	chmod -R 0777 wp-content/

CMD ["/usr/sbin/php-fpm8.2", "-F"]
