# Use the official PHP 7.4-FPM image as a base
FROM ubuntu:latest

# Copy your custom entry point script into the container
# COPY entrypoint.sh /entrypoint.sh

# Make the custom entry point script the entry point for the container
# ENTRYPOINT ["/entrypoint.sh"]
ENV DEBIAN_FRONTEND=noninteractive


# Copy your WAR file from a URL or the local filesystem to the deployments directory
RUN apt-get update && apt-get install -y curl
RUN curl -1sLf 'https://downloads.enterprisedb.com/KNGsUSPt52tBtkMq2EFf3aHLMrNPpSxy/enterprise/setup.deb.sh' | bash

RUN apt-get install debconf-utils 

RUN echo 'edb-as15-server edb/region select Asia' | debconf-set-selections
RUN echo 'edb-as15-server edb/timezone select Ulaanbaatar' | debconf-set-selections

RUN apt-get update && apt-get -y install edb-as15-server 




# Expose ports for Nginx and PHP-FPM
EXPOSE 4848
EXPOSE 8080
EXPOSE 8181

# Set all ENV variables

ENV DB_HOST="db.example.com"
ENV DB_NAME="mydatabase"
ENV DB_USER="dbuser"
ENV DB_PASS="dbpassword"
ENV DB_SID="dbsid"
ENV DB_DRIVER="mysql"

# Start supervisor
CMD ["tail", "-f", "/dev/null"]