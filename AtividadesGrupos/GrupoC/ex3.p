// simula um pedido de venda, cada pedido pode ter varios itens,
// cada item possui produto, quantidade e valor unitario,
// usar 2 temp-tables (pedido e itens) e ao final listar os itens do pedido
// e o valor total do pedido

def temp-table tt-pedido
field itens as char label "Itens"
field valorTotalPedido as dec label "Valor Total".

def temp-table tt-item
field produto as char label "Produto"
field quantidade as int
field valorUnit as dec
field valorTotalItens as dec.
def var opcao as int label "Opcao".

create tt-pedido.

repeat:

disp "1-Fazer pedido, 2-Listar itens e valor total, 3-Sair: ".
update opcao.

if opcao = 1 then do:
create tt-item.

disp "Faca seu pedido: ".
update tt-item.produto
tt-item.quantidade
tt-item.valorUnit.
assign tt-pedido.itens = tt-item.produto.
tt-item.valorTotalItens = tt-item.quantidade * tt-item.ValorUnit.
tt-pedido.valorTotalPedido = tt-pedido.valorTotalPedido + tt-item.valorTotalItens.

end. //end do if

else if opcao = 2 then do:
for each tt-item no-lock:
disp tt-item.produto.
end. //end do for each
disp tt-pedido.valorTotalPedido.
end. //end do else if

else if opcao = 3 then do:
leave.
end. //end do else if

else do:
disp "Opcao invalida".
end. //end do else

end. //end do repeat
