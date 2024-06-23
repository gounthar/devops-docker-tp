# Utiliser l'image de base donch/net-tools
FROM donch/net-tools

# Copier le script start.sh dans le répertoire /bin
COPY start.sh /bin/start.sh

# Créer un utilisateur non-root et définir les permissions pour start.sh
RUN addgroup -S superGroupeTP && adduser -S incroyableUserTP -G superGroupeTP \
    && chown incroyableUserTP:superGroupeTP /bin/start.sh \
    && chmod +x /bin/start.sh

# Créer un répertoire temporaire spécifique à l'application
RUN mkdir -p /tmp/appTP && chown incroyableUserTP:superGroupeTP /tmp/appTP

# Exposer le port 4321
EXPOSE 4321

# Définir l'utilisateur non-root comme utilisateur par défaut
USER incroyableUserTP

# Définir /bin/start.sh comme point d'entrée de l'image
ENTRYPOINT ["/bin/start.sh"]

# Définir "nc -l 4323" comme commande par défaut de l'image
CMD ["nc", "-l", "4323"]
