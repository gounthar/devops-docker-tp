# DevOps - Docker - TP

## validator.sh

```bash
#!/bin/bash
```
La première ligne `#!/bin/bash` indique que le script doit être exécuté avec l'interpréteur Bash.

```bash
set -euo pipefail
```
La commande `set -euo pipefail` configure le comportement du script :
- `-e` : Le script s'arrêtera immédiatement si une commande échoue.
- `-u` : Le script traitera l'utilisation de variables non définies comme une erreur et s'arrêtera.
- `-o pipefail` : Le statut de sortie d'une chaîne de commandes sera celui de la dernière commande ayant échoué (non zéro).

```bash
IMG=$(echo img$$)
```
`IMG=$(echo img$$)` crée un nom d'image unique en utilisant l'ID du processus actuel (`$$`). La commande `echo img$$` génère une chaîne de caractères composée de `img` suivi de l'ID du processus, et cette chaîne est assignée à la variable `IMG`.

```bash
docker image build --tag $IMG ./src # --load
```
Cette ligne construit une image Docker à partir du fichier Dockerfile situé dans le répertoire `./src`. L'image construite est étiquetée avec le nom unique généré précédemment (`$IMG`). Le commentaire `# --load` mentionne une option qui pourrait être utilisée pour charger l'image dans le démon Docker, mais cette option n'est pas activée dans la commande.

```bash
USR=$(docker container run --rm --entrypoint=whoami $IMG)
```
`USR=$(docker container run --rm --entrypoint=whoami $IMG)` exécute un conteneur Docker à partir de l'image construite précédemment. Le conteneur est supprimé après son exécution grâce à l'option `--rm`. L'entrée du conteneur (`entrypoint`) est remplacée par la commande `whoami`, qui renvoie le nom de l'utilisateur exécutant. Le résultat de cette commande est stocké dans la variable `USR`.

```bash
if [[ $USR == "root" ]]; then
  echo "User cannot be root!"
  exit 1
fi
```
Ce bloc vérifie si l'utilisateur à l'intérieur du conteneur est `root`. Si c'est le cas, un message d'erreur est imprimé et le script s'arrête avec un code de sortie `1` (`exit 1`).

```bash
docker container run --rm --detach --tmpfs /tmp --read-only $IMG > /dev/null
```
Cette commande exécute un conteneur Docker en mode détaché (`--detach`) à partir de l'image construite précédemment. Le conteneur est supprimé après son exécution grâce à l'option `--rm`. Un système de fichiers temporaire est monté sur `/tmp` à l'intérieur du conteneur (`--tmpfs /tmp`). Le système de fichiers du conteneur est monté en lecture seule (`--read-only`). La sortie de cette commande est redirigée vers `/dev/null` pour être supprimée.

```bash
ID=$(docker container ls -laq)
```
`ID=$(docker container ls -laq)` récupère l'ID du dernier conteneur créé en listant tous les conteneurs en mode silencieux (`-l`) et en affichant uniquement les IDs (`-q`).

```bash
RUNNING=$(docker container inspect -f '{{.State.Status}}' $ID)
```
`RUNNING=$(docker container inspect -f '{{.State.Status}}' $ID)` inspecte le conteneur avec l'ID récupéré précédemment et extrait son statut en utilisant une chaîne de format (`{{.State.Status}}`). Le statut du conteneur est stocké dans la variable `RUNNING`.

```bash
if [[ $RUNNING == "running" ]]; then
  docker kill $ID > /dev/null
else
  echo "Container cannot run in read-only mode!"
  exit 1
fi
```
Ce bloc vérifie si le conteneur est en cours d'exécution (`$RUNNING == "running"`). Si c'est le cas, le conteneur est tué (`docker kill $ID`) et la sortie est redirigée vers `/dev/null`. Si le conteneur n'est pas en cours d'exécution, un message d'erreur est imprimé et le script s'arrête avec un code de sortie `1` (`exit 1`).

```bash
docker rmi $IMG > /dev/null
```
Enfin, cette ligne supprime l'image Docker construite précédemment (`docker rmi $IMG`) et redirige la sortie vers `/dev/null` pour la supprimer.

### Récapitulatif
Ce script construit une image Docker, vérifie que l'utilisateur à l'intérieur du conteneur n'est pas `root`, exécute un conteneur en mode lecture seule et vérifie s'il peut s'exécuter correctement. Si le conteneur ne peut pas s'exécuter en mode lecture seule, il imprime un message d'erreur. Enfin, il nettoie en supprimant l'image Docker construite.