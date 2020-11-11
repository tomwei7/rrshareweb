FROM debian:buster
RUN apt-get update && apt-get install -y curl
RUN curl -sSL http://appdown.rrys.tv/rrshareweb_linux_2.20.tar.gz | tar -zxf - -C /opt
COPY ./entrypoint.sh /entrypoint.sh
WORKDIR /opt/rrshareweb
VOLUME /var/lib/rrshareweb
EXPOSE 3001
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD ["/opt/rrshareweb/rrshareweb"]

