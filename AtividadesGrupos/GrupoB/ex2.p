// le uma lista de numeros (ate informar zero) e exibe:
// quantidade de numeros informados, soma total, media dos valores.

def var lista as dec extent 100.
def var n as dec label "Numero".
def var soma as dec label "Soma".
def var qtd as int label "Quantidade".
def var media as dec label "Media".

soma = 0.
qtd = 0.

repeat:

update n.

if n = 0 then do:
leave.
end.

else do:

qtd = qtd + 1.
soma = soma + n.
lista[qtd] = n. //add na posicao correspondente, o numero.
end. //end do else
end. //end do repeat

media = soma / qtd.

disp qtd
soma
media.