{webpro.i}
{wpadfunc.i}

&scoped-define vpad-tabela item
def query q1 for item scrolling.

{wpadco03.i}

procedure p_setparams:

    assign vpad-titulo  = "Itens"
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

procedure p_abrequery:
    open query q1 for each item no-lock indexed-reposition.
end procedure.

procedure p_browse:

    finicio(vpad-cor,"").
    fcaixa("C",string(item.ite-codigo),"C","Código","",12,0).
    fcaixa("E",item.ite-descricao,"E","Descrição","",0,0).
    fcaixa("C",if item.ite-estocavel then floadimg("/sistema/imagens/aprov-verde.png",12,12,"Imagem","href") else floadimg("/sistema/imagens/x-vermelho.png",12,12,"Imagem","href"),"C","Estocável","",12,0).
    final(no,100,"").
end procedure.