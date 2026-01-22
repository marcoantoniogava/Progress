// le o nome e a idade de varias pessoas e no final informa:
// quantas foram cadastradas e quantas sao maiores de 18 anos.

def var listaTotal as int extent 100.
def var listaMaiorIdade as int extent 100.
def var nome as char.
def var idade as int.
def var qtdTotal as int label "Total".
def var qtdMaiorIdade as int label "Maior Idade". 

qtdTotal = 0.
qtdMaiorIdade = 0.

repeat:

disp "Digite o nome da pessoa ou S para sair: ".
update nome.

if nome = "S" then do:
leave.
end. //end do if

else do:
disp "Digite a idade: ".
update idade.
end. //end do else

if idade >= 18 then do:
qtdMaiorIdade = qtdMaiorIdade + 1.
listaMaiorIdade[qtdMaiorIdade] = idade.
qtdTotal = qtdTotal + 1.
listaTotal[qtdTotal] = idade.
end. //end do if

else if idade < 18 and idade >= 0 then do:
qtdTotal = qtdTotal + 1.
listaTotal[qtdTotal] = idade.
end. //end do else if

else do:
disp "Numero invalido".
end. //end do else

end. //end do repeat

disp qtdTotal
qtdMaiorIdade.