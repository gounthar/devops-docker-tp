# Dockerfile for creating a Docker image with net-tools and a custom start script.

# Use the donch/net-tools image as the base image.
# This image likely contains network utilities like netstat, ifconfig, etc.
FROM donch/net-tools
RUN apk update && apk add shadow


# Copy the start.sh script from the local file system into the /bin directory of the image.
# This script will be run when a container is started from this image.
COPY start.sh /bin/start.sh

#Donne les droits d'execution du fichier start.sh
RUN chmod +x /bin/start.sh

# Expose port 4321 in the container.
# This makes the port accessible to processes outside of the container.
EXPOSE 4321

#Création d'un user "newuser" afin de ne pas executer en root
#Changement d'utilisater avec USER
#Définit le répertoire de travail avec WORKDIR
RUN useradd -ms /bin/bash newuser
USER newuser
WORKDIR /home/newuser

# Set /bin/start.sh as the entrypoint of the image.
# The entrypoint is the command that is run when a container is started from this image.
ENTRYPOINT ["/bin/start.sh"]

# Set "nc -l 4323" as the default command of the image.
# This command will be run when a container is started from this image, unless the command is overridden.
CMD ["nc", "-l", "4323"]
