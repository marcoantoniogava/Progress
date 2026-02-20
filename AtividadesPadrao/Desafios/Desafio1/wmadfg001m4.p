{webpro.i}
{wpadma05.i}


def var vhidden as log.


function fpais returns char() forwards.


procedure output-header:


    flista("add","vpad-modo",get-value("vmodo")).
end procedure.


procedure p_setvalue:


    find estado where rowid(estado) = to-rowid(get-value("vpad-radio")) no-lock no-error.
end procedure.


procedure p_setparams:


    assign vpad-titulo = if get-value("vpad-modo") = "MAN" then "Manutenção" else "Inclusão"
           vpad-numcol = 2
           vpad-progco = "wmadfg001c4"
           vpad-btret  = ""
           vpad-btsal  = if get-value("vpad-modo") = "MAN" and not avail estado then "false" else "true"
           vpad-btinc  = "" 
           vpad-btexc  = if get-value("vpad-modo") = "MAN" and avail estado then "true" else "false".
end procedure.


procedure p_setinitial:


    assign vhidden = logical(get-value("vhidden-initial") <> "vhidden-initial").


    {&out}
        fbranco(2,vpad-numcol)
        flabel("EstadoSigla:","right",0,yes,no,42,yes,yes)
        fpad-text("vcid-nome",20,100,if vhidden
                                     then "" 
                                     else get-value("vcid-nome"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        flabel("Estado:","right",0,yes,no,42,yes,yes)
        fpad-text("estado-nome",20,100,if vhidden
                                     then "" 
                                     else get-value("estado-nome"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        flabel("País:","right",0,yes,no,0,yes,yes)
        fpad-text("vestado",20,10,if vhidden
                                     then ""
                                     else get-value("vestado"),"C",no,"left",0,no,no,0,yes,no,"document.forms[0].submit();","")
        fzoom("wmadfg0012z4","vestado,vpaisnome",no,no)
        fpad-text("vpaisnome",15,100,(if avail pais then pais.pai-nome else ""),"C",yes,"left",0,no,yes,0,no,yes,"","")
    .


    fhidden("vhidden-initial","vhidden-initial").
end procedure.


procedure p_mostra:

    if avail estado
    then do:

        {&out}
            fbranco(2,vpad-numcol)
            flabel("EstadoSigla:","right",0,yes,no,42,yes,yes)
            fpad-text("vcid-nome",20,100,estado.est-estado,"C",no,"left",0,no,yes,0,yes,yes,"","")
            
            flabel("Estado:","right",0,yes,no,0,yes,yes)
            fpad-text("estado-nome",20,100,estado.est-nome,"C",no,"left",0,no,yes,0,yes,yes,"","")
            
            flabel("País:","right",0,yes,no,0,yes,yes)
            fpad-text("vestado",20,10,get-value("vestado"),"C",no,"left",0,no,no,0,yes,no,"document.forms[0].submit();","")
            fzoom("wmadfg0012z4","vestado,vpaisnome",no,no)
            fpad-text("vpaisnome",15,100,(if avail pais then pais.pai-nome else ""),"C",yes,"left",0,no,yes,0,no,yes,"","")
        .
    end.
end procedure.


procedure p_criareg:

    def var vcodigo as int init 1. 

    find last estado no-lock no-error.
    if avail estado
    then assign vcodigo = estado.est-cod + 1.

    create estado. 
    assign estado.est-cod = vcodigo.
end procedure.


procedure p_grava:

    if get-value("vpad-modo") = "MAN"
    then do: //exclusive-lock para alterar ou apagar o registro
        find estado where rowid(estado) = to-rowid(get-value("vpad-radio")) exclusive-lock no-error.
    end.

    assign estado.est-estado   = get-value("vcid-nome")
           estado.est-nome     = get-value("estado-nome")
           estado.pai-pais     = int(get-value("vestado")).


    assign vpad-rowid = rowid(estado).

    fatubr("wmadfg001c4",string(vpad-rowid)).
end procedure.


procedure p_excluir:

    find estado where rowid(estado) = to-rowid(get-value("vpad-radio")) exclusive-lock no-error.
    if avail estado
    then delete estado.

    fatubr("wmadfg001c4","").
end procedure.



function fpais returns char(): 


    def var vselect as char.


    for each pais no-lock
          by pais.pai-nome:
        assign vselect = vselect + string(pais.pai-pais) + "," + pais.pai-nome + ",".
    end. 


    return vselect.
end function.