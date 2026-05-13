FROM httpd:2.4

# Enable modules required for Laravel front-controller routing and PHP-FPM proxying.
RUN sed -i \
    -e 's/^#LoadModule rewrite_module/LoadModule rewrite_module/' \
    -e 's/^#LoadModule proxy_module/LoadModule proxy_module/' \
    -e 's/^#LoadModule proxy_fcgi_module/LoadModule proxy_fcgi_module/' \
    -e 's/^#LoadModule headers_module/LoadModule headers_module/' \
    -e 's/^#LoadModule expires_module/LoadModule expires_module/' \
    /usr/local/apache2/conf/httpd.conf

COPY docker/offline/apache/httpd-app.conf /usr/local/apache2/conf/extra/httpd-app.conf

RUN echo "Include conf/extra/httpd-app.conf" >> /usr/local/apache2/conf/httpd.conf

EXPOSE 80

CMD ["httpd-foreground"]