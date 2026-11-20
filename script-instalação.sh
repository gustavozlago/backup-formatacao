#!/bin/bash

# Define cores para saída do terminal
VERDE='\033[0;32m'
AZUL='\033[0;34m'
SEM_COR='\033[0m'

echo -e "${VERDE}[INFO] - Iniciando atualização e configuração do sistema...${SEM_COR}"

# 1. Habilitando arquitetura 32-bit (necessário para dependências da Steam)
echo -e "${AZUL}[INFO] - Habilitando suporte à arquitetura 32-bit (i386)...${SEM_COR}"
sudo dpkg --add-architecture i386

# 2. Desinstalando programas indesejados
echo -e "${AZUL}[INFO] - Removendo programas desnecessários...${SEM_COR}"
sudo apt purge -y \
  rhythmbox* \
  xed \
  gucharmap \
  sticky \
  yelp \
  kdeconnect \
  onboard \
  redshift-gtk \
  drawing \
  pix \
  thingy \
  xviewer \
  info \
  celluloid \
  hypnotix \
  hexchat \
  thunderbird \
  seahorse

# 3. Instalando dependências necessárias e atualizando pacotes
echo -e "${AZUL}[INFO] - Instalando dependências essenciais...${SEM_COR}"
sudo apt update
sudo apt install -y wget curl ca-certificates gpg

# 4. Instalando aplicativos adicionais via Repositório APT
echo -e "${AZUL}[INFO] - Instalando aplicativos do repositório...${SEM_COR}"
sudo apt install -y \
  vlc \
  clementine \
  soundconverter \
  brasero \
  numlockx \
  cdrdao \
  spotify-client \
  audacity \
  dconf-editor \
  kdenlive \
  gparted \
  obs-studio \
  plank \
  piper \
  usb-creator-gtk \
  shotwell \
  gedit \
  gimp \
  ubuntu-restricted-extras \
  ttf-mscorefonts-installer \
  cmatrix \
  speedtest-cli \
  neofetch \
  mgba-common \
  mgba-qt \
  mgba-sdl \
  pcsxr \
  scrcpy \
  lm-sensors \
  openjdk-21-jdk \
  devede
  
  # 5.  comando sensores de temperatura automático
  
  sudo sensors-detect --auto

# 6. Baixando e Instalando pacotes .deb externos (Chrome, Edge, Steam, Minecraft, Discord e Spotify)

echo -e "${AZUL}[INFO] - Baixando e instalando o Google Chrome (.deb)...${SEM_COR}"
wget -O /tmp/google-chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
sudo apt install -y /tmp/google-chrome.deb
rm /tmp/google-chrome.deb

echo -e "${AZUL}[INFO] - Configurando repositório e instalando o Microsoft Edge...${SEM_COR}"
sudo apt update && sudo apt install -y curl gpg
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-edge.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge.list > /dev/null
sudo apt update && sudo apt install -y microsoft-edge-stable

echo -e "${AZUL}[INFO] - Baixando e instalando a Steam (.deb)...${SEM_COR}"
wget -O /tmp/steam.deb "https://cdn.akamai.steamstatic.com/client/installer/steam.deb"
sudo apt install -y /tmp/steam.deb
rm /tmp/steam.deb

echo -e "${AZUL}[INFO] - Baixando e instalando o Minecraft Launcher oficial (.deb)...${SEM_COR}"
wget -O /tmp/Minecraft.deb "https://launcher.mojang.com/download/Minecraft.deb"
sudo apt install -y /tmp/Minecraft.deb
rm /tmp/Minecraft.deb

echo -e "${AZUL}[INFO] - Baixando e instalando o Discord oficial (.deb)...${SEM_COR}"
wget -O /tmp/Discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo apt install -y /tmp/Discord.deb
rm /tmp/Discord.deb

echo -e "${AZUL}[INFO] - Baixando e instalando o Spotify (.deb)...${SEM_COR}"
wget -O /tmp/spotify.deb "http://repository.spotify.com/pool/non-free/s/spotify-client/spotify-client_1.2.56.502.ga68d2d4f_amd64.deb"
sudo apt install -y /tmp/spotify.deb
rm /tmp/spotify.deb

#7. Instalação Flatpaks

echo -e "${AZUL}[INFO] - Configurando Flatpak e instalando aplicativos...${SEM_COR}"

# 1. Instala o suporte a Flatpak no Debian (e o plugin para a loja, se desejar)
sudo apt update && sudo apt install -y flatpak

# 2. Adiciona o repositório oficial do Flathub
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# 3. Lista de aplicativos Flatpak (adicione ou comente com # os IDs desejados)
FLATPAKS=(
    "org.jdownloader.JDownloader"
    "org.soundconverter.SoundConverter"
    
)

# 4. Instala cada aplicativo da lista automaticamente
for app in "${FLATPAKS[@]}"; do
    echo -e "${AZUL}[INFO] - Instalando Flatpak: $app...${SEM_COR}"
    sudo flatpak install -y flathub "$app"
done

# 8. Atualização completa, limpeza final e correção de dependências
echo -e "${AZUL}[INFO] - Executando atualização de pacotes e limpeza final do sistema...${SEM_COR}"
sudo apt update
sudo apt dist-upgrade -y
sudo apt install -f -y
sudo apt autoremove --purge -y
sudo apt autoclean -y

# 9. Finalização
echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída com sucesso! :)${SEM_COR}"
