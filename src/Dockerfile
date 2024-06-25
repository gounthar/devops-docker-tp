# Dockerfile for creating a Docker image with net-tools and a custom start script.

# Utilisation de l'image donch/net-tools comme base
FROM donch/net-tools

# Copier le script start.sh dans le répertoire /bin de l'image
COPY start.sh /bin/start.sh

# Création d'un utilisateur et d'un groupe sans privilèges
RUN addgroup -S info && adduser -S asmae -G info

# Définir les permissions pour start.sh
RUN chown theUser:info /bin/start.sh && chmod +x /bin/start.sh

# Création d'un répertoire spécifique pour l'application
RUN mkdir -p /tmp/dossierTP && chown asmae:info /tmp/dossierTP

# Exposer le port 4321 dans le conteneur
EXPOSE 4321

# Définir l'utilisateur par défaut (non-root)
USER asmae

# Définir /bin/start.sh comme point d'entrée de l'image
ENTRYPOINT ["/bin/start.sh"]

# Définir "nc -l 4323" comme commande par défaut de l'image
CMD ["nc", "-l", "4323"]
