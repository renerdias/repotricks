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
https://www.ttrix.com/apple/iphone/boletoscan/boletoanatomia.html
![image](https://github.com/renerdias/repotricks/assets/21220318/5ab88c52-ec88-4637-9900-72bed3c86062)
