# Dockerfile for creating a Docker image with net-tools and a custom start script.

FROM donch/net-tools

# Create a non-root user
RUN useradd -ms /bin/bash noroot

# Copy the start.sh script from the local file system into the /bin directory of the image.
COPY start.sh /home/noroot/start.sh
RUN chmod +x /home/noroot/start.sh

# Expose port 4321 in the container.
EXPOSE 4321

# Change to the non-root user
USER noroot

# Set /home/myuser/start.sh as the entrypoint of the image.
ENTRYPOINT ["/home/noroot/start.sh"]

# Set "nc -l 4323" as the default command of the image.
CMD ["nc", "-l", "4323"]
