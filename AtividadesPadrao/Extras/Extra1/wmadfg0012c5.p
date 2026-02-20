{webpro.i}
{wpadfunc.i}

def temp-table tt-item like item
    field vinculado as log
    field ite-rowid as char.

&scoped-define vpad-tabela tt-item
def query q1 for tt-item scrolling.

{wpadco03.i}

procedure output-header:
    flista("add","vpad-radio",get-value("vpad-radio")).
end procedure.

procedure p_setparams:

    assign vpad-titulo  = "Cidades"
           vpad-modo    = "CON"
           vpad-ordena  = ""
           vpad-pesq    = false
           vpad-btnaveg = true
           vpad-numlin  = 30
           vpad-numcol  = 10
           vpad-btret   = ""
           vpad-btinc   = ""
           vpad-btexc   = "".
end procedure.

procedure p_insere_botao:

    def output parameter vadd-botao as char.
    assign vadd-botao = fbotao_input("Salvar","btn-salvar","Salvar","wmadfg0012c5").
end procedure.

procedure p_botao_action:
    frunprog("btn-salvar","p_salvar","").
end procedure.

procedure p_abrequery:
    find first pedido 
        where rowid(pedido) = to-rowid(get-value("vpad-radio")) 
        no-lock no-error.

        if not avail pedido then do:
        put unform "pedido indisponivel".
    end.
    
    for each item no-lock:
        create tt-item. //cria a temp-table
        buffer-copy item to tt-item. //copia registro por registro, até copiar todos de item pra temp-table

        assign tt-item.ite-rowid = string(rowid(item)).

        find first pedidoitem where //se existe um registro
                   pedidoitem.ped-codigo = pedido.ped-codigo and //com o mesmo ped-codigo do pedido
                   pedidoitem.ite-codigo = item.ite-codigo no-lock no-error. //e o mesmo ite-codigo do item

        if avail pedidoitem
        then assign tt-item.vinculado = yes. //marca como vinculado
    end.

    open query q1 for each tt-item no-lock
                        by tt-item.vinculado desc indexed-reposition.
end procedure.

procedure p_browse:

    finicio(vpad-cor,""). //2° parametro: "yes" pq é oq retorna quando tiver marcada. 3° parametro: tt-item.vinculado (é o estado de como está agora (marcado ou não))
    fcaixa("C",fpad-check("vcheck" + string(tt-item.ite-codigo),"yes",tt-item.vinculado,no,"left",0,no,no,0,no,no,"",""),"C","Marcar","",0,0).
    fcaixa("C",string(tt-item.ite-codigo),"C","Código","",0,0).
    fcaixa("C",tt-item.ite-descricao,"C","Nome do Item","",0,0).
    final(no,100,"").
    fhidden("vhidden-item" + string(tt-item.ite-codigo),tt-item.ite-rowid).
end procedure.

procedure p_salvar:

    def var vcont    as int.
    def var vite-cod as int.
    def var vcheck   as logical.

    find first pedido where rowid(pedido) = to-rowid(get-value("vpad-radio")) no-lock no-error.

    if not avail pedido then do:
        put unform "pedido indisponivel2".
    end.

    do vcont = 1 to flista-num("PAR","vhidden-item"):

        assign vite-cod = int(flista-val("PAR", vcont, "vhidden-item", "R")). /*//tira o radical (pega o codigo do item) (se fosse V pegaria o valor (2° parametro)) */
        assign vcheck   = get-value("vcheck" + string(vite-cod)) = "yes". /* //pega o valor do check (yes/no) */

        find first pedidoitem where
                   pedidoitem.ped-codigo = pedido.ped-codigo and /* // = ao codigo do pedido */
                   pedidoitem.ite-codigo = vite-cod exclusive-lock no-error. /* // = ao codigo do item */

        if vcheck and not avail pedidoitem 
        then do: /* //se foi marcado e nao tem registro, vai criar */
            create pedidoitem.
            assign pedidoitem.ped-codigo = pedido.ped-codigo
                   pedidoitem.ite-codigo = vite-cod.
        end.

        if not vcheck and avail pedidoitem 
        then do: /* //se foi desmarcado e existe registro, deleta */
            delete pedidoitem.
        end.
    end.
end procedure.