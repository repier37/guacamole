# Guacamole database container using MySQL
#
# VERSION 0.1

FROM mysql:5.7

# Update these to stay in line with the official guacamole containers.
ARG GUAC_REPO=apache/guacamole-client
ARG GUAC_VERSION=1.5.5

# Fetch the needed schema files from the guacamole repo and place them where the
# container will use them when initializing the server.
ARG BASE_URL=https://raw.githubusercontent.com/${GUAC_REPO}/${GUAC_VERSION}/extensions/guacamole-auth-jdbc/modules/guacamole-auth-jdbc-mysql/schema/
ADD 001-initdb.sql /docker-entrypoint-initdb.d/
ADD ${BASE_URL}002-create-admin-user.sql /docker-entrypoint-initdb.d/

# Create a simple script that will run before the schema files and modify them
# to use the database created by the MYSQL_DATABASE environment variable.
RUN echo 'sed -i "1i USE $MYSQL_DATABASE;" /docker-entrypoint-initdb.d/*.sql' > /docker-entrypoint-initdb.d/000-use-database.sh

# Change the permissions so everything can be modified and executed at runtime.
RUN chmod 777 -R /docker-entrypoint-initdb.d/