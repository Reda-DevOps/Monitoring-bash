# Monitoring Système Bash

Script Bash pour surveiller en temps réel les ressources
d'une machine Linux et générer des alertes si un seuil est dépassé.

## Fonctionnalités
- Surveillance du CPU, RAM et espace disque
- Seuils d'alerte configurables (par défaut : 80%)
- Affichage clair dans le terminal avec indicateurs OK / ALERTE
- Enregistrement automatique dans un fichier de log `monitoring.log`

## Utilisation

# Rendre le script exécutable
chmod +x monitoring.sh

# Lancer le monitoring
./monitoring.sh

## Personnalisation
Les seuils d'alerte sont modifiables en haut du script :
SEUIL_CPU=80
SEUIL_RAM=80
SEUIL_DISQUE=80

## Exemple de sortie
================================================
       MONITORING SYSTÈME
       2025-06-10 14:32:01
================================================

  Machine   : mon-serveur
  Adresse IP: 192.168.1.42

================================================
  RESSOURCES
================================================
  [✅ OK]     CPU   : 23%
  [⚠️  ALERTE] RAM   : 85% — seuil de 80% dépassé !
  [✅ OK]     Disque : 54%

## Contexte
Projet réalisé dans le cadre de mon apprentissage DevOps.
Ce type de script est utilisé en production pour surveiller
la santé des serveurs et anticiper les incidents.

## Technologies
- Bash
- Commandes Linux natives : top, free, df, awk, date
