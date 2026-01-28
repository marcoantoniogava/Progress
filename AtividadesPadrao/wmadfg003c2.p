{webpro.i}
{wpadfunc.i}

procedure output-header:
end procedure.

&scoped-define vpad-tabela cidade
def query q1 for cidade, estado scrolling.

{wpadco03.i}

procedure p_setvalue:
end procedure.

procedure p_setparams:
    assign vpad-titulo  = "Cidades"
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
    then open query q1 for each cidade no-lock,
                                first estado where
                                    estado.est-estado = cidade.est-estado and
                                    cidade.cid-cidade >= (if int(get-value("vpad-pesq")) = 0
                                                      then cidade.cid-cidade
                                                      else int(get-value("vpad-pesq")))
                                by cidade.cid-cidade indexed-reposition.

    if get-value("vpad-ordena") = "N"
    then open query q1 for each cidade no-lock,
                                first estado where
                                estado.est-estado = cidade.est-estado and
                                cidade.cid-nome matches ("*" + get-value("vpad-pesq") + "*")
                                by cidade.cid-nome indexed-reposition.
end procedure.

procedure p_browse:
    finicio(vpad-cor, string(rowid(cidade))).
    fcaixa("C", string(cidade.cid-cidade),"C","Código","",40,0).
    fcaixa("C", cidade.cid-nome,"C","Nome","",50,0).
    fcaixa("C",if available estado then string(estado.est-nome) else "","C","Estado","",40,0).
    final(no,100,"").
end procedure.

procedure p_excluir:
end procedure.

procedure p_incluir: 
end procedure.

procedure p_alterar:
end procedure.