#!/bin/bash

# ================================================
#   MONITORING SYSTÈME - Script Bash
#   Surveille CPU, RAM et Disque
#   Génère une alerte si un seuil est dépassé
# ================================================

# --- Seuils d'alerte (en %) ---
SEUIL_CPU=80
SEUIL_RAM=80
SEUIL_DISQUE=80

# --- Fichier de log ---
LOG_FILE="monitoring.log"
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# ================================================
# FONCTIONS
# ================================================

afficher_separateur() {
    echo "================================================"
}

# --- CPU ---
get_cpu() {
    CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'.' -f1)
    echo "$CPU"
}

# --- RAM ---
get_ram() {
    RAM=$(free | grep Mem | awk '{printf("%.0f", $3/$2 * 100)}')
    echo "$RAM"
}

# --- Disque (partition principale) ---
get_disque() {
    DISQUE=$(df / | grep / | awk '{print $5}' | cut -d'%' -f1)
    echo "$DISQUE"
}

# --- Vérification et alerte ---
verifier_seuil() {
    local NOM=$1
    local VALEUR=$2
    local SEUIL=$3

    if [ "$VALEUR" -ge "$SEUIL" ]; then
        echo "  [⚠️  ALERTE] $NOM : ${VALEUR}% — seuil de ${SEUIL}% dépassé !"
        echo "[$DATE] ALERTE - $NOM : ${VALEUR}% (seuil : ${SEUIL}%)" >> "$LOG_FILE"
    else
        echo "  [✅ OK]     $NOM : ${VALEUR}%"
        echo "[$DATE] OK - $NOM : ${VALEUR}%" >> "$LOG_FILE"
    fi
}

# ================================================
# AFFICHAGE PRINCIPAL
# ================================================

clear
afficher_separateur
echo "       MONITORING SYSTÈME"
echo "       $DATE"
afficher_separateur

# Collecte
CPU_VAL=$(get_cpu)
RAM_VAL=$(get_ram)
DISQUE_VAL=$(get_disque)

# Hostname et IP
HOSTNAME=$(hostname)
IP=$(hostname -I | awk '{print $1}')

echo ""
echo "  Machine   : $HOSTNAME"
echo "  Adresse IP: $IP"
echo ""
afficher_separateur
echo "  RESSOURCES"
afficher_separateur

verifier_seuil "CPU  " "$CPU_VAL" "$SEUIL_CPU"
verifier_seuil "RAM  " "$RAM_VAL" "$SEUIL_RAM"
verifier_seuil "Disque" "$DISQUE_VAL" "$SEUIL_DISQUE"

echo ""
afficher_separateur
echo "  Log enregistré dans : $LOG_FILE"
afficher_separateur
echo ""
