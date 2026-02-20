{webpro.i}
{wpadfunc.i}

procedure output-header:
    flista("add","vpad-btpesq.x","true").
end procedure.

&scoped-define vpad-tabela pedido
def query q1 for pedido scrolling.

{wpadco07.i}

procedure p_setparams:

    assign vpad-titulo  = "Pedidos"
           vpad-ordena  = ""
           vpad-pesq    = false
           vpad-btnaveg = true
           vpad-numlin  = 30
           vpad-numcol  = 10
           vpad-frmload = true
           vpad-modo    = "MAN"
           vpad-progman = "wmadfg0012c5".
end procedure.

procedure p_abrequery:
    open query q1 for each pedido no-lock by pedido.ped-codigo indexed-reposition.
end procedure.

procedure p_filtro:

    {&out}
    .
end procedure.

procedure p_browse:

    finicio(vpad-cor,string(rowid(pedido))). //2° parametro: vpad-radio
    fcaixa("C",string(pedido.ped-codigo),"C","Código","",10,0).
    final(no,100,"").
end procedure.