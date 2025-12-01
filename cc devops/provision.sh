#!/usr/bin/env bash

# Mettre à jour le système
sudo apt-get update -y
sudo apt-get upgrade -y

# Installer Java (requis pour Jenkins)
sudo apt-get install -y openjdk-17-jdk

# Installer Apache
sudo apt-get install -y apache2

# Démarrer et activer Apache
sudo systemctl start apache2
sudo systemctl enable apache2

# Installer les dépendances pour Jenkins
sudo apt-get install -y curl gnupg

# Ajouter le repository Jenkins
sudo mkdir -p /usr/share/keyrings
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Mettre à jour et installer Jenkins
sudo apt-get update -y
sudo apt-get install -y jenkins

# Démarrer et activer Jenkins
sudo systemctl enable jenkins
sudo systemctl restart jenkins

# Ajouter l'utilisateur Jenkins au groupe sudo pour les permissions
sudo usermod -aG sudo jenkins

# Donner les permissions à Jenkins sur le répertoire web
sudo chown -R jenkins:jenkins /var/www/html/
sudo chmod -R 755 /var/www/html/

# Afficher le statut des services
echo "=== Statut d'Apache ==="
sudo systemctl status apache2 --no-pager

echo "=== Statut de Jenkins ==="
sudo systemctl status jenkins --no-pager

echo "=== Installation terminée ==="
echo "Jenkins est accessible sur: http://192.168.33.10:8080"
echo "Le site web sera accessible sur: http://192.168.33.10"