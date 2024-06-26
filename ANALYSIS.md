La première commande de validator.sh est set -euo pipefail : Cette commande permet d'arrêter immédiatement le script dès qu'une commande échoue ou un paramètre est mal défini, évitant alors l'injection de code corrompu par de potentielles erreurs.

La deuxième commande monte une image Docker ubuntu depuis le Dockerfile existant dans /src avec le process ID comme tag d'image.

La troisième démarre le docker avec comme première commande exécutée dans la machine "whoami", ce qui nous permet de récupérer l'utilisateur.

On vérifie ensuite si l'utilisateur est root et si c'est le cas, le script s'arrête en informant que l'utilisateur ne peut être root.

Ensuite, l'identifiant du dernier container docker créé est récupéré dans l'objectif de tuer le container une fois terminé.

On récupère alors l'état de la machine docker et si elle ne tourne pas, on envoie une erreur. Si elle est bien en cours d'exécution, on tue le container avec l'ID récupéré précédemment.

On termine par supprimer l'image docker.

Tout ce qui est redirigé vers /dev/null est considéré comme "null", supprimé.