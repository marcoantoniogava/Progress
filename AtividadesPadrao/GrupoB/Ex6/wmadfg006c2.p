{webpro.i}
{wpadfunc.i}


function festado returns char() forwards.


procedure output-header:


    flista("add","vpad-btpesq.x","true").
end procedure.


&scoped-define vpad-tabela cidade
def query q1 for cidade scrolling.


{wpadco06.i}


procedure p_setparams:


    assign vpad-titulo  = "Cidades"
           vpad-ordena  = ",Código,N,Nome"
           vpad-pesq    = true
           vpad-btnaveg = true
           vpad-numlin  = 30
           vpad-numcol  = 10
           vpad-frmload = true
           vpad-modo    = "MAN"
           vpad-progman = "wmadfg006m2".
end procedure.


procedure p_abrequery:


    if get-value("vpad-ordena") = ""
    then open query q1 for each cidade where 
                                cidade.cid-cidade >= (if int(get-value("vpad-pesq")) = 0
                                                      then cidade.cid-cidade
                                                      else int(get-value("vpad-pesq"))) and 
                                cidade.est-estado  = (if get-value("vest-estadof") = ""
                                                      then cidade.est-estado
                                                      else get-value("vest-estadof")) no-lock 
                             by cidade.cid-cidade indexed-reposition.


    if get-value("vpad-ordena") = "N"
    then open query q1 for each cidade where 
                                cidade.cid-nome matches ("*" + get-value("vpad-pesq") + "*") and 
                                cidade.est-estado = (if get-value("vest-estadof") = ""
                                                     then cidade.est-estado
                                                     else get-value("vest-estadof")) no-lock 
                             by cidade.cid-nome indexed-reposition.
end procedure.


procedure p_filtro:


    find estado where 
         estado.est-estado = get-value("vest-estadof") no-lock no-error.


    {&out}
        flabel("Estado","right",0,no,no,0,no,no)
        fpad-text("vest-estadof",6,10,get-value("vest-estadof"),"C",no,"left",0,no,no,0,no,no,"document.forms[0].submit();","")
        fzoom("wmadfg006z2","vest-estadof,vest-nomef",no,no)
        fpad-text("vest-nomef",15,100,(if avail estado then estado.est-nome else ""),"C",yes,"left",0,no,no,0,no,no,"","")
    .
end procedure.


procedure p_browse:


    find estado where 
         estado.est-estado = cidade.est-estado no-lock no-error.


    finicio(vpad-cor,string(rowid(cidade))).
    fcaixa("C",string(cidade.cid-cidade),"C","CÃ³digo","",12,0).
    fcaixa("E",cidade.cid-nome,"E","Nome","",0,0).
    fcaixa("C",caps(cidade.est-estado),"C","Estado","",12,0).
    fcaixa("E",if avail estado then estado.est-nome else "","E","Nome Estado","",0,0).
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