#!/bin/bash
set -e

# ============================================
#   Livre d'Or - Script de démarrage
# ============================================

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}"
echo "  ██╗     ██╗██╗   ██╗██████╗ ███████╗    ██████╗  ██████╗ ██████╗ "
echo "  ██║     ██║██║   ██║██╔══██╗██╔════╝    ██╔══██╗██╔═══██╗██╔══██╗"
echo "  ██║     ██║██║   ██║██████╔╝█████╗      ██║  ██║██║   ██║██████╔╝"
echo "  ██║     ██║╚██╗ ██╔╝██╔══██╗██╔══╝      ██║  ██║██║   ██║██╔══██╗"
echo "  ███████╗██║ ╚████╔╝ ██║  ██║███████╗    ██████╔╝╚██████╔╝██║  ██║"
echo "  ╚══════╝╚═╝  ╚═══╝  ╚═╝  ╚═╝╚══════╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═╝"
echo -e "${NC}"

# Vérification du fichier secret
if [ ! -f "./secret/.env" ]; then
  echo -e "${RED}[ERREUR] Le fichier ./secret/.env est introuvable !${NC}"
  echo -e "${YELLOW}  → Copiez le fichier .env.example dans ./secret/.env et remplissez les valeurs.${NC}"
  exit 1
fi

echo -e "${YELLOW}[INFO]${NC} Chargement des variables depuis ./secret/.env..."
export $(grep -v '^#' ./secret/.env | xargs)

# Vérification de Docker
if ! command -v docker &> /dev/null; then
  echo -e "${RED}[ERREUR] Docker n'est pas installé ou non disponible.${NC}"
  exit 1
fi

# Pull des dernières images
echo -e "${YELLOW}[INFO]${NC} Récupération des images Docker Hub..."
docker pull jmlk/livre-d-or-frontend
docker pull jmlk/livre-d-or-backend

# Démarrage des services
echo -e "${YELLOW}[INFO]${NC} Démarrage des conteneurs..."
docker compose up -d --remove-orphans

echo ""
echo -e "${GREEN}[OK]${NC} Application démarrée avec succès !"
echo -e "     Frontend : ${GREEN}http://localhost:8080${NC}"
echo -e "     Backend  : ${GREEN}http://localhost:3000${NC}"
echo ""
