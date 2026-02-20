{webpro.i}
{wpadfunc.i}

&scoped-define vpad-tabela estado
def query q1 for estado scrolling.

if get-value("vpad-ordena") = ""
then open query q1 for each estado where 
                            estado.est-estado matches ("*" + get-value("vpad-pesq") + "*") and
                            estado.pai-pais = (if get-value("vpai-pais-global") = ""
                                               then estado.pai-pais
                                               else int(get-value("vpai-pais-global"))) no-lock
                         by estado.est-estado indexed-reposition.

if get-value("vpad-ordena") = "N"
then open query q1 for each estado where 
                            estado.est-nome matches ("*" + get-value("vpad-pesq") + "*") and
                            estado.pai-pais = (if get-value("vpai-pais-global") = ""
                                               then estado.pai-pais
                                               else int(get-value("vpai-pais-global"))) no-lock
                         by estado.est-nome indexed-reposition.

{wpadzoom.i}

procedure p_setparams:

    assign vpad-ordena = ",Sigla,N,Nome"
           vpad-pesq   = true
           vpad-numlin = 30
           vpad-numcol = 10.
end procedure.

procedure p_browse:

    finicio(vpad-cor,"").
    fcaixa("C",estado.est-estado,"C","Código",furlzoom(get-value("vcampo"),estado.est-estado + "," + estado.est-nome),12,0).
    fcaixa("E",estado.est-nome,"E","Nome","",0,0).
    final(no,100,"").
end procedure.