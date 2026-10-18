#!/bin/bash

# Farben für Ausgaben
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

DOTFILES_DIR="$HOME/.dotfiles"
cd "$DOTFILES_DIR" || exit

echo -e "${BLUE}=== 0. Pacman & Multilib für frisches System optimieren ===${NC}"

# 1. Pacman-Visuals (Color & ParallelDownloads) aktivieren
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
sudo sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

# 2. Multilib Repository aktivieren (falls auskommentiert)
if grep -q "^\#[[:space:]]*\[multilib\]" /etc/pacman.conf; then
  echo -e "${GREEN}Aktiviere [multilib]-Repository...${NC}"
  # Entkommentiert [multilib] und die darunterliegende Include-Zeile
  sudo sed -i '/^#\[multilib\]/{N;s/#//g}' /etc/pacman.conf
elif ! grep -q "\[multilib\]" /etc/pacman.conf; then
  echo -e "${GREEN}Füge [multilib]-Repository hinzu...${NC}"
  echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf >/dev/null
else
  echo -e "${GREEN}[multilib] ist bereits aktiv.${NC}"
fi

# Pacman-Datenbanken aktualisieren (inkl. neuem Multilib)
sudo pacman -Sy

echo -e "\n${BLUE}=== 1. Offizielle Pakete installieren ===${NC}"
if [ -f "pkglist-repo.txt" ]; then
  sudo pacman -S --needed --noconfirm - <pkglist-repo.txt
else
  echo -e "${RED}Keine pkglist-repo.txt gefunden!${NC}"
fi

echo -e "\n${BLUE}=== 2. AUR-Helper (yay) installieren (falls nötig) ===${NC}"
if ! command -v yay &>/dev/null; then
  echo -e "${GREEN}yay nicht gefunden. Installiere Abhängigkeiten und baue yay...${NC}"
  sudo pacman -S --needed --noconfirm base-devel git

  TEMP_DIR=$(mktemp -d)
  git clone https://aur.archlinux.org/yay-bin.git "$TEMP_DIR/yay-bin"
  cd "$TEMP_DIR/yay-bin" || exit
  makepkg -si --noconfirm
  cd "$DOTFILES_DIR" || exit
  rm -rf "$TEMP_DIR"
else
  echo -e "${GREEN}yay ist bereits installiert.${NC}"
fi

echo -e "\n${BLUE}=== 3. AUR-Pakete installieren ===${NC}"
if [ -f "pkglist-aur.txt" ]; then
  yay -S --needed --noconfirm - <pkglist-aur.txt
else
  echo -e "${RED}Keine pkglist-aur.txt gefunden, überspringe AUR.${NC}"
fi

echo -e "\n${BLUE}=== 4. Erstelle Symlinks mit GNU Stow ===${NC}"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/Documents"

modules=("Documents" "powerlevel10k")

for module in "${modules[@]}"; do
  if [ -d "$module" ]; then
    echo -e "Stow verknüpft Modul: ${GREEN}$module${NC}"
    stow --restow "$module"
  else
    echo -e "${RED}Modul $module nicht gefunden, überspringe...${NC}"
  fi
done

echo -e "\n${BLUE}=== Installation komplett abgeschlossen! ===${NC}"
