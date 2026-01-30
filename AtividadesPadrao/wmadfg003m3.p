{webpro.i}
{wpadma05.i}

def var vhidden as log.

procedure output-header:
    flista("add","vpad-modo",get-value("vmodo")).
end procedure.

procedure p_setvalue:
    find pais where rowid(pais) = to-rowid(get-value("vpad-radio")) no-lock no-error.
end procedure.

procedure p_setparams:
    assign vpad-titulo = "Países"
           vpad-numcol = 10
           vpad-progco = "wmadfg003c3"
           vpad-btret  = ""
           vpad-btsal  = "true"
           vpad-btinc  = "true" 
           vpad-btexc  = "true".
end procedure.

procedure p_setinitial:

    assign vhidden = logical(get-value("vhidden-initial") <> "vhidden-initial").

    {&out}
        fbranco(2,vpad-numcol)
        flabel("Nome:","right",0,yes,no,42,yes,yes)
        fpad-text("vcid-nome",20,100,if vhidden
                                     then "" 
                                     else get-value("vcid-nome"),"C",no,"left",0,no,yes,0,yes,yes,"","").

    fhidden("vhidden-initial","vhidden-initial").
end procedure.

procedure p_mostra:

    if avail pais
    then do:

        {&out}
            fbranco(2,vpad-numcol)
            flabel("Nome:","right",0,yes,no,42,yes,yes)
            fpad-text("vcid-nome",20,100,pais.pai-nome,"C",no,"left",0,no,yes,0,yes,yes,"","").
    end.
end procedure.

procedure p_criareg:

    def var vcodigo as int init 1. 

    find last pais no-lock no-error.
    if avail pais 
    then assign vcodigo = pais.pai-pais + 1.

    create pais. 
    assign pais.pai-pais = vcodigo.
end procedure.

procedure p_grava:
    if get-value("vpad-modo") = "MAN"
    then do:
        find pais where rowid(pais) = to-rowid(get-value("vpad-radio")) exclusive-lock no-error.
    end.

    assign pais.pai-nome = get-value("vcid-nome").

    assign vpad-rowid = rowid(pais).

    fatubr("wmadfg003c3","rowid").
end procedure.

procedure p_excluir:
    find pais where rowid(pais) = to-rowid(get-value("vpad-radio")) exclusive-lock no-error.
    if avail pais
    then delete pais.

    fatubr("wmadfg003c3","").
end procedure.