
# Instalação:
- Baixar versão stable em www.lazarus-ide.org
      # FPC
      sudo dpkg -i fpc*.deb
      # Lazarus IDE
      sudo dpkg -i lazarus*.deb
      # Instala dependencias não encontradas
      sudo apt -f install


# Configuração

## Mudança de idioma:
    Tools > Environment > General > Language;
    Reiniciar;
      
## Linha vertical de correspondencia:
    Ferramentas > Opções > Editor > Exibir > Indicadores e Correpondência, na Seção, Palavras chave correspondentes, marcar a opção "Contorno";

## Linha vertical de limite de formatação
    Ferramentas > Opções > Editor > Exibir, na seção "Margem e medianiz",  marcar a opção Margem direita visível e alterar valor para "150", depois clicar em "Editar cor" e escolher a cor vermelha;

## Alteração do nome da pasta de backup dos arquivos dos projetos
    Ferramentas > Opções > Cópia de segurança
      Na seção **Arquivo do Projeto**:
        Em Tipo, selecionar a opção 'Extensão definida pelo usuário';
        Em 'Extensão definida pelo usuário' alterar de 'bak' para '__bkp'
        E alterar o nome do subdiretório para backup de "backup" para __backup;
      Na seção **Outros arquivos**:
        Em Tipo, selecionar a opção 'Extensão definida pelo usuário';
        Em 'Extensão definida pelo usuário' alterar de 'bak' para '__bkp'
        E alterar o nome do subdiretório para backup de "backup" para __backup;     



# Componentes

### Fonte: https://gladiston.net.br/programacao/lazarus-ide/introducao-e-instalacao-de-pacotes-basicos/
## Pacotes locais que acompanham a IDE
- AnchorDockingDsgn: (Ancora as janelas da IDE, exceto os forms);
- AnchorDocking: (Permite criar aplicaçoes com dockagem);
- DockedFormEditor: (Ancora Form na Unit (Código/Form/Ancoragem no editor));
- LazProjectGroups: (Permite agrupar projetos);
- lclfpreport: fpReport;
- lazidefpreport: fpReport - Instala a paleta na IDE;
- lazfpreportdesign: fpReport;
- lazreport: LazReport, similar ao fpReport, mas aparentemente mais facil de usar em modo gráfico

## Pacotes online:
- RichMemo;
- ZeosDBO;
- FortesReport-CE;
- TDINotebook;





verificar se tem ligação com o fpReport
fpvectorial2aggpaspkg.lpk
tachartfpvectorial.lpk




MyStyle - Theme

Colors
Usage 	Palette 	Hex Code
Background 	Darkest 	#2d2d2d #2d2d2d
Comment 	Medium 	#777c85 #777c85


Foreground 	Light 	#b3b9c5 #b3b9c5
Function 	Lightest 	#ffffff #ffffff
Variable 	Red 	#f2777a #f2777a
Number 	Orange 	#FCA369 #fca369
Attribute 	Yellow 	#FFD479 #ffd479
Keyword 	Light Yellow 	#ffeea6 #ffeea6
String 	Green 	#92D192 #92d192
Class/Tag 	Blue 	#6AB0F3 #6AB0F3
Constant/Pseudo     Aqua    #76D4D6 #76d4d6
Support 	Purple 	#E1A6F2 #e1a6f2
Operator 	Beige 	#ac8d58 #ac8d58
