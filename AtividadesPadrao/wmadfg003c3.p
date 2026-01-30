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
           vpad-progman = "wmadfg003m3".
         /*vpad-percsup = 0
           vpad-percinf = 0*/
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
    finicio(vpad-cor,string(rowid(pais))).
    fcaixa("C",string(pais.pai-pais),"C","Código","",50,0).
    fcaixa("C",pais.pai-nome,"C","País","",50,0).
    final(no,100,"").
end procedure.
