```
O padrão é 99999.99999 99999.999999 99999.999999 9 99999999999999 onde:

Posição 01-03 = Identificação do banco (exemplo: 001 = Banco do Brasil)
Posição 04-04 = Código de moeda (exemplo: 9 = Real)
Posição 05-09 = 5 primeiras posições do campo livre (posições 20 a 24 do código de barras)
Posição 10-10 = Dígito verificador do primeiro campo
Posição 11-20 = 6ª a 15ª posições do campo livre (posições 25 a 34 do código de barras)
Posição 21-21 = Dígito verificador do segundo campo
Posição 22-31 = 16ª a 25ª posições do campo livre (posições 35 a 44 do código de barras)
Posição 32-32 = Dígito verificador do terceiro campo
Posição 33-33 = Dígito verificador geral (posição 5 do código de barras)
Posição 34-37 = Fator de vencimento (posições 6 a 9 do código de barras)
Posição 38-47 = Valor nominal do título (posições 10 a 19 do código de barras)


Os números do boleto bancário formam a chamada linha digitável, uma sequência de números que representa o código de barras. Essa linha é composta por 47 ou 48 dígitos que são distribuídos em 5 campos. Veja o que eles significam:

    Três dígitos iniciais: código do banco emissor, definido pela FEBRABAN;
    Quarto dígito: moeda do país emissor, que no caso do Brasil é o 9;
    Próximos 25 dígitos: números que carregam as informações do boleto, como por exemplo a empresa cobradora, data de emissão, entre outros dados;
    30º dígito: é o dígito verificador, gerado a partir do cálculo dos números anteriores;
    4 dígitos seguintes: representam a data de vencimento do boleto a partir da data-base definida pelo Banco Central, que é 7 de outubro de 1997.
    10 últimos dígitos: se referem ao valor do boleto, por exemplo, se o valor for R$ 25,90, esses números do boleto será 0000002590.

```

<div class="content">

                <h1>Anatomia do código de barras Febraban:</h1>
                
                <div class="descr">
                    <script>
                    show_date()
                    </script>Feb 8, 2024
                </div>
                    <p>A informação contida no código de barras de um boleto não é exatamente igual aos dígitos impressos no mesmo. O código de barras contém 44 dígitos e os dígitos impressos (chamados de campos digitáveis) contém 47 ou 48 dígitos.
</p><p>Os quadros abaixo mostram a difereça  entre o código de barras original e os campos digitáveis correspondentes para concessionárias e boletos. As cores indicam a posição dos dígitos no código de barras e os seus correspondentes nos campos digitáveis.

                    </p><h2>Concessionária</h2>
                <div style="background-color:#e6e4e4">
                    <h4>Conteúdo original do código de barras:</h4>
                    <b><font color="darkorange">846<font color="black">7</font>0000001</font><font color="darkgreen">43590024020</font><font color="blue">02405000243</font><font color="DarkCyan">84221010811</font></b>&nbsp;&nbsp;&nbsp;&nbsp;(44
                    dígitos)
                    <br>O quarto dígito (preto) é o DV geral.
                     
                     <br>&nbsp;
                    <h4>Conversão do código de barras em campos digitáveis:</h4>
                    <b><font color="darkorange">846<font color="black">7</font>0000001</font>-<font color="red">7</font> <font color="darkgreen">43590024020</font>-<font color="red">9</font> <font color="blue">02405000243</font>-<font color="red">5</font>   <font color="DarkCyan">84221010811</font>-<font color="red">9</font></b>&nbsp;&nbsp;&nbsp;(48 dígitos)
                    <br>Os dígitos em vermelho são DV de cada campo digitável. Não
                    fazem parte do código de barras original, eles são calculados segundo os padrões da Febraban e mostrados pelo Boleto Scanner.
                     <br>&nbsp;
                </div>

                    <h2>Boleto bancário</h2>
                <div style="background-color:#e6e4e4">
                    <h4>Conteúdo original do código de barras:</h4>
                    <b>
                    <font color="DarkCyan">2379</font><font color="black">7</font><font color="darkorange">40430000124020</font><font color="darkgreen">04480</font><font color="BlueViolet">5616862379</font><font color="blue">3601105800</font></b>&nbsp;&nbsp;&nbsp;&nbsp;(44
                    dígitos)
                    <br>O quinto dígito (preto) é o DV geral.
                     
                     <br>&nbsp;
                    <h4>Conversão do código de barras em campos digitáveis:</h4>
                    <b>
                    <font color="DarkCyan">2379</font><font color="darkgreen">0.4480</font><font color="red">9</font>&nbsp;
                    <font color="BlueViolet">56168.62379</font><font color="red">3</font>&nbsp;<font color="blue">36011.05800</font><font color="red">9</font>&nbsp;<font color="black">7</font>&nbsp;<font color="darkorange">40430000124020</font></b>&nbsp;&nbsp;&nbsp;(47 dígitos)

                    <br>Os dígitos em vermelho
                    são DV de cada campo digitável. Não
                    fazem parte do código de barras original, eles são calculados segundo os padrões da Febraban e mostrados pelo Boleto Scanner.

                     <br>&nbsp;
                </div>

                    </div>
