{webpro.i}
{wpadfunc.i}
{wpadmob.i}

//cidades

def var TForm as class TForm.
def var TLista-cidade as class TListView.

procedure p_botao_action:
    frunprog("bsalvar-estado","p_salvar","").
    frunprog("bexcluir-estado","p_excluir","").
end procedure.

procedure p_load:

    def var vmob-label       as class OLabel.
    def var vmob-space       as class OSpace.
    def var vbtn-salvar      as class OButton.
    def var vbtn-retornar    as class OButton.
    def var vbtn-excluir     as class OButton.
    def var vinput-codigo    as class OText.
    def var vinput-nome      as class OText.
    def var vinput-sigla     as class OText.
    def var vinput-codpais   as class OText.
    def var vinput-pais-nome as class OText.

    find first estado no-lock no-error.
    find first pais no-lock no-error.
    find first cidade no-lock no-error.

    assign TForm  = new TForm().
    assign TLista-cidade = new TListView().
    for each cidade where 
             cidade.est-estado = get-value("siglaestado") no-lock:
        TLista-cidade:addCard("Nome: " + cidade.cid-nome, "Estado: " + cidade.est-estado, "Código: " + string(cidade.cid-cidade), 
        "wmadfg0010mob5?codcidade=" + string(cidade.cid-cidade) + "&nomecidade=" + cidade.cid-nome + "&estadocidade=" + cidade.est-estado).
    end.

    assign vmob-label = new OLabel("Manutenção do Estado + Cidades dele").
    vmob-label:setAlign("center").
    vmob-label:setColor("blue").
    vmob-label:setBold().
    vmob-label:setSize(30).

    assign vinput-codigo    = new OText("ipt-cod","Código",get-value("codestado")).
           vinput-nome      = new OText("ipt-nome","Nome",get-value("nomeestado")).
           vinput-codpais   = new OText("ipt-pais-cod","Código - País",get-value("codpaisestado")).
           vinput-sigla     = new OText("ipt-sigla","Sigla",get-value("siglaestado")).
           vinput-pais-nome = new OText("ipt-pais-nome","País",get-value("ipt-pais-nome")).
           vinput-codigo:setSmall().
           vinput-codigo:setType("int").
           vinput-codigo:setDisabled(?).
           vinput-nome:setSmall().
           vinput-codpais:setSmall().
           vinput-codpais:setType("int").
           vinput-codpais:setZoom("wmadfg009mob5","ipt-pais-cod,ipt-pais-nome").
           vinput-sigla:setSmall().
           vinput-pais-nome:setDisabled(?).

    assign vmob-space = new OSpace(20).
    vmob-space:setHr().

    assign vbtn-salvar   = new OButton("bsalvar-estado","Salvar").
           vbtn-retornar = new OButton("bretornar", "Retornar").
           vbtn-excluir  = new OButton("bexcluir-estado", "Excluir").
           vbtn-salvar:setColor("green").
           vbtn-retornar:setColor("blue").
           vbtn-excluir:setColor("red").
           vbtn-retornar:setLink("wmadfg002mob5").


    TForm:addObject(vmob-label).
    TForm:addObject(vmob-space).
    TForm:addObject(vinput-codigo).
    TForm:addObject(vinput-nome).
    TForm:addObject(vinput-codpais).
    TForm:addObject(vinput-sigla).
    TForm:addObject(vinput-pais-nome).
    TForm:addObject(vbtn-salvar).
    TForm:addObject(vbtn-excluir).
    TForm:addObject(vbtn-retornar).


    vpad-mobile:add(TForm).
    vpad-mobile:add(TLista-cidade).
end procedure.

procedure p_excluir:

    find estado where string(estado.est-cod) = get-value("ipt-cod") exclusive-lock no-error.
    if avail estado
    then delete estado.

    flocation("","wmadfg002mob5","").
end procedure.

procedure p_salvar:

    find estado where string(estado.est-cod) = get-value("ipt-cod") exclusive-lock no-error.
    
    if get-value("ipt-nome") = ""
    then do: 
        vpad-mobile:setMessage("warning","Informe o nome do estado").
    end.

    if get-value("ipt-pais-cod") = ""
    then do: 
        vpad-mobile:setMessage("warning","Informe o código do país").
    end.

    if get-value("ipt-sigla") = ""
    then do: 
        vpad-mobile:setMessage("warning","Informe a sigla do estado").
    end.

    else do:
        assign estado.est-nome   = get-value("ipt-nome")
               estado.pai-pais   = int(get-value("ipt-pais-cod"))
               estado.est-estado = get-value("ipt-sigla").

        flocation("","wmadfg002mob5","").
    end.
end procedure.