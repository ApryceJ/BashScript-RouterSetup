FROM centos:7

RUN yum -y install epel-release
RUN yum -y install docker
RUN yum -y install nginx
add nginx.conf /etc/nginx/

EXPOSE 443

CMD  /usr/sbin/nginx -g "daemon off;"
