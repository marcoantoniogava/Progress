// le uma sequencia de numeros inteiros, encerrada por 0,
// determina o tamanho da maior sequencia crescente consecutiva

def var numeroAnterior as int.
def var numeroAtual as int.
def var contador as int.
def var maiorSequencia as int.

numeroAnterior = ?.
contador = 1.
maiorSequencia = 0.

repeat:

update numeroAtual.

if numeroAtual - 1 = numeroAnterior then do:
contador = contador + 1.
end. //end do if

else if numeroAtual = 0 then do:
leave.
end. //end do else if

else do:
contador = 1.
end. //end do else

if contador > maiorSequencia then do:
assign maiorSequencia = contador.
end. //end do if

assign numeroAnterior = numeroAtual.

end. //end do repeat

disp maiorSequencia.
