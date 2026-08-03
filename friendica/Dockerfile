FROM docker.io/library/friendica:2026.05-apache@sha256:ef6058c42ca87ea2da525e9d57cc557b7398ddf8305a9e179e777038ebeea54c
RUN cp /entrypoint.sh /usr/local/bin/friendica-upstream-entrypoint
COPY entrypoint.sh /usr/local/bin/friendica-railway-entrypoint
COPY apache-start.sh /usr/local/bin/apache-friendica-start
RUN chmod +x /usr/local/bin/friendica-railway-entrypoint /usr/local/bin/apache-friendica-start
EXPOSE 80
ENTRYPOINT ["tini", "--", "/usr/local/bin/friendica-railway-entrypoint"]
