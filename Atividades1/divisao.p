// exibe o resultado de um calculo de divisao entre dois numeros inteiros
def var n1 as int label "Valor 1".
def var n2 as int label "Valor 2".
def var resultado as int label "Resultado".

update n1
n2.

assign resultado = n1 / n2.

disp resultado.