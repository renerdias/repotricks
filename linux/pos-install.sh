#!/usr/bin/env bash
# ----------------------------- VARIÁVEIS ----------------------------- #



#URL_SIMPLE_NOTE="https://github.com/Automattic/simplenote-electron/releases/download/v1.8.0/Simplenote-linux-1.8.0-amd64.deb"
#URL_4K_VIDEO_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloader_4.9.2-1_amd64.deb"
#URL_4K_VIDEO_TO_MP3="https://dl.4kdownload.com/app/4kvideodownloader_4.9.2-1_amd64.deb"



# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando/Confirmando arquitetura de 32 bits ##
#sudo dpkg --add-architecture i386

## Atualizando o repositório ##
sudo apt update -y



# ----------------------------- ADD REPOSITORY ----------------------------- #
PPA_DBEAVER_CE="ppa:serge-rider/dbeaver-ce"
PPA_OBS_STUDIO="ppa:obsproject/obs-studio"
#PPA_SIMPLE_SCAN="ppa:robert-ancell/simple-scan"
#PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"

## Adicionando repositórios de terceiros e suporte a Snap (Driver Logitech, Lutris e Drivers Nvidia)##
sudo apt-add-repository "$PPA_DBEAVER_CE" -y
sudo apt-add-repository "$PPA_OBS_STUDIO" -y
#sudo apt-add-repository "$PPA_SIMPLE_SCAN" -y
#sudo apt-add-repository "$PPA_GRAPHICS_DRIVERS" -y

### PostgreSQL
# Create the file repository configuration:
sudo sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
# Import the repository signing key:
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
curl -sS https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/postgresql.gpg

### SPOTIFY
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

### GOOGLE CHROME
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'



# ---------------------------------------------------------------------- #

PROGRAMAS_PARA_INSTALAR=(
  # Linux Mint: Já vem instalado
  # simple-scan
  # firefox
  # libreoffice

  # Repositório padrão
  telegram-desktop
  inkscape
  git
  virtualbox
  virtualbox-guest-additions-iso
  pgmodeler
  grsync
  spotify-client
  flameshot

  # Instalado de repositório de terceiros adicionado
  dbeaver-ce
  postgresql
  obs-studio
  google-chrome-stable
)



# WebApps do Linux Mint(Para acessar sites como se fossem aplicativos)
#Olhar WebApps do big linux






# ----------------------------- DOWNLOAD/INSTALAÇÃO PROGRAMAS EXTERNO ----------------------------- #
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

## Download e instalaçao de programas externos ##
#mkdir "$DIRETORIO_DOWNLOADS"
#PROTON_VPN
  #lazarus
#mega
#wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
#wget -c "$URL_SIMPLE_NOTE"         -P "$DIRETORIO_DOWNLOADS"
#wget -c "$URL_4K_VIDEO_DOWNLOADER" -P "$DIRETORIO_DOWNLOADS"
#wget -c "$URL_INSYNC"              -P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
#sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb
# ---------------------------------------------------------------------- #




# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt update -y

# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

## Instalando pacotes Flatpak ##
flatpak install flathub com.wps.Office -y
flatpak install flathub com.getpostman.Postman -y
flatpak install flathub io.github.shiftey.Desktop

# ---------------------------------------------------------------------- #

# ----------------------------- PÓS-INSTALAÇÃO ------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #
