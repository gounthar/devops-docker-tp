
# Explication du script `validator.sh`

Le script `validator.sh` permet de valider la sécurité des images Docker en construisant d'abord une image à partir du Dockerfile situé dans le répertoire `./src`, puis en exécutant un conteneur de cette image pour vérifier que l'utilisateur n'est pas `root` et que le conteneur peut fonctionner en mode lecture seule.

Le script supprime automatiquement les conteneurs après exécution.

## Modification du fichier `Dockerfile`

Création d'un utilisateur appelé `www` et configuration du répertoire de travail sur le répertoire personnel de l'utilisateur avec les commandes:
RUN adduser -h /home/www -D www
WORKDIR /home/www

Cette modification limite les privilèges du processus exécuté dans le conteneur, réduisant ainsi les risques de sécurité en cas d'exploitation d'une vulnérabilité du conteneur.

## Modification du script `start.sh`

Modification du répertoire du fichier en `/tmp/started.time`. Ce changement permet au conteneur de s'exécuter en lecture seule car `/tmp` permet des écritures temporaires même lorsque le reste du système de fichiers est configuré en lecture seule.
