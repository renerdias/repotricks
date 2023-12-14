!/bin/bash

# -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
# 1. CRIAR BANCO DE DADOS

# \set ON_ERROR_STOP true

# Exclui o banco de dados, caso exista
dropdb escola --echo --if-exists
echo
echo

# Cria o banco de dados
createdb \
    -h localhost \
    -p 5432 \
    -E UTF8 \
    --echo \
    --encoding=UTF8 \
    --lc-ctype='pt_BR.UTF-8' \
    --lc-collate='pt_BR.UTF-8' \
    escola "Banco de informações institucionais."
echo
echo
