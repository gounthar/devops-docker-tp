# Dockerfile for creating a Docker image with net-tools and a custom start script.

# Use the donch/net-tools image as the base image.
# This image likely contains network utilities like netstat, ifconfig, etc.
FROM donch/net-tools

# On crée un nouvel utilisateur "nouveluser" que l'on vient mettre dans un nouveau groupe système nommé nouveaugroupe
RUN addgroup -S nouveaugroupe && adduser -S nouveluser -G nouveaugroupe

# Copy the start.sh script from the local file system into the /bin directory of the image.
# This script will be run when a container is started from this image.
COPY start.sh /bin/start.sh

# Expose port 4321 in the container.
# This makes the port accessible to processes outside of the container.
EXPOSE 4321

# On définie l'utilisateur avec lequel va s'exécuter notre container (c'est l'utilisateur que l'on à créé juste avant l.8)
# On s'assure donc que le container sera exécuté avec un utilisateur qui n'es pas root
USER nouveluser

# Set /bin/start.sh as the entrypoint of the image.
# The entrypoint is the command that is run when a container is started from this image.
ENTRYPOINT ["/bin/start.sh"]

# Set "nc -l 4323" as the default command of the image.
# This command will be run when a container is started from this image, unless the command is overridden.
CMD ["nc", "-l", "4323"]
