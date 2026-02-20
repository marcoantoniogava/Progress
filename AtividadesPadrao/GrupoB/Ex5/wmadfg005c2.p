{webpro.i}
{wpadfunc.i}

&scoped-define vpad-tabela pais
def query q1 for pais scrolling.


{wpadco05.i}


procedure p_setparams:


    assign vpad-titulo  = "Países"
           vpad-ordena  = ",Código,N,Nome"
           vpad-pesq    = true
           vpad-btnaveg = true
           vpad-numlin  = 30
           vpad-numcol  = 10
           vpad-frmload = true
           vpad-modo    = "MAN"
           vpad-progman = "wmadfg005m2".
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

    finicio(vpad-cor,"").
    fcaixa("C",string(pais.pai-pais),"C","Código","",12,0).
    fcaixa("E",pais.pai-nome,"E","Nome","",20,0).
    fcaixa("C",string(pais.uniao-europeia),"C","União Europeia","",12,0).
    fcaixa("E",string(pais.ccu-ccusto),"E","Centro de Custo","",12,0).
    final(no,100,"").
end procedure.