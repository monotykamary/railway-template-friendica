FROM docker.io/library/friendica:2026.05-apache@sha256:ab14c4584eae0ee166a9bfe643f1a64523c7499faa5b9e7798a6a98b13967d0f
RUN cp /entrypoint.sh /usr/local/bin/friendica-upstream-entrypoint
COPY entrypoint.sh /usr/local/bin/friendica-railway-entrypoint
COPY apache-start.sh /usr/local/bin/apache-friendica-start
RUN chmod +x /usr/local/bin/friendica-railway-entrypoint /usr/local/bin/apache-friendica-start
EXPOSE 80
ENTRYPOINT ["tini", "--", "/usr/local/bin/friendica-railway-entrypoint"]
