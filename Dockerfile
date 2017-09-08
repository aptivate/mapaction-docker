FROM ckan/ckan

ENV SRCDIR $CKAN_HOME/src/plugins

ADD ./src/ $SRCDIR

ADD ckan-mapaction-config.ini $CKAN_CONFIG/ckan.ini

COPY ./ckan-entrypoint.sh /
RUN chmod +x /ckan-entrypoint.sh
ENTRYPOINT ["/ckan-entrypoint.sh"]
CMD ["ckan-paster","serve", "--reload", "/etc/ckan/default/ckan.ini"]
