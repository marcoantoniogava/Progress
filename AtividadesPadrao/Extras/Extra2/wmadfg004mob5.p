{webpro.i}
{wpadfunc.i}
{wpadmob.i}

//estados

def var TForm as class TForm.
def var TLista-estado as class TListView.

procedure p_botao_action:
    frunprog("bsalvar-pais","p_salvar","").
    frunprog("bexcluir-pais","p_excluir","").
end procedure.

procedure p_load:

    def var vmob-label    as class OLabel.
    def var vmob-space    as class OSpace.
    def var vbtn-salvar   as class OButton.
    def var vbtn-retornar as class OButton.
    def var vbtn-excluir  as class OButton.
    def var vinput-codigo as class OText.
    def var vinput-nome   as class OText.

    find first estado no-lock no-error.
    find first pais no-lock no-error.

    assign TForm  = new TForm().
    assign TLista-estado = new TListView().
    for each estado where 
             string(estado.pai-pais) = get-value("codpais") no-lock:
        TLista-estado:addCard("Nome: " + estado.est-nome, "Sigla: " + estado.est-estado, "País: " + string(estado.pai-pais), 
        "wmadfg007mob5?codestado=" + string(estado.est-cod) + "&nomeestado=" + estado.est-nome + "&siglaestado=" + estado.est-estado + 
        "&codpaisestado=" + string(estado.pai-pais)).
    end.

    assign vmob-label = new OLabel("Manutenção do País + Estados dele").
    vmob-label:setAlign("center").
    vmob-label:setColor("blue").
    vmob-label:setBold().
    vmob-label:setSize(30).

    assign vinput-codigo = new OText("ipt-cod","Código",get-value("codpais")).
           vinput-nome   = new OText("ipt-nome","Nome",get-value("nomepais")).
           vinput-codigo:setSmall().
           vinput-codigo:setType("int").
           vinput-codigo:setDisabled(?).
           vinput-nome:setSmall().

    assign vmob-space = new OSpace(20).
    vmob-space:setHr().

    assign vbtn-salvar   = new OButton("bsalvar-pais","Salvar").
           vbtn-retornar = new OButton("bretornar", "Retornar").
           vbtn-excluir  = new OButton("bexcluir-pais", "Excluir").
           vbtn-salvar:setColor("green").
           vbtn-retornar:setColor("blue").
           vbtn-excluir:setColor("red").
           vbtn-retornar:setLink("wmadfg002mob5").


    TForm:addObject(vmob-label).
    TForm:addObject(vmob-space).
    TForm:addObject(vinput-codigo).
    TForm:addObject(vinput-nome).
    TForm:addObject(vbtn-salvar).
    TForm:addObject(vbtn-excluir).
    TForm:addObject(vbtn-retornar).


    vpad-mobile:add(TForm).
    vpad-mobile:add(TLista-estado).
end procedure.

procedure p_excluir:

    find pais where string(pais.pai-pais) = get-value("ipt-cod") exclusive-lock no-error.
    if avail pais
    then delete pais.

    flocation("","wmadfg002mob5","").
end procedure.

procedure p_salvar:

    find pais where string(pais.pai-pais) = get-value("ipt-cod") exclusive-lock no-error.
    
    if get-value("ipt-nome") = ""
    then do: 
        vpad-mobile:setMessage("warning","Informe o nome do país").
    end.

    else do:
        assign pais.pai-nome = get-value("ipt-nome").

        flocation("","wmadfg002mob5","").
    end.
end procedure.