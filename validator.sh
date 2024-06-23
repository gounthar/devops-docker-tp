#!/bin/bash
# This is a bash script for validating Docker images and containers.

set -euo pipefail
# The 'set' command is used to change the values of shell options and set the positional parameters.
# '-e' option will cause the shell to exit if any invoked command fails.
# '-u' option treats unset variables and parameters as an error.
# '-o pipefail' option sets the exit code of a pipeline to that of the rightmost command to exit with a non-zero status.

#créé une variable avec le numéro du processus actuel
IMG=$(echo img$$)

#créé une image depuis le dossier src, l'image est affublée du tag généré sur la ligne juste au-dessus.
docker image build --tag $IMG ./src --load

# créé un container temporaire avec le --rm qui supprimera le container après son execution.
# le container est créé avec l'image créé plus haut. 
# whoami (qui affiche le nom d'utilisateur) sera stocké dans la variable USR.
USR=$(docker container run --rm --entrypoint=whoami $IMG )


# vérifie que le user dans le container est bien le root et si non affiche le message "User cannot be root!".
if [[ $USR == "root" ]]; then
echo "User cannot be root!"
fi

# créé un container temporaire avec le --rm qui supprimera le container après son execution (encore).
# le container utilise la même image qu'avant.
# ce qui resulte de cette commande est ensuite renvoyé vers /dev/null pour la suppression.
docker container run --rm --detach --tmpfs /tmp --read-only $IMG > /dev/null

# id du dernier container
ID=$(docker container ls -laq)

# docker container inspect permet de récupérer le statu de la machine et sera ainsi stocké dans la variable RUNNIG
RUNNING=$(docker container inspect -f '{{.State.Status}}' $ID)

# si le container est en mode running le shell le killera puis le redirigera dans /dev/null comme précédemment fait pour la suppression.
# sinon le shell affiche le message "Container cannot run in read-only mode!".
if [[ $RUNNING == "running" ]]; then
    docker kill $ID > /dev/null
else
echo "Container cannot run in read-only mode!"
fi

# suppression de l'image créé précédemment.
docker rmi $IMG > /dev/null
