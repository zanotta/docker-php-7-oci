FROM webdevops/php-apache:7.4
RUN apt update
RUN apt install -y libaio1 libaio-dev

ADD instantclient-basic.zip /tmp/
ADD instantclient-sdk.zip /tmp/
RUN mkdir -p /opt/oracle
RUN unzip /tmp/instantclient-basic.zip -d /opt/oracle/
RUN unzip /tmp/instantclient-sdk.zip -d /opt/oracle/
RUN ln -s /opt/oracle/instantclient_19_21 /opt/oracle/instantclient
ENV LD_LIBRARY_PATH /opt/oracle/instantclient
#RUN ln -s /opt/oracle/instantclient/libclntsh.so.12.1 /opt/oracle/instantclient/libclntsh.so
RUN echo 'instantclient,/opt/oracle/instantclient' | pecl install oci8-2.2.0
RUN echo "extension=oci8" > $(pecl config-get ext_dir)/oci8.ini