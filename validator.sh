#!/bin/bash
# Ce script en bash valide les images et les containers Docker.

set -euo pipefail
# Options du shell :
# - 'e' : quitte le shell si une commande échoue.
# - 'u' : traite les variables non définies comme des erreurs.
# - 'o pipefail' : retourne le code de sortie d'une pipeline comme celui de la dernière commande à avoir échoué.


# CRÉATION DE L'IMAGE :

# Crée un nom d'image unique en utilisant l'ID du processus en cours
IMG=$(echo img$$)

# Construit une image Docker à partir du Dockerfile dans le répertoire src, en lui associant le nom généré
docker image build --tag $IMG ./src --load


# CRÉATION DU CONTAINER :

# Exécute un container à partir de l'image Docker créée ci-dessus, en remplaçant l'entrée par la commande 'whoami'
USR=$(docker container run --rm --entrypoint=whoami $IMG )


# VÉRIFICATION DE L'UTILISATEUR :

# Vérifie que l'utilisateur dans le conteneur n'est pas 'root'
# Si c'est le cas, affiche un message d'erreur
if [[ $USR == "root" ]]; then
    echo "User cannot be root!"
fi


# CRÉATION D'UN CONTAINER EN MODE LECTURE SEULE :

# Exécute un container en mode détaché avec un système de fichiers temporaire en /tmp et en lecture seule, basé sur l'image précédente, puis le supprime
docker container run --rm --detach --tmpfs /tmp --read-only $IMG > /dev/null

# Obtient l'ID du dernier container créé
ID=$(docker container ls -laq)

# Vérifie l'état d'exécution du container avec l'ID obtenu ci-dessus
RUNNING=$(docker container inspect -f '{{.State.Status}}' $ID)


# VÉRIFICATION DE L'ÉTAT DU CONTAINER :

# Vérifie si le container fonctionne en mode lecture seule
# S'il est en cours d'exécution, il est tué, sinon affiche un message d'erreur
if [[ $RUNNING == "running" ]]; then
    docker kill $ID > /dev/null
else
    echo "Container cannot run in read-only mode!"
fi


# SUPPRESSION DE L'IMAGE :

# Supprime l'image Docker créée au début
docker rmi $IMG > /dev/null


# Conclusion :

# Ce script automatise la validation d'une image Docker en vérifiant plusieurs aspects cruciaux pour garantir la sécurité et le bon fonctionnement des containers :
# 1. Création de l'image : Il génère un nom unique pour l'image Docker et construit cette image à partir d'un Dockerfile situé dans le répertoire 'src'.
# 2. Création du container : Il exécute un container à partir de l'image créée pour vérifier l'utilisateur avec la commande 'whoami', garantissant que l'utilisateur n'est pas root.
# 3. Vérification de l'utilisateur : Si l'utilisateur est root, il affiche un message d'erreur et continue.
# 4. Création d'un container en mode lecture seule : Il lance un container en mode détaché avec un système de fichiers temporaire monté en lecture seule pour vérifier que le container peut fonctionner correctement dans ce mode.
# 5. Vérification de l'état du container : Il vérifie si le container fonctionne en mode lecture seule. Si le container fonctionne, il le tue. Sinon, il affiche un message d'erreur.
# 6. Suppression de l'image : Enfin, il supprime l'image Docker créée au début pour libérer des ressources.

# En résumé, ce script permet de s'assurer que les images Docker créées ne fonctionnent pas avec des privilèges root et qu'elles peuvent fonctionner en mode lecture seule. Cela contribue à renforcer la sécurité et à détecter d'éventuels problèmes de permissions dans les containers Docker.
