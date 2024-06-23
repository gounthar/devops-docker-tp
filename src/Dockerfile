# Dockerfile for creating a Docker image with net-tools and a custom start script.

# Use the donch/net-tools image as the base image.
# This image likely contains network utilities like netstat, ifconfig, etc.
FROM donch/net-tools

# Copy the start.sh script from the local file system into the /bin directory of the image.
# This script will be run when a container is started from this image.
COPY start.sh /bin/start.sh

# Commentaire : Cette commande permet de donner les droits d'éxécution aun fichier start.sh 

RUN chmod +x /bin/start.sh

# Expose port 4321 in the container.
# This makes the port accessible to processes outside of the container.
EXPOSE 4321

# Commentaire : Je crée le user 'www' en lui donnant ces paramètres :
# -S : Crée un utilisateur système.
# -D : Crée l'utilisateur sans mot de passe.
# -h : Spécifie le répertoire home de l'utilisateur.

RUN adduser -S -D -h /bin/bash www

USER www
WORKDIR /home/www

# Set /bin/start.sh as the entrypoint of the image.
# The entrypoint is the command that is run when a container is started from this image.
ENTRYPOINT ["/bin/start.sh"]

# Set "nc -l 4323" as the default command of the image.
# This command will be run when a container is started from this image, unless the command is overridden.
CMD ["nc", "-l", "4323"]
