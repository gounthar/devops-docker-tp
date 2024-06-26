#!/bin/sh
set -eu

# Crée un répertoire temporaire pour stocker le fichier started.time
temp_dir=$(mktemp -d)

# Crée un fichier nommé started.time dans le répertoire temporaire
touch "$temp_dir/started.time"

# Écrit la date et l'heure actuelles dans le fichier started.time
date > "$temp_dir/started.time"

# Passe le contrôle à la commande suivante
exec "$@"
