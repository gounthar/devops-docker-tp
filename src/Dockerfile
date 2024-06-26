# Utilisez l'image donch/net-tools comme image de base
FROM donch/net-tools

# Copier le script start.sh dans le répertoire /bin de l'image
COPY start.sh /bin/start.sh

# Ajouter un groupe 'docker'
RUN addgroup docker

# Créer un nouvel utilisateur 'test' sans mot de passe et avec un minimum de détails
RUN adduser --disabled-password --gecos '' test

# Ajouter l'utilisateur 'test' au groupe 'docker'
RUN adduser test docker

# Donner les permissions d'exécution au script start.sh
RUN chmod +x /bin/start.sh

# Changez l'utilisateur pour 'test'
USER test

# Définir le répertoire de travail
WORKDIR /home/test

# Exposer le port 4321 dans le conteneur
EXPOSE 4321

# Définir /bin/start.sh comme point d'entrée de l'image
ENTRYPOINT ["/bin/start.sh"]

# Définir la commande par défaut de l'image
CMD ["nc", "-l", "4323"]
