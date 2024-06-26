# DevOps - Docker - TP

## Introduction

Un industriel est actuellement en train de mettre en place une registry Docker et aimerait prendre toutes les précautions nécessaires pour sécuriser les containers qu'il compte héberger en production.

La première étape a été de définir les points de contrôle à vérifier pour chacune des images. Le contrôle des sources est implémenté dans `validator.sh`

## Ce que j'attends de vous

### Vue d'ensemble

Pour réaliser ce TP, vous devez:

- faire un fork de ce repository
- analyser les travaux de vérifications implémentés dans `validator.sh`
- exécuter `validator.sh` pour voir si les sources fournies sont compatibles avec les politiques de l'industriel *(vous vous doutez bien que non...)*
- corriger les sources (`Dockerfile` et `start.sh`) pour rendre l'image compatible
- me proposer une pull request sur ce repository avec vos modifications, et ce avant le 26/06/2024.
  - cette pull request doit contenir les modifications apportées à `Dockerfile` et `start.sh`
  - elle doit également m'expliquer en détail ce que fait `validator.sh`
  - ce que vous avez changé, et ce que vous avez ajouté, et pourquoi.

### Détails, si nécessaire

#### Préambule

Si vous butez en shell, n'hésitez pas à aller consulter mon court [guide de survie](https://gounthar.github.io/cours-devops-docker/main/#/ligne_de_commande) de la ligne de commande.
Le TP est basé sur deux scripts shell, l'un en bash, et l'autre en sh.
Si vous ne savez pas quelles sont les différences essentielles, je vous invite à consulter [cette page](https://www.delftstack.com/fr/howto/linux/sh-and-bash/).
Vous aurez besoin de git, je vous recommande donc de vous rafraichir la mémoire avec [ce guide](https://gounthar.github.io/cours-devops-docker/main/#/git).

#### Exécution des scripts

Les deux scripts shell, `validator.sh` et `start.sh` ne sont pas exécutables par défaut.
Pour les rendre exécutables, il faut utiliser la commande `chmod +x <nom_du_script>`.
Pour les exécuter, il suffit de taper `./<nom_du_script>`.
Qu'est-ce qu'un fichier exécutable, que sont les permissions sous Linux? Je vous invite à consulter [cet article](https://doc.ubuntu-fr.org/permissions).
Une autre solution serait de lancer le script avec la commande `bash <nom_du_script>` pour le script bash, et `sh <nom_du_script>` pour le script sh.
Notez cependant que `validator.sh` s'attend à ce que le script `start.sh` soit exécutable.
Notez que pour changer les permissions d'un fichier existant sous git, et lui permettre d'être exécuté, on peut utiliser la commande `git update-index` suivie de l'option `--chmod` option.
Voici comment faire:

```bash
git update-index --chmod=+x <chemin-du-fichier>
```

Il faut remplacer `<chemin-du-fichier>` par le chemin réel du fichier dont on veut modifier les permissions.
Par exemple, si le fichier s'appelle `validator.sh` et se trouve à la racine de votre repository, la commande serait:

```bash
git update-index --chmod=+x validator.sh
```

#### Mode verbeux

Dans la version actuelle de `validator.sh`, j'ai ajouté trois options au shell:
- 'e' permet de quitter le script si une erreur est rencontrée
- 'u' considère les variables sans valeur comme une erreur
- 'x' écrit chaque commande du script dans le terminal

Je pensais que ça vous aiderait à comprendre et tracer le fonctionnement du script, mais dans un premier temps, il semblerait que ce soit un obstacle à la compréhension.
Je vous suggère donc de ne pas utiliser l'option `-x` pour l'instant, ce qui nous donnerait la commande suivante:

```bash
set -eu
```

#### Mélange contre nature

J'ai modifié ces scripts sous Windows, dans WSL2, mais dans un répertoire partagé avec Windows.
Il est donc possible que les fins de ligne soient en CRLF, et non en LF.
Si vous avez des problèmes d'exécution, je vous invite à vérifier que les fins de ligne sont bien en LF, et à les convertir si nécessaire.
Je vous invite à consulter [cet article](https://www.cyberciti.biz/faq/howto-unix-linux-convert-dos-newlines-cr-lf-unix-text-format/) pour plus d'informations.
L'un des outils cités s'installe avec la commande `sudo apt install dos2unix`.

#### Erreurs rencontrées

Comme expliqué dans la vue d'ensemble, vous devriez rencontrer des erreurs lors de l'exécution de `validator.sh`.

```bash
User cannot be root!
Container cannot run in read-only mode!
```

Ces erreurs sont normales, et sont dûes au fait que les sources ne sont pas encore compatibles avec les politiques de l'industriel.
Vous devez donc corriger les sources pour rendre l'image compatible.

Pour la première erreur, il va falloir créer un nouvel utilisateur dans notre Dockerfile, et faire en sorte que le container s'exécute avec cet utilisateur.
Je vous invite à consulter [cette réponse StackOverflow](https://stackoverflow.com/a/27703359/2938320) pour plus d'informations, et à vous échauffer avec [cet exercice](https://redhatgov.io/workshops/security_containers/exercise1.2/).
Pour le nom de l'utilisateur à créer, je vous invite à consulter `start.sh` dans lequel j'ai laissé traîner un énorme indice.
Spoiler alert: après la seconde modification, on se moquera éperdument du nom de l'utilisateur, tant qu'on n'utilise pas root.

Pour la seconde erreur, elle signifie qu'un processus (`start.sh` en occurrence) tente d'écrire dans un répertoire qui est en lecture seule.
Il va donc falloir modifier le script `start.sh` pour qu'il ne tente pas de créer un fichier dans le répertoire `/home/www`.
Vous pouvez aller consulter ce [court article](https://projectatomic.io/blog/2015/12/making-docker-images-write-only-in-production/) pour trouver l'inspiration. Les modifications à apporter au script `start.sh` sont très simples, et ne nécessitent pas de connaissances particulières en shell.

‘unknown flag: --load‘: dans la première version du script ‘validator.sh‘, j'utilisais l'option `--load‘ dans la commande ‘docker build‘.
Cette commande ne fonctionne que si vous utilisez docker buildx, et pas docker build. Si vous avez ‘docker buildx‘, ‘docker build‘ est un synonyme pour ‘docker buildx build‘.
Si vous n'avez pas ‘docker buildx‘ d'installé, corrigez le script pour enlever l'option ‘--load‘, ou mettez à jour votre fork avec ‘git fetch --all‘ suivi de ‘git merge upstream/main‘.
https://github.com/docker/buildx

## Erreurs courantes

### Error response from daemon: Cannot kill container: 35c77f95620e: permission denied

Vous utilisez Ubuntu, et par défaut, [apparmor](https://guide.ubuntu-fr.org/14.04/server/apparmor.html) vient mettre son grain de sel dans votre expérience Docker.
Il est possible que cette erreur survienne lorsque vous essayez de supprimer un container.
Je vous invite à consulter [cette réponse](https://forums.docker.com/t/can-not-stop-docker-container-permission-denied-error/41142/7) pour plus d'informations.

### Permission denied

Il est possible que vous rencontriez cette erreur. Votre utilisateur est-il bien membres du groupe `docker`? Si ce n'est pas le cas, je vous invite à consulter [cette réponse](https://askubuntu.com/a/477554/1098270) pour plus d'informations.

### DEPRECATED: The legacy builder is deprecated

> DEPRECATED: The legacy builder is deprecated and will be removed in a future release.
Install the buildx component to build images with BuildKit:
https://docs.docker.com/go/buildx/

Si vous avez installé docker autrement qu'avec Docker Desktop, il est possible que vous rencontriez ce message.
En effet, docker buildx est installé par défaut avec Docker Desktop, mais pas avec les autres méthodes d'installation.
Je vous invite à consulter [ce guide d'installation](https://docs.docker.com/engine/install/ubuntu/) pour plus d'informations.
Il pourrait suffire d'installer le paquet `docker-buildx-plugin` pour résoudre le problème.

### D'autres problèmes?

Écrivez-moi (sous Discord ou par e-mail), nous tenterons de les résoudre ensemble, et je mettrai à jour cette section.

## Déjà fini?

Bravo! Et si on passait à l'étape suivante?
Je vous propose de jeter un oeil à [Docker Scout](https://docs.docker.com/scout/) pour tenter de repérer les vulnérabilités de votre image.

## Notation

1. Analyse des travaux de vérifications implémentés dans `validator.sh` avec explication dans le corps de la PR : 5 points.
2. Exécution de `validator.sh` sans erreur (et sans modification du fichier): 2 points.
3. Correction des sources (`Dockerfile` et `start.sh`) : 8 points.
4. Proposition d'une merge request sur le repository avec les modifications et les explications : 5 points.

Pour les points bonus :  
1. Respect des délais : jusqu'à 2 points bonus pour les travaux rendus avant la date du 26/06/2024.
2. Utilisation de Docker Scout pour repérer les vulnérabilités de l'image (avec les traces de l'exécution, les corrections éventuelles et les explications): jusqu'à 3 points bonus.

Ainsi, vous pourriez obtenir jusqu'à 25 points (cappés à 20) si vous réalisez toutes les tâches et respectez les délais.

## Liste de vos repositories

Entrez ici (par PR) vos prénom, nom, et le lien vers votre repository.

1. [Henri Aulait](https://github.com/user/repo) https://github.com/user/repo

Yann Bauduin : https://github.com/yann-bauduin/devops-docker-tp
