#!/bin/bash
# Ce fichier vérifie si le conteneur est bien en lecture seule et que l'utilisateur n'est pas root 

set -euo pipefail
# Le 'set' commande configure les options du shell.
# '-e' fait que le shell se termine si une commande échoue.
# '-u' traite les variables non définies comme des erreurs.
# '-o pipefail' fait que le code de sortie d'un pipeline est celui de la dernière commande échouée.

IMG=$(echo img$$) # Crée une image unique à partir de l'identifiant du processus du shell 

docker image build --tag $IMG ./src # --load  # Crée et identifie une image Docker 
# Construit une image Docker à partir du Dockerfile situé dans le répertoire ./src.
# L'image construite est taguée avec le nom unique généré ci-dessus.
# L'option '--load' charge l'image construite dans le démon Docker uniquement si vous utilisez docker buildx.

USR=$(docker container run --rm --entrypoint=whoami $IMG) # Insère dans la variable USR la valeur de l'utilisateur contenu dans l'image
# Exécute un conteneur Docker à partir de l'image construite ci-dessus.
# Le conteneur est supprimé après son exécution (option --rm).
# Le point d'entrée du conteneur est remplacé par la commande 'whoami'.
# La sortie de 'whoami' (qui est le nom d'utilisateur) est stockée dans la variable USR.

if [[ $USR == "root" ]]; then  # Si l'utilisateur contenu dans l'image est root, affiche un message d'erreur
    echo "User cannot be root!"
fi
# Vérifie si l'utilisateur à l'intérieur du conteneur est root.
# Si c'est le cas, un message d'erreur est affiché.

docker container run --rm --detach --tmpfs /tmp --read-only $IMG > /dev/null
# Exécute un conteneur Docker en mode détaché à partir de l'image construite ci-dessus.
# Le conteneur est supprimé après son exécution (option --rm).
# Un système de fichiers temporaire est monté sur /tmp à l'intérieur du conteneur (option --tmpfs).
# Le système de fichiers du conteneur est monté en lecture seule (option --read-only).
# La sortie de cette commande est redirigée vers /dev/null pour la supprimer.

ID=$(docker container ls -laq)
# Obtient l'ID du dernier conteneur créé.

RUNNING=$(docker container inspect -f '{{.State.Status}}' $ID)
# Vérifie l'état du conteneur avec l'ID obtenu ci-dessus.
# L'état est extrait de la sortie de la commande 'docker container inspect' en utilisant une chaîne de formatage.

if [[ $RUNNING == "running" ]]; then
    docker kill $ID > /dev/null
else
    echo "Container cannot run in read-only mode!"
fi
# Vérifie si le conteneur est en cours d'exécution.
# Si c'est le cas, le conteneur est tué.
# Sinon, un message d'erreur est affiché.

docker rmi $IMG > /dev/null
# Supprime l'image Docker construite ci-dessus.
# La sortie de cette commande est redirigée vers /dev/null pour la supprimer.
