{webpro.i}
{wpadfunc.i}

&scoped-define vpad-tabela pais
def query q1 for pais scrolling.

if get-value("vpad-ordena") = ""
then open query q1 for each pais where 
                            string(pais.pai-pais) matches ("*" + get-value("vpad-pesq") + "*") 
                         by pais.pai-pais indexed-reposition.

if get-value("vpad-ordena") = "N"
then open query q1 for each pais where 
                            pais.pai-nome matches ("*" + get-value("vpad-pesq") + "*") no-lock 
                         by pais.pai-nome indexed-reposition.

{wpadzoom.i}

procedure p_setparams:

    assign vpad-ordena = ",C�digo,N,Nome"
           vpad-pesq   = true
           vpad-numlin = 30
           vpad-numcol = 10.
end procedure.

procedure p_browse:

    finicio(vpad-cor,"").
    fcaixa("C",string(pais.pai-pais),"C","C�digo",furlzoom(get-value("vcampo"),string(pais.pai-pais) + "," + pais.pai-nome),12,0).
    fcaixa("E",pais.pai-nome,"E","Nome","",0,0).
    final(no,100,"").
end procedure.