!/bin/bash

# -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
# 1. CRIAR SUPORTE A DICIONÁRIOS PARA FULLTEXTSEARCH NO SO, NECESSÁRIO APENAS 01 EXECUÇÃO
# ----------------------------------------------------------------------------------------------------------------------------------------
# 1.1 - DEFININDO E EXPORTANDO DIRETÓRIO FÍSICO DOS DICIONÁRIOS
#   - O caminho do diretório tsearch_data do Postgres varia de acordo com o sistema operacional.
#   - No Ubuntu 21.04 está localizado em /usr/share/postgresql/$VERSION/tsearch_data.
#   - Você pode procurar usando o comando find / -name tsearch_data no Linux ou MacOS.

VERSION='16'

# Exportando o diretório físico dos dicionários
export SHAREDIR=/usr/share/postgresql/$VERSION/tsearch_data 


# ----------------------------------------------------------------------------------------------------------------------------------------
# 1.2 - CRIANDO OS DICIONÁRIOS PERSONALIZADOS
#    - Não precisa modificar o dicionário de stop words, podemos utilizar o padrão do Postgres.
#    - Você pode começar pelo dicionário de sinônimos ou Thesaurus.

# 1.2.1 - DICIONÁRIO DE SINÔNIMO
#    - Esse comando cria o dicionário brazilian.syn com 2 linhas, cada uma com a palavra e sua substituição ao lado.
#    - Você pode salvar os termos que os usuários utilizaram e não tiveram resultado para depois adiciona-los ao dicionário de sinônimos.
echo "capassete capacete" | sudo tee -a $SHAREDIR/brazilian.syn
echo "gerenciamento gestão" | sudo tee -a $SHAREDIR/brazilian.syn

# 1.2.2 - DICIONÁRIO DE THESAURUS
#    - O dicionário Thesaurus é similar ao dicionário de sinômimos, mas com suporte a frases.
#    - O sinal de interrogação é para ignorar as stop words.
#    - Os Thesaurus é usado durante a indexação, portanto, qualquer alteração nos parâmetros do dicionário exige uma reindexação do documento.
echo "gerenciamento ? negócios : gestão
administração ? empresas : gestão
protetor ? cabeça : capacete
capassete : capacete" | sudo tee -a $SHAREDIR/brazilian.ths

# 1.2.3 - DICIONARIO HUNSPELL BR
#     - Instala o dicionário hunspell-pt-br no SO
sudo apt install hunspell-pt-br
#sudo pacman -S hunspell-pt-br

# No biglinux(manjaro/arch) apareceu a mensagem
#"Hunspell dictionary format supports only \"default\", \"long\", and 
#\"num\" flag value"
#Resolvi alterando em $SHAREDIR/tsearch_data/brazilian.affix o valor FLAG, que era UTF8, para default

#     - Converte o dicionário hunspell-pt-br para UTF8, copiando para o diretório padrão do POSTGRESQL
iconv -f latin1 -t UTF-8 /usr/share/hunspell/pt_BR.aff | sudo tee $SHAREDIR/brazilian.affix
iconv -f latin1 -t UTF-8 /usr/share/hunspell/pt_BR.dic | sudo tee $SHAREDIR/brazilian.dict

# ----------------------------------------------------------------------------------------------------------------------------------------
# 1.3 - REINICIAR O POSTGRESQL
sudo systemctl restart postgresql
