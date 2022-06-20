# https://github.com/jupyter/docker-stacks
FROM jupyter/datascience-notebook:350928623d27

USER root
RUN apt-get update && apt-get install -y default-jre-headless tdsodbc unixodbc-dev g++ libaio1 unzip && apt-get clean && rm -rf /var/lib/apt/lists/*

# intersystems odbc
RUN mkdir -p /opt/intersystems && mkdir -p /opt/oracle
COPY libirisodbcur6435.so /opt/intersystems
COPY odbcinst.ini /etc

# intersystems jdbc
COPY intersystems-jdbc-3.2.0.jar /usr/jars/

# Oracle ic
COPY instantclient-basiclite-linux.x64-21.4.0.0.0dbru.zip /opt/oracle
RUN unzip /opt/oracle/instantclient-basiclite-linux.x64-21.4.0.0.0dbru.zip -d /opt/oracle && sh -c "echo /opt/oracle/instantclient_21_4 > /etc/ld.so.conf.d/oracle-instantclient.conf" && ldconfig
RUN rm /opt/oracle/instantclient-basiclite-linux.x64-21.4.0.0.0dbru.zip

# pip
COPY shared-requirements.txt ./
RUN pip install --no-cache-dir -r shared-requirements.txt

USER ${NB_UID}

