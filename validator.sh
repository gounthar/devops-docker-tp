#!/bin/bash
# This is a bash script for validating Docker images and containers.

set -euo pipefail
#Cette commande permet de configurer le shell pour quitter le shell en cas d'érreur dans le prompt, traite les variables inconnu ou indéfini comme des erreurs et le dernier trait assure que le pipeline échoue si il y a une erreur. 

IMG=$(echo img$$)

#Cette commande créer une image docker qui utilise le même ID du shell actuel

docker image build --tag $IMG ./src # --load

#Cette commande créer une image docker a partir du fichier source Dockerfile, le fichier iso a un nom unique générer auparavant, et l'option finale --load assure que l'image qui viens d'être créer dans le Docker daemon si on utilise le docker buildx.

USR=$(docker container run --rm --entrypoint=whoami $IMG )
#Cette commande éxécute un container docker à partir de l'image créer auparavant, il éxécute whoami et stock la sortie de la commande dans une variable USR.

if [[ $USR == "root" ]]; then
echo "User cannot be root!"
fi

#Vérifie si l'utilisateur se trouvant dans le container est root, si c'est le cas il affiche "User cannot be root !"

docker container run --rm --detach --tmpfs /tmp --read-only $IMG > /dev/null

#Execute le container Docker en mode détaché (--detach), le container est supprimé avec l'éxécution (--rm), un nouveau système de fichier temporaire est monter dans le /tmp avec l'option (--tmpfs), le nouveau système de fichier est monté en lecture seule (--read-only) et la sortie de la commande est redirigé dans le /dev/null pour la supprimé

ID=$(docker container ls -laq)

#Récupère l'ID du dernier container créer

RUNNING=$(docker container inspect -f '{{.State.Status}}' $ID)

#Vérifie le statut du container idéntifié par le dernier ID obtenu et extrait le statut de la sortie de la commande en utilisant une chaine de format

if [[ $RUNNING == "running" ]]; then
    docker kill $ID > /dev/null
else
echo "Container cannot run in read-only mode!"
fi

#Vérifier si le container est en cours d'éxécution, s'il il est déjà en cours d'éxéciton, il arrête le container sinon un message d'érreur s'affiche

docker rmi $IMG > /dev/null
# Removing the Docker image built above.
# The output of this command is redirected to /dev/null to suppress it.

#Supprime l'image docker construite avant et redirige la sortie de la commande vers /dev/null afin de la supprimé
