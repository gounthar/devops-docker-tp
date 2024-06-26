# Dockerfile for creating a Docker image with net-tools and a custom start script.

# Use the donch/net-tools image as the base image.
# This image likely contains network utilities like netstat, ifconfig, etc.
FROM donch/net-tools

# Create the /home/www directory and set permissions for non-root user
RUN mkdir -p /home/www && chown -R nobody:nogroup /home/www

# Copy the start.sh script from the local file system into the /bin directory of the image.
# This script will be run when a container is started from this image.
COPY start.sh /bin/start.sh

# Make the start.sh script executable
RUN chmod +x /bin/start.sh

# Expose port 4321 in the container.
# This makes the port accessible to processes outside of the container.
EXPOSE 4321

# Set non-root user for running the container
USER nobody

# Set /bin/start.sh as the entrypoint of the image.
# The entrypoint is the command that is run when a container is started from this image.
ENTRYPOINT ["/bin/start.sh"]

# Set "nc -l 4323" as the default command of the image.
# This command will be run when a container is started from this image, unless the command is overridden.
CMD ["nc", "-l", "4323"]
