{webpro.i}
{wpadfunc.i}


function festado returns char() forwards.


procedure output-header:


    flista("add","vpad-btpesq.x","true").
end procedure.


&scoped-define vpad-tabela estado
def query q1 for estado, pais scrolling.


{wpadco06.i}


procedure p_setparams:


    assign vpad-titulo  = "EstadoPaís"
           vpad-ordena  = ",Estado,P,Pais"
           vpad-pesq    = true
           vpad-btnaveg = true
           vpad-numlin  = 30
           vpad-numcol  = 10
           vpad-frmload = true
           vpad-modo    = "MAN"
           vpad-progman = "wmadfg006m1".
end procedure.


procedure p_abrequery:


    if get-value("vpad-ordena") = "" 
    then open query q1 for each estado where //usa vpad-pesq pro filtro funcionar em um lugar, e vest-estadof pra funcionar em outro
                                estado.est-estado matches ("*" + get-value("vpad-pesq") + "*")    and
                                estado.est-estado matches ("*" + get-value("vest-estadof") + "*") no-lock,
                          first pais where
                                pais.pai-pais = estado.pai-pais no-lock
                             by estado.est-estado indexed-reposition.


    if get-value("vpad-ordena") = "P" then do: // País
    open query q1 for each estado no-lock,
                     first pais where
                           pais.pai-pais = estado.pai-pais and
                           pais.pai-nome matches ("*" + get-value("vpad-pesq") + "*") no-lock
                         by pais.pai-nome indexed-reposition.
    end.
end procedure.


procedure p_filtro:


    find estado where 
         estado.est-estado = get-value("vest-estadof") no-lock no-error.


    {&out}
        flabel("Estado","right",0,no,no,0,no,no)
        fpad-text("vest-estadof",6,10,get-value("vest-estadof"),"C",no,"left",0,no,no,0,no,no,"document.forms[0].submit();","")
        fzoom("wmadfg006z1","vest-estadof,vest-nomef",no,no)
        fpad-text("vest-nomef",15,100,(if avail estado then estado.est-nome else ""),"C",yes,"left",0,no,no,0,no,no,"","")
    .
end procedure.


procedure p_browse:
    
    finicio(vpad-cor,string(rowid(estado))).
    fcaixa("C",caps(estado.est-estado),"C","Estado","",12,0).
    fcaixa("C",estado.est-nome,"C","EstadoNome","",0,0).
    fcaixa("C",pais.pai-nome,"C","País","",10,0).
    final(no,100,"").
end procedure.


function festado returns char(): 


    def var vselect as char.


    assign vselect = ",<-- SELECIONE -->".


    for each estado no-lock
          by estado.est-nome:
        assign vselect = vselect + "," + estado.est-estado + "," + estado.est-nome.
    end. 


    return vselect.
end function.