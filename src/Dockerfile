# Utilisation de l'image donch/net-tools comme base
FROM donch/net-tools

# Copy the start.sh script from the local file system into the /bin directory of the image.
# This script will be run when a container is started from this image.
COPY start.sh /bin/start.sh

# Création de l'utilisateur sans privilèges
RUN addgroup -S myNewGroup && adduser -S theUser -G myNewGroup

# Initialisation des permissions d'interaction avec start.sh
RUN chown theUser:myNewGroup /bin/start.sh && chmod +x /bin/start.sh

# Création d'un répertoire spécifique à l'application
RUN mkdir -p /tmp/dossierTP && chown theUser:myNewGroup /tmp/dossierTP

# Expose port 4321 in the container.
# This makes the port accessible to processes outside of the container.
EXPOSE 4321

# Définir l'utilisateur par défaut
USER theUser

# Set /bin/start.sh as the entrypoint of the image.
# The entrypoint is the command that is run when a container is started from this image.
ENTRYPOINT ["/bin/start.sh"]

# Set "nc -l 4323" as the default command of the image.
# This command will be run when a container is started from this image, unless the command is overridden.
CMD ["nc", "-l", "4323"]
