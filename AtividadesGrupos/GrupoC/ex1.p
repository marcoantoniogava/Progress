// adiciona itens a um carrinho, informando descricao e valor do item,
// no final, mostra o valor total do carrinho.

def var valorTotal as dec label "ValorTotal".

def temp-table tt
field descricao as char
field valor as dec.

valorTotal = 0.

repeat:

create tt.

disp "Descricao ou S para sair: ".
update tt.descricao.

if tt.descricao = "S" then do:
undo, leave.
end. //end do if

else do:
disp "Valor: ".
update tt.valor.
valorTotal = valorTotal + tt.valor.
end. //end do else

end. //end do repeat

disp valorTotal.