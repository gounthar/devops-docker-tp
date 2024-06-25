# Dockerfile for creating a Docker image with net-tools and a custom start script.

# Use the donch/net-tools image as the base image.
FROM donch/net-tools

# Copy the start.sh script from the local file system into the /bin directory of the image.
COPY start.sh /bin/start.sh

# Ensure the script is executable.
RUN chmod +x /bin/start.sh

# Expose port 4321 in the container.
EXPOSE 4321


USER nobody

# Set /bin/start.sh as the entrypoint of the image.
ENTRYPOINT ["/bin/start.sh"]

# Set "nc -l 4323" as the default command of the image.
CMD ["nc", "-l", "4323"]
