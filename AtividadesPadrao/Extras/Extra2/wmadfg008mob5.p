{webpro.i}
{wpadfunc.i}
{wpadmob.i}

//inserir cidade

def var TForm as class TForm.

procedure p_botao_action:
    frunprog("binserir-cidade","p_criareg","").
end procedure.

procedure p_load:

    def var vmob-label          as class OLabel.
    def var vinput-nome         as class OText.
    def var vinput-est-estado   as class OText.
    def var vinput-est-nome     as class OText.
    def var vmob-space          as class OSpace.
    def var vbtn-inserir-estado as class OButton.
    def var vbtn-retornar       as class OButton.

    find first estado no-lock no-error.

    assign TForm  = new TForm().

    assign vmob-label = new OLabel("Inserir Cidade").
    vmob-label:setAlign("center").
    vmob-label:setColor("blue").
    vmob-label:setBold().
    vmob-label:setSize(30).

    assign vinput-nome      = new OText("ipt-nome","Nome",get-value("ipt-nome")).
           vinput-est-estado  = new OText("ipt-est-estado","Sigla - Estado",get-value("ipt-est-estado")).
           vinput-est-nome = new OText("ipt-est-nome","Nome - Estado",get-value("ipt-est-nome")).
           vinput-est-estado:setSmall().
           vinput-est-estado:setZoom("wmadfg009mob5","ipt-est-estado,ipt-est-nome").
           vinput-est-estado:setSubmit().
           vinput-est-nome:setSmall().
           vinput-est-nome:setDisabled(?).

    assign vmob-space = new OSpace(20).
    vmob-space:setHr().

    assign vbtn-inserir-estado = new OButton("binserir-cidade","Inserir").
           vbtn-retornar       = new OButton("bretornar", "Retornar").
           vbtn-inserir-estado:setColor("green").
           vbtn-retornar:setColor("blue").
           vbtn-retornar:setLink("wmadfg002mob5").


    TForm:addObject(vmob-label).
    TForm:addObject(vmob-space).
    TForm:addObject(vinput-est-estado).
    TForm:addObject(vinput-est-nome).
    TForm:addObject(vinput-nome).
    TForm:addObject(vbtn-inserir-estado).
    TForm:addObject(vbtn-retornar).


    vpad-mobile:add(TForm).
end procedure.

procedure p_criareg:

    if get-value("ipt-est-estado") = ""
    then do:
        vpad-mobile:setMessage("warning","Informe o estado da cidade").
    end.

    if get-value("ipt-nome") = ""
    then do:
        vpad-mobile:setMessage("warning","Informe o nome da cidade").
    end.

    else do:
        def var vcodigo as int init 1. 

        find last cidade no-lock no-error.
        if avail cidade 
        then assign vcodigo = cidade.cid-cidade + 1.

        create cidade. 
        assign cidade.cid-cidade = vcodigo
               cidade.est-estado = get-value("ipt-est-estado")
               cidade.cid-nome = get-value("ipt-nome").
    
        flocation("","wmadfg002mob5","").
    end.
end procedure.