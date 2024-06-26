# This image likely contains network utilities like netstat, ifconfig, etc.
FROM donch/net-tools

# D'après les layers de l'image, nous somme sur alpine, ajout du package pour les users
RUN apk add --no-cache shadow

# Copy the start.sh script from the local file system into the /bin directory of the image.
# This script will be run when a container is started from this image.
COPY start.sh /bin/start.sh

# Permet l'éxécution du script au lancement du container par tout le monde
RUN chmod +x /bin/start.sh

# Expose port 4321 in the container.
# This makes the port accessible to processes outside of the container.
EXPOSE 4321

# Ajout du user www pour remplacer root qui pose problème
RUN useradd -ms /bin/bash www

# Utilisation du user www
USER www

# Set /bin/start.sh as the entrypoint of the image.
# The entrypoint is the command that is run when a container is started from this image.