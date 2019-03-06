FROM debian:stretch
ADD https://appdown.rrysapp.com/rrshareweb_centos7.tar.gz /tmp/
RUN tar -xf /tmp/rrshareweb_centos7.tar.gz -C /opt/ && rm /tmp/rrshareweb_centos7.tar.gz
COPY ./entrypoint.sh /entrypoint.sh
WORKDIR /opt/rrshareweb
VOLUME /var/lib/rrshareweb
EXPOSE 3001
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

