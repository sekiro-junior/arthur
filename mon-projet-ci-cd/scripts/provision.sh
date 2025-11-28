#!/bin/bash

# Mise à jour du système
echo "Mise à jour du système..."
apt-get update
apt-get upgrade -y

# Installation des dépendances
echo "Installation des dépendances..."
apt-get install -y \
    openjdk-11-jdk \
    wget \
    curl \
    git \
    apache2 \
    python3 \
    python3-pip

# Configuration d'Apache
echo "Configuration d'Apache..."
systemctl enable apache2
systemctl start apache2

# Téléchargement et installation de Jenkins
echo "Installation de Jenkins..."
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -
sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update
apt-get install -y jenkins

# Démarrage de Jenkins
systemctl enable jenkins
systemctl start jenkins

# Configuration du firewall
echo "Configuration du firewall..."
ufw allow 8080
ufw allow 80
ufw allow 22
ufw --force enable

# Création du répertoire web
echo "Création du répertoire web..."
mkdir -p /var/www/html
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Attendre que Jenkins soit démarré
echo "En attente du démarrage de Jenkins..."
sleep 30

# Afficher le mot de passe admin initial
echo "=== MOT DE PASSE JENKINS ==="
echo "Le mot de passe Jenkins est :"
cat /var/lib/jenkins/secrets/initialAdminPassword
echo "============================"

echo "Provisionnement terminé!"
echo "Accédez à Jenkins sur: http://192.168.56.10:8080"
echo "Accédez au site web sur: http://192.168.56.10"