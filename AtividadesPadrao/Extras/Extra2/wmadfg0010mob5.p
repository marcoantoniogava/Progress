{webpro.i}
{wpadfunc.i}
{wpadmob.i}

//manutenção - cidade

def var TForm as class TForm.

procedure p_botao_action:
    frunprog("bsalvar-cidade","p_salvar","").
    frunprog("bexcluir-cidade","p_excluir","").
end procedure.

procedure p_load:

    def var vmob-label        as class OLabel.
    def var vmob-space        as class OSpace.
    def var vbtn-salvar       as class OButton.
    def var vbtn-retornar     as class OButton.
    def var vbtn-excluir      as class OButton.
    def var vinput-codigo     as class OText.
    def var vinput-nome       as class OText.
    def var vinput-est-estado as class OText.
    def var vinput-est-nome   as class OText.

    find first cidade no-lock no-error.

    assign TForm  = new TForm().

    assign vmob-label = new OLabel("Manutenção - Cidade").
    vmob-label:setAlign("center").
    vmob-label:setColor("blue").
    vmob-label:setBold().
    vmob-label:setSize(30).

    assign vinput-codigo     = new OText("ipt-cod","Código",get-value("codcidade")).
           vinput-nome       = new OText("ipt-nome","Nome",get-value("nomecidade")).
           vinput-est-estado = new OText("ipt-est-estado","Sigla - Estado",get-value("estadocidade")).
           vinput-est-nome   = new OText("ipt-est-nome","Nome - Estado",get-value("ipt-est-nome")).
           vinput-codigo:setSmall().
           vinput-codigo:setType("int").
           vinput-codigo:setDisabled(?).
           vinput-nome:setSmall().
           vinput-est-estado:setSmall().
           vinput-est-estado:setZoom("wmadfg009mob5","ipt-est-estado,ipt-est-nome").
           vinput-est-nome:setSmall().
           vinput-est-nome:setDisabled(?).

    assign vmob-space = new OSpace(20).
    vmob-space:setHr().

    assign vbtn-salvar   = new OButton("bsalvar-cidade","Salvar").
           vbtn-retornar = new OButton("bretornar", "Retornar").
           vbtn-excluir  = new OButton("bexcluir-cidade", "Excluir").
           vbtn-salvar:setColor("green").
           vbtn-retornar:setColor("blue").
           vbtn-excluir:setColor("red").
           vbtn-retornar:setLink("wmadfg002mob5").


    TForm:addObject(vmob-label).
    TForm:addObject(vmob-space).
    TForm:addObject(vinput-codigo).
    TForm:addObject(vinput-nome).
    TForm:addObject(vinput-est-estado).
    TForm:addObject(vinput-est-nome).
    TForm:addObject(vbtn-salvar).
    TForm:addObject(vbtn-excluir).
    TForm:addObject(vbtn-retornar).


    vpad-mobile:add(TForm).
end procedure.

procedure p_excluir:

    find cidade where string(cidade.cid-cidade) = get-value("ipt-cod") exclusive-lock no-error.
    if avail cidade
    then delete cidade.

    flocation("","wmadfg002mob5","").
end procedure.

procedure p_salvar:

    find cidade where string(cidade.cid-cidade) = get-value("ipt-cod") exclusive-lock no-error.

    if get-value("ipt-nome") = ""
    then do: 
        vpad-mobile:setMessage("warning","Informe o nome da cidade").
    end.

    if get-value("ipt-est-estado") = ""
    then do: 
        vpad-mobile:setMessage("warning","Informe o estado da cidade").
    end.

    else do:
        assign cidade.cid-nome   = get-value("ipt-nome")
               cidade.est-estado   = get-value("ipt-est-estado").

        flocation("","wmadfg002mob5","").
    end.
end procedure.