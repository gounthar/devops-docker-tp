# Utilisation de l'image de base donch/net-tools
FROM donch/net-tools

# Création de l'utilisateur non privilégié
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Création du répertoire et changement de propriétaire pour l'utilisateur non privilégié
RUN mkdir -p /home/www && chown -R appuser:appgroup /home/www

# Copier le script start.sh dans le répertoire /bin de l'image
COPY start.sh /bin/start.sh

# Exposition du port 4321
EXPOSE 4321

# Changer l'utilisateur pour app user
USER appuser

# Définition du point d'entrée et de la commande par défaut
ENTRYPOINT ["/bin/start.sh"]

CMD ["nc", "-l", "4323"]
