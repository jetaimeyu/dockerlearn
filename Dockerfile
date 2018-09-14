# 指定基础镜像
FROM webdevops/php-nginx:alpine

# 指定制作镜像的联系人（镜像创建者）
MAINTAINER jetaimeyu <yu@jetaime.top>

RUN rm -rf /etc/nginx/conf.d
RUN rm -rf /opt/docker/etc/php/fpm/pool.d/application.conf
RUN rm -rf /etc/php7/php.ini
COPY phpweb.conf /etc/nginx/conf.d/phpweb.conf
COPY application.conf /opt/docker/etc/php/fpm/pool.d/application.conf
COPY php.ini /etc/php7/php.ini
COPY nginx.conf /etc/nginx/nginx.conf
COPY www /app

#COPY php-fpm.sh /opt/docker/bin/php-fpm.sh

RUN mkdir /app/Uploads
RUN chmod -R 777 /app/Uploads


RUN mkdir /app/App/Runtime
RUN chmod -R 777 /app/App/Runtime

#时区修改
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone

WORKDIR /app

#VOLUME /app/Uploads

# php-fpm使用以下配置
##EXPOSE 9000


# swoole 使用以下配置
#EXPOSE 8000

#CMD ["nginx","-g","daemon off;"]

CMD ["supervisord"]