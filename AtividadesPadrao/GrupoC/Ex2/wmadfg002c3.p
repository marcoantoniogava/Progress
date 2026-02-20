{webpro.i}
{wpadfunc.i}

procedure output-header:
end procedure.

&scoped-define vpad-tabela cidade
def query q1 for cidade, estado, pais scrolling.

{wpadco03.i}

procedure p_setvalue:
end procedure.

procedure p_setparams:
    assign vpad-titulo  = "Cidades"
           vpad-modo    = "CON"
           vpad-ordena  = ",País,E,Estado,C,Cidade"
           vpad-pesq    = true
           vpad-btnaveg = true
           vpad-numlin  = 30
           vpad-numcol  = 10
           vpad-btret   = ""
           vpad-btinc   = ""
           vpad-btexc   = "true".
end procedure.

procedure p_abrequery:
    if get-value("vpad-ordena") = "" then do: // País
    open query q1 for each cidade no-lock,
                        first estado where
                            estado.est-estado = cidade.est-estado, //relaciona as cidades com seus estados
                        first pais where
                            pais.pai-pais = estado.pai-pais and //relaciona estados com seus paises
                            pais.pai-nome matches ("*" + get-value("vpad-pesq") + "*") //busca no banco o país pesquisado (q veio de vpad-pesq)
                        by pais.pai-nome //ordena pelo nome do pais
                        indexed-reposition.
    end.

    if get-value("vpad-ordena") = "E" then do: // Estado
    open query q1 for each cidade no-lock,
                        first estado where
                            estado.est-estado = cidade.est-estado and //relaciona as cidades com seus estados e:
                            estado.est-estado matches ("*" + get-value("vpad-pesq") + "*"), //busca no banco o estado pesquisado (q veio de vpad-pesq)
                        first pais where
                            pais.pai-pais = estado.pai-pais //relaciona os estados com seus países
                        by estado.est-estado //ordena pelo nome do estado
                        indexed-reposition.
    end.

    if get-value("vpad-ordena") = "C" then do: // Cidade
    open query q1 for each cidade no-lock
                        where cidade.cid-nome matches ("*" + get-value("vpad-pesq") + "*"), //busca no banco a cidade pesquisada (q veio de vpad-pesq)
                        first estado where
                            estado.est-estado = cidade.est-estado, //relaciona as cidades com seus estados
                        first pais where
                            pais.pai-pais = estado.pai-pais //relaciona os estados com seus países
                        by cidade.cid-nome //ordena pelo nome da cidade
                        indexed-reposition.
    end.
end procedure.

procedure p_browse:
    finicio(vpad-cor, string(rowid(cidade))).
    fcaixa("C", string(cidade.cid-cidade),"C","Código","",40,0).
    fcaixa("C", cidade.cid-nome,"C","Nome","",50,0).
    fcaixa("C",if avail estado then string(estado.est-nome) else "","C","Estado","",40,0).
    fcaixa("C", string(pais.pai-nome),"C","País","",40,0).
    final(no,100,"").
end procedure.

procedure p_excluir:
end procedure.

procedure p_incluir: 
end procedure.

procedure p_alterar:
end procedure.