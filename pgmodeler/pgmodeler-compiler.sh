##########################################################
##   Atualiza a lista de pacotes e atualiza o sistema   ##
sudo apt update && sudo apt upgrade -y



###########################################################
##   Instala o PostgreSQL e outros pacotes necessários   ##

# Instala a última versão de PostgreSQL
sudo apt install postgresql postgresql-common postgresql-contrib -y

# Instala bibliotecas de compilação e ferramentas necessárias
sudo apt install build-essential libxml2-dev perl libx11-xcb-dev \
 ^libxcb.*-dev libfontconfig1-dev libfreetype6-dev libx11-dev \
 libx11-xcb-dev libxext-dev libxfixes-dev libxi-dev libxrender-dev \
 libxcb1-dev libxcb-glx0-dev libxcb-keysyms1-dev libxcb-image0-dev \
 libxcb-shm0-dev libxcb-icccm4-dev libxcb-sync0-dev libxcb-xfixes0-dev \
 libxcb-shape0-dev libxcb-randr0-dev libxcb-render-util0-dev \
 libxkbcommon-dev libxkbcommon-x11-dev libxcb-xinerama0-dev \
 libxcb-sync-dev libcups2-dev libpq-dev git g++ cmake \
 freeglut3-dev binutils libglew-dev mesa-common-dev libglew-dev \
 libglm-dev qt6-base-dev qt6-tools-dev-tools \
 qt6-tools-dev \
 # Acrescentando por Rener
 libpq-dev libqt6svg* -y
 # Removido por Rener
 # freeglut3 libqt6svg6*




#######################################################
##  Obtendo a identificação da última versão/release  ##
PGMODELER_GIT_VERSION=$(curl --silent -qI https://github.com/pgmodeler/pgmodeler/releases/latest | awk -F '/' '/^location/ {print  substr($NF, 1, length($NF)-1)}');

#criar estrutura de pastas
#~/pgmodeler/$PGMODELER_GIT_VERSION/sourcecode
#~/pgmodeler/$PGMODELER_GIT_VERSION/bin
#~/pgmodeler/$PGMODELER_GIT_VERSION/deb




####################################
##   Configura o ambiente local   ##

export QT_VERSION=6.2.4 # Aparentemente não usado
export QT_ARCH=gcc_64 # Aparentemente não usado
export QT_ROOT=/usr/lib/qt6
export QT_LIB=/usr/lib/x86_64-linux-gnu
export QT_LIB_PLUGINS=$QT_LIB/qt6/plugins
# Remove o 'v' do nome extraido do git
export PGMODELER_VERSION=${PGMODELER_GIT_VERSION:1}
export PGMODELER_ROOTDIR=~/pgmodeler
export PGMODELER_VERSION_DIR=$PGMODELER_ROOTDIR/$PGMODELER_GIT_VERSION
export PGMODELER_SOURCECODE_DIR=$PGMODELER_VERSION_DIR/sourcecode
export PGMODELER_COMPILED_DIR=$PGMODELER_VERSION_DIR/bin
export PGMODELER_DEB_DIR=$PGMODELER_VERSION_DIR/deb
export PGMODELER_DESKTOP_SHORTCUT_FILE=$PGMODELER_COMPILED_DIR/pgModeler-$(echo $PGMODELER_VERSION).desktop

# Remove o diretório da versão atual, caso exista
rm -rf $PGMODELER_VERSION_DIR

mkdir -p $PGMODELER_COMPILED_DIR/lib/qtplugins/imageformats
mkdir -p $PGMODELER_COMPILED_DIR/lib/qtplugins/printsupport
mkdir -p $PGMODELER_COMPILED_DIR/lib/qtplugins/platforms
mkdir -p $PGMODELER_COMPILED_DIR/lib/qtplugins/tls



#######################################################
##  Obtendo o código fonte da última versão/release  ##

# 1ª Forma:
#wget https://github.com/pgmodeler/pgmodeler/archive/refs/tags/$PGMODELER_GIT_VERSION.tar.gz
#wget https://github.com/pgmodeler/pgmodeler/archive/refs/tags/$PGMODELER_GIT_VERSION.zip

# 2ª Forma:
#git clone --branch $PGMODELER_GIT_VERSION --single-branch https://github.com/pgmodeler/pgmodeler.git

# Get the pgModeler repo
cd $PGMODELER_ROOTDIR
git clone --branch $PGMODELER_GIT_VERSION --single-branch https://github.com/pgmodeler/pgmodeler.git
mv -T $PGMODELER_ROOTDIR/pgmodeler $PGMODELER_SOURCECODE_DIR
#cd $PGMODELER_SOURCECODE_DIR
#git pull
#git checkout $PGMODELER_VERSION




#######################
## Compile pgModeler ##

# Configure the pgModeler build
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig/
cd $PGMODELER_SOURCECODE_DIR
$QT_ROOT/bin/qmake -r CONFIG+=release \
 PREFIX=$PGMODELER_COMPILED_DIR \
 BINDIR=$PGMODELER_COMPILED_DIR \
 PRIVATEBINDIR=$PGMODELER_COMPILED_DIR \
 PRIVATELIBDIR=$PGMODELER_COMPILED_DIR/lib \
 pgmodeler.pro


# Build pgModeler
cd $PGMODELER_SOURCECODE_DIR
make -j$(nproc) && make install


# Resolve pgModeler dependencies
cd $QT_LIB
cp libQt6DBus.so.6 libQt6PrintSupport.so.6 libQt6Widgets.so.6 \
 libQt6Network.so.6 libQt6Gui.so.6 libQt6Core.so.6 libQt6XcbQpa.so.6 \
 libQt6Svg.so.6 libQt6OpenGL.so.6 libicui18n.so.* libicuuc.so.* \
 libicudata.so.* $PGMODELER_COMPILED_DIR/lib
cd $QT_LIB_PLUGINS
cp -r imageformats/libqgif.so imageformats/libqico.so imageformats/libqjpeg.so imageformats/libqsvg.so $PGMODELER_COMPILED_DIR/lib/qtplugins/imageformats
cp -r printsupport/libcupsprintersupport.so $PGMODELER_COMPILED_DIR/lib/qtplugins/printsupport
cp -r platforms/libqxcb.so platforms/libqoffscreen.so $PGMODELER_COMPILED_DIR/lib/qtplugins/platforms
cp -r tls/* $PGMODELER_COMPILED_DIR/lib/qtplugins/tls
echo -e "[Paths]\nPrefix=.\nPlugins=lib/qtplugins\nLibraries=lib" > $PGMODELER_COMPILED_DIR/qt.conf




#######################
##   Run pgModeler   ##

# Only if needed - (re)create pgModeler runtime config files
rm -rf ~/.config/pgmodeler-1.0
cd $PGMODELER_COMPILED_DIR && ./pgmodeler-cli -cc -mo

# Run pgModeler from the terminal
cd $PGMODELER_COMPILED_DIR && export LD_LIBRARY_PATH=$(pwd)/lib && ./pgmodeler &




##################################
##   Create Desktop shortcut    ##

echo [Desktop Entry] > $PGMODELER_DESKTOP_SHORTCUT_FILE
echo Comment=Starts pgModeler $(echo $PGMODELER_VERSION) >> $PGMODELER_DESKTOP_SHORTCUT_FILE
echo 'Exec=sh -c "cd '$(echo $PGMODELER_COMPILED_DIR)' && export LD_LIBRARY_PATH=$(pwd)/lib && ./pgmodeler"' >> $PGMODELER_DESKTOP_SHORTCUT_FILE
echo GenericName=pgModeler $(echo $PGMODELER_VERSION) >> $PGMODELER_DESKTOP_SHORTCUT_FILE
echo Icon=$(echo $PGMODELER_COMPILED_DIR)/share/pgmodeler/conf/pgmodeler_logo.png >> $PGMODELER_DESKTOP_SHORTCUT_FILE
echo "Categories=Development;" >> $PGMODELER_DESKTOP_SHORTCUT_FILE
echo Name=pgModeler $(echo $PGMODELER_VERSION) >> $PGMODELER_DESKTOP_SHORTCUT_FILE
echo Type=Application >> $PGMODELER_DESKTOP_SHORTCUT_FILE
echo Terminal=false >> $PGMODELER_DESKTOP_SHORTCUT_FILE

# Define um atributo de arquivo para o arquivo
gio set $PGMODELER_DESKTOP_SHORTCUT_FILE metadata::trusted true

# Dá ao arquivo, permissão de execução
chmod +x $PGMODELER_DESKTOP_SHORTCUT_FILE

# Observação:
#   Now double-click the pgModeler shortcut on the Desktop to launch pgModeler
#   If double-clicking does not work:
#     Right-click on the pgModeler desktop icon and select 'Allow Launching'
#     Then double-click on the pgModeler shortcut on the desktop again







# Add to Applications
#cp $PGMODELER_DESKTOP_SHORTCUT_FILE ~/.local/share/applications




#################################
##  Create DEB Package         ##

#PACKAGE_NAME=
PACKAGE_NAME='pgModeler'
PACKAGE_DESCRIPTION='sdafa'
PACKAGE_VERSION=$PGMODELER_GIT_VERSION
PACKAGE_AUTHOR='Raphael Araújo'
PACKAGE_MANTAINER='Rener Dias <renerdias@live.com>'

# Calcula o tamanho do diretório do programa em Kb
DELIMIT=$(echo "$PGMODELER_COMPILED_DIR" | cut --bytes=1-1)
PACKAGE_SIZE=$(du "$PGMODELER_COMPILED_DIR" | tail -1 | cut -d"$DELIMIT" -f 1)

mkdir -p "$PGMODELER_DEB_DIR"
cd "$PGMODELER_DEB_DIR"
mkdir -p "$PGMODELER_DEB_DIR"/DEBIAN
   
func_Especifica_Control() {
   # Criando o arquivo control
   touch DEBIAN/control

   # Coleta parametros para o arquivo control
   echo "Package:        $PACKAGE_NAME" > DEBIAN/control
   echo "Name:           $PACKAGE_NAME" > DEBIAN/control
   echo "Description:    $PACKAGE_DESCRIPTION" >> DEBIAN/control
   echo "Version:        $PACKAGE_VERSION" >> DEBIAN/control
   echo "Installed-Size: $PACKAGE_SIZE" >> DEBIAN/control
   echo "Author:         $PACKAGE_AUTHOR" >> DEBIAN/control
   echo "Maintainer:     $PACKAGE_MANTAINER" >> DEBIAN/control
   echo "Priority:       optional" >> DEBIAN/control
   echo "Architecture:   all" >> DEBIAN/control
}

#func_Especifica_Control

func_Especifica_PostInstall() {
   # Criando o arquivo control
   touch DEBIAN/control
   
echo '#O script postinst é executado após a instalação do pacote. Ele pode ser usado para configurar o sistema ou fazer ajustes necessários. Aqui está um exemplo simples de um script postinst:'

echo '#!/bin/bash'

echo 'echo "Instalação do pacote concluída com sucesso!"'

echo '# Adicione outros comandos de configuração, se necessário.'
}
