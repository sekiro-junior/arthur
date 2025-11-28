#!/bin/bash

DEPLOY_DIR="/var/www/html"
BACKUP_DIR="/var/backups/website"

echo "Début du déploiement..."

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
mkdir -p $BACKUP_DIR
if [ -d "$DEPLOY_DIR" ]; then
    tar -czf "$BACKUP_DIR/backup_$TIMESTAMP.tar.gz" -C $DEPLOY_DIR .
    echo "Backup créé: $BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
fi

echo "Nettoyage du répertoire de déploiement..."
rm -rf $DEPLOY_DIR/*

echo "Copie des nouveaux fichiers..."
cp -r ./* $DEPLOY_DIR/

echo "Définition des permissions..."
chown -R www-data:www-data $DEPLOY_DIR
chmod -R 755 $DEPLOY_DIR

echo "Redémarrage d'Apache..."
systemctl restart apache2

echo "Déploiement terminé avec succès!"
echo "Site accessible sur: http://$(hostname -I | awk '{print $1}')"

echo "Test d'accessibilité du site..."
curl -f http://localhost/ && echo "✓ Site accessible avec succès!" || echo "✗ Erreur: Site non accessible"