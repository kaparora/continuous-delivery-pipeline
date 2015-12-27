FROM mysql:latest
RUN apt-get update
RUN apt-get install -y openjdk-7-jre-headless
COPY new-entry-point.sh /new-entry-point.sh
ENTRYPOINT ["/new-entry-point.sh"]
CMD ["mysqld"]
