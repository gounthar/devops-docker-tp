
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


## Modification du script `validator.sh`

geogeo@GeoGeo:/mnt/c/Users/geoff/Project/devops-docker-tp$ sudo ./validator.sh
[+] Building 0.1s (10/10) FINISHED                           docker:default
 => [internal] load build definition from Dockerfile                   0.0s
 => => transferring dockerfile: 1.05kB                                 0.0s 
 => [internal] load metadata for docker.io/donch/net-tools:latest      0.0s 
 => [internal] load .dockerignore                                      0.0s 
 => => transferring context: 2B                                        0.0s 
 => [1/5] FROM docker.io/donch/net-tools:latest                        0.0s 
 => [internal] load build context                                      0.0s 
 => => transferring context: 30B                                       0.0s 
 => CACHED [2/5] RUN adduser -h /home/www -D www                       0.0s 
 => CACHED [3/5] WORKDIR /home/www                                     0.0s 
 => CACHED [4/5] COPY start.sh /bin/start.sh                           0.0s 
 => CACHED [5/5] RUN chmod +x /bin/start.sh                            0.0s 
 => exporting to image                                                 0.0s 
 => => exporting layers                                                0.0s 
 => => writing image sha256:36a4b82a07496cd4a756dd6b9b60cf916ace935f6  0.0s 
 => => naming to docker.io/library/img42774                            0.0s 
geogeo@GeoGeo:/mnt/c/Users/geoff/Project/devops-docker-tp$ 
