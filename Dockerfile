FROM ckan/ckan

RUN apt-get update -qq

# Install Pillow dependencies (argh!)
RUN apt-get update && apt-get install -y \
        python-dev python-tk python3.4-dev \
        libffi-dev libxml2-dev libxslt1-dev \
        libjpeg62-turbo-dev libfreetype6-dev liblcms2-dev libwebp-dev \
        tcl8.5-dev tk8.5-dev zlib1g-dev
RUN ln -s /lib/x86_64-linux-gnu/libz.so.1 /lib/
RUN ln -s /usr/lib/x86_64-linux-gnu/libfreetype.so.6 /usr/lib/
RUN ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so.62 /usr/lib/

ENV CKAN_INI $CKAN_CONFIG/ckan.ini
ENV CKAN_TEST_INI $CKAN_CONFIG/test-core.ini
ENV SRCDIR $CKAN_HOME/src/

ADD ./plugins/ $SRCDIR

ADD ckan-mapaction-config.ini $CKAN_CONFIG/ckan.ini
ADD test-core.ini $CKAN_CONFIG/test-core.ini

COPY ./ckan-entrypoint.sh /
RUN chmod +x /ckan-entrypoint.sh
ENTRYPOINT ["/ckan-entrypoint.sh"]
CMD ["ckan-paster","serve", "--reload", "/etc/ckan/default/ckan.ini"]
