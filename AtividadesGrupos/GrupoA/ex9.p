// converte um valor entre moedas, aplicando uma taxa de cambio de 2%
// sobre o valor convertido. Moedas a incluir:
// dolar: 5,28 reais; franco suico: 6,69 reais; real: 1 real; euro: 6,20 reais

//declarando variaveis
def var moedaEscolhida as char label "Moeda Escolhida".
def var valorConversao as dec.
def var moedaConversao as char label "Moeda Conversao".
def var cotacaoOrigem as dec.
def var cotacaoDestino as dec.
def var valorEmReal as dec.
def var valorConvertido as dec.
def var taxaConversao as dec.
def var valorFinal as dec.

//valor da taxa de conversao
assign taxaConversao = 0.98.

//pede a moeda de origem
disp "D - Dolar, F - Franco, R - Real, E - Euro".
update moedaEscolhida.

//aplicando cotacao de origem
if moedaEscolhida = "D" then do:
    assign cotacaoOrigem = 5.28.
end.
else if moedaEscolhida = "R" then do:
    assign cotacaoOrigem = 1.
end.
else if moedaEscolhida = "F" then do:
    assign cotacaoOrigem = 6.69.
end.
else if moedaEscolhida = "E" then do:
    assign cotacaoOrigem = 6.20.
end.
else do:
    disp "Escolha invalida".
end.

//pede o valor a ser convertido
disp "Valor a ser convertido: ".
update valorConversao.

//convertendo pra real
assign valorEmReal = valorConversao * cotacaoOrigem.

//pede a moeda de destino
disp "D - Dolar, F - Franco, R - Real, E - Euro".
update moedaConversao.

//aplicando cotacao de destino
if moedaConversao = "D" then do:
    assign cotacaoDestino = 5.28.
end.
else if moedaConversao = "R" then do:
    assign cotacaoDestino = 1.
end.
else if moedaConversao = "F" then do:
    assign cotacaoDestino = 6.69.
end.
else if moedaConversao = "E" then do:
    assign cotacaoDestino = 6.20.
end.
else do:
    disp "Escolha invalida".
end.

//convertendo pra moeda de destino
assign valorConvertido = valorEmReal / cotacaoDestino.

//aplicando a taxa
assign valorFinal = valorConvertido * taxaConversao.

//exibindo o valor final
disp valorFinal.
