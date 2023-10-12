# Use the official Payara Server 5 image as the base image
FROM payara/server-full:5.2021.5

# Create a directory to store SSH keys and copy your id_rsa key
USER root
RUN apt-get update && apt-get install -y git
RUN mkdir -p /root/.ssh
COPY key/id_rsa /root/.ssh/

# Set the correct permissions for the SSH key
RUN chmod 600 /root/.ssh/id_rsa
USER payara

# Copy your WAR file from a URL or the local filesystem to the deployments directory
COPY erp-services-1.0.war /opt/payara/deployments/erp-services-1.0.war


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
CMD ["asadmin", "start-domain", "--verbose"]