#!/bin/bash
# This is a bash script for validating Docker images and containers.

set -euo pipefail
#La commande set modifie les options du shell :
#-e : le script s'arrête si une commande échoue.
#-u : le script s'arrête si une variable non définie est utilisée.
#-o pipefail : le code de sortie d'un pipeline est celui de la dernière commande ayant échoué (ou 0 si aucune commande n'a échoué).

IMG=$(echo img$$)

# Cette ligne génère un nom d'image unique en insérant  $img avec le PID du shell.
docker image build --tag $IMG ./src # --load

#Cette commande construit une image Docker à partir du DockerfileL'image est taguée avec le nom unique généré précédemment

USR=$(docker container run --rm --entrypoint=whoami $IMG )
# Cette commande exécute un conteneur à partir de l'image construite, avec l'entrypoint. 
#Le conteneur est supprimé après exécution grâce à l'option --rm.

if [[ $USR == "root" ]]; then
echo "User cannot be root!"
fi

#Si l'utilisateur dans le conteneur est root, le message d'erreur "User cannot be root!" s'affiche
docker container run -d --rm --detach --tmpfs /tmp --read-only $IMG > /dev/null
# Cette commande lance un conteneur en mode détaché 
#-d pour  exécuter le conteneur en arrière-plan.
#--rm pour supprimmer le conteneur après qu'il soit a l'arrêt 
#--tmpfs /tmp permet de monter un système de fichiers temporaire à /tmp
#--read-only : monte le système de fichiers du conteneur en lecture seule.
#La sortie de la commande est redirigée vers /dev/null pour la supprimer.

ID=$(docker container ls -laq)
# La commande récupère l'ID du dernier conteneur créé

RUNNING=$(docker container inspect -f '{{.State.Status}}' $ID)
# Cette commande inspecte le conteneur pour obtenir son état

if [[ $RUNNING == "running" ]]; then
    docker kill $ID > /dev/null
else
echo "Container cannot run in read-only mode!"
fi
# Si le conteneur est en cours d'exécution il est tué. Sinon, le message d'erreur "Container cannot run in read-only mode!" est affiché..

docker rmi $IMG > /dev/null
# Cette commande supprime l'image Docker créée précédemment. La sortie de la commande est redirigée vers /dev/null.
