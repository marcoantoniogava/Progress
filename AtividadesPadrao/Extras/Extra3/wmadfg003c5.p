{webpro.i}
{wpaddisp.i}

function fpais returns char() forwards.

procedure p_setparams:

    assign vpad-titulo   = "Países"
           vpad-numcol   = 2
           vpad-programa = "wmadfg003m5.p"
           vpad-btdisp   = true.
end procedure.

procedure p_setinitial:

    {&out}
        fbranco(2,vpad-numcol)
        flabel("País:","right",0,yes,no,40,yes,yes)
        fselect("vpais",fpais(),get-value("vpais"),1,no,no,"left",0,no,yes,0,yes,yes,"")
    .
end procedure.

procedure p_disparar:

    create tp-batweb.
    assign tp-batweb.batdes      = vpad-titulo 
           tp-batweb.batprog     = vpad-programa
           tp-batweb.batpari[1]  = int(get-value("vpais"))
           tp-batweb.batpardc[1] = 2.2
           tp-batweb.batparlg[1] = yes
           tp-batweb.batpardt[1] = today.
end procedure.

function fpais returns char(): 

    def var vselect as char.

    assign vselect = ",<-- SELECIONE -->".

    for each pais no-lock
          by pais.pai-nome:
        assign vselect = vselect + "," + string(pais.pai-pais) + "," + pais.pai-nome.
    end. 

    return vselect.
end function.