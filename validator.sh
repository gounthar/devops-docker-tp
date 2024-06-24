#!/bin/bash
# This is a bash script for validating Docker images and containers.

set -euo pipefail
# The 'set' command is used to change the values of shell options and set the positional parameters.
# '-e' option will cause the shell to exit if any invoked command fails.
# '-u' option treats unset variables and parameters as an error.
# '-o pipefail' option sets the exit code of a pipeline to that of the rightmost command to exit with a non-zero status.


#----------------------------
# CRÉATION DE L'IMAGE
#----------------------------

# Crée un numéro unique à partir du processus en train de tourner
IMG=$(echo img$$)

# Crée une image docker à partir du dockerfile src, puis associe à celle-ci le numéro généré au-dessus
docker image build --tag $IMG ./src --load


#----------------------------
# CRÉATION DU CONTAINER
#----------------------------

# Créé un container depuis l'image docker générée,
USR=$(docker container run --rm --entrypoint=whoami $IMG )


#----------------------------
# VÉRIFICATIONS
#----------------------------

# Vérifie que l'utilisateur à l'intérieur du conteneur n'est pas root
# Si l'utilisateur n'est pas root, le script continue, sinon le message "User cannot be root!" s'affiche
if [[ $USR == "root" ]]; then
echo "User cannot be root!"
fi


#---------------------------------------------
# CRÉATION D'UN CONTAINER EN LECTURE SEULE
#---------------------------------------------

# Exécute un container avec un système de fichiers temporaire, en lecture seule et avec une image identique au précédent, puis le supprime
docker container run --rm --detach --tmpfs /tmp --read-only $IMG > /dev/null

ID=$(docker container ls -laq)

# Stocke dans la variable RUNNING le statut de la machine pour les vérifications qui suivront
RUNNING=$(docker container inspect -f '{{.State.Status}}' $ID)


#----------------------------
# VÉRIFICATIONS
#----------------------------

# Vérifie si le container fonctionne correctement en lecture seule
# S'il est en marche, il est supprimé, sinon le message "Container cannot run in read-only mode!" s'affiche
if [[ $RUNNING == "running" ]]; then
    docker kill $ID > /dev/null
else
echo "Container cannot run in read-only mode!"
fi


#----------------------------
# SUPPRESSION DE L'IMAGE
#----------------------------

# L'image créée au début est supprimée après les vérifications
docker rmi $IMG > /dev/null


#----------------------------
# RÉSUMÉ
#----------------------------

# D'après moi, ce script permet d'automatiser la vérification d'une image docker en s'assurant qu'elle fonctionne, puis en vérifiant qu'il n'y a pas de souci de sécurité (notamment avec la vérification de l'utilisateur) en créant des containers temporaires.
