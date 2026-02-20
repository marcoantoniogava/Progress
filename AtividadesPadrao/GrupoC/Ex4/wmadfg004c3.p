{webpro.i}
{wpadfunc.i}

procedure output-header:
    flista("add","vpad-btpesq.x","true").
end procedure.

&scoped-define vpad-tabela clifor
def query q1 for clifor scrolling.

{wpadco04.i}

procedure p_setparams:
    assign vpad-titulo  = "Empresas"
           vpad-ordena  = ""
           vpad-pesq    = false
           vpad-btnaveg = true
           vpad-numlin  = 30
           vpad-numcol  = 10
           vpad-btret   = ""
           vpad-btinc   = ""
           vpad-btsal   = ""
           vpad-btexc   = ""
           vpad-progman = "wmadfg004m3".
end procedure.

procedure p_abrequery:
    open query q1 for each clifor no-lock indexed-reposition.
end procedure.

procedure p_filtro:
    {&out}
    .
end procedure.

procedure p_browse:
    finicio(vpad-cor,"").
    fcaixa("C",string(clifor.cli-codigo),"C","Código",furlmanu("wmadfg004m3", string(rowid(clifor))),12,0).
    fcaixa("C",clifor.cli-fantasi,"C","Nome","",30,0).
    fcaixa("C",string(clifor.cli-fone1),"C","Telefone","",12,0).
    final(no,100,"").
end procedure.