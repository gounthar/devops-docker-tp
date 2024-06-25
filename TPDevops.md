Applincourt Alexis 3 INFO

Apres lecture des fichiers du TP, j'ai pu constater directement le blocage avec le root acces

Apres la jonction entre le TP et Gitpod, j'ai exectué le fichier validator.sh qui se lance correctement mais ne peut aller jusqu'au bout car pb de root acces

- chmod +x ./src/start.sh
- ./validator.sh
= User cannot be root!
Container cannot run in read-only mode!

Apres une erreur Docker je me rends compte qu'on va devoir modifier les acces au container

L'image de base n'est pas considéré comme debian mais alpine, j'insère donc la commande suivante dans le Dockerfile

RUN apk update && apk add shadow
RUN useradd -ms /bin/bash newuser
USER newuser

Création de newuser avec succès

Changement du nom d'url dans le start.sh avec un /tmp 

Réussite de la seconde erreur
