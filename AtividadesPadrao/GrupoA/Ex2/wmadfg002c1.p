{webpro.i}
{wpadfunc.i}

procedure output-header:
end procedure.

&scoped-define vpad-tabela pais
def query q1 for pais scrolling.

{wpadco03.i}

procedure p_setvalue:
end procedure.

procedure p_setparams:
    assign vpad-titulo  = "Países"
           vpad-modo    = "CON"
           vpad-ordena  = ",Código,N,Nome"
           vpad-pesq    = true
           vpad-btnaveg = true
           vpad-numlin  = 30
           vpad-numcol  = 10
           vpad-btret   = ""
           vpad-btinc   = ""
           vpad-btexc   = "true".
end procedure.

procedure p_insere_botao:
    def output parameter vadd-botao as char.
    assign vadd-botao = "".
end procedure.

procedure p_botao_action:
    frunprog("idbotao","procedure","").
end procedure.

procedure p_abrequery:

    if get-value("vpad-ordena") = ""
    then open query q1 for each pais where 
                                pais.pai-pais >= (if int(get-value("vpad-pesq")) = 0
                                                      then pais.pai-pais
                                                      else int(get-value("vpad-pesq"))) no-lock 
                             by pais.pai-pais indexed-reposition.

    if get-value("vpad-ordena") = "N"
    then open query q1 for each pais where 
                                pais.pai-nome matches ("*" + get-value("vpad-pesq") + "*") no-lock 
                             by pais.pai-nome indexed-reposition.
end procedure.

procedure p_browse:
    finicio(vpad-cor, string(rowid(pais))).
    fcaixa("C", string(pais.pai-pais),"C","Código","",40,0).
    fcaixa("C", pais.pai-nome,"C","Nome","",50,0).
    final(no,100,"").
end procedure.

procedure p_excluir:
end procedure.

procedure p_incluir: 
end procedure.

procedure p_alterar:
end procedure.