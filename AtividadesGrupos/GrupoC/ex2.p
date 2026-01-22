// cadastra produtos contendo codigo, descricao e preco
// armazena em uma tt e permite listar todos os produtos
// e mostrar o valor medio dos precos

def temp-table tt
field codigo as int
field descricao as char
field preco as dec.

def var opcao as int.
def var totalProd as int.
def var totalValor as dec.
def var media as dec label "Valor medio".

totalProd = 0.

repeat:

disp "1 - Cadastrar, 2- listar, 3 - Mostrar valor medio, 4 - Sair: ".
update opcao.

if opcao = 1 then do:
create tt.
update tt.codigo
tt.descricao
tt.preco.
totalProd = totalProd + 1.
totalValor = totalValor + tt.preco.
end. //end do if

else if opcao = 2 then do:
for each tt no-lock:
disp tt.codigo
tt.descricao
tt.preco.
end. //end do for each
end. //end do else if

else if opcao = 3 then do:
media = totalValor / totalProd.
disp media.
end. //end do else if

else if opcao = 4 then do:
leave.
end. //end do else if

else do:
disp "Opcao invalida".
end. //end do else

end. //end do repeat