{webpro.i}
{wpadfunc.i}
{wpadmob.i}

//inserir estado

def var TForm as class TForm.

procedure p_botao_action:
    frunprog("binserir-estado","p_criareg","").
end procedure.

procedure p_load:

    def var vmob-label          as class OLabel.
    def var vinput-sigla        as class OText.
    def var vinput-nome         as class OText.
    def var vinput-pais-cod     as class OText.
    def var vinput-pais-nome    as class OText.
    def var vmob-space          as class OSpace.
    def var vbtn-inserir-estado as class OButton.
    def var vbtn-retornar       as class OButton.

    find first estado no-lock no-error.

    assign TForm  = new TForm().

    assign vmob-label = new OLabel("Inserir Estado").
    vmob-label:setAlign("center").
    vmob-label:setColor("blue").
    vmob-label:setBold().
    vmob-label:setSize(30).

    assign vinput-sigla     = new OText("ipt-sigla","Sigla",get-value("ipt-sigla")).
           vinput-nome      = new OText("ipt-nome","Nome",get-value("ipt-nome")).
           vinput-pais-cod  = new OText("ipt-pais-cod","Código - País",get-value("ipt-pais-cod")).
           vinput-pais-nome = new OText("ipt-pais-nome","Nome - País",get-value("ipt-pais-nome")).
           vinput-sigla:setSmall().
           vinput-nome:setSmall().
           vinput-pais-cod:setSmall().
           vinput-pais-cod:setType("int").
           vinput-pais-cod:setZoom("wmadfg006mob5","ipt-pais-cod,ipt-pais-nome").
           vinput-pais-cod:setSubmit().
           vinput-pais-nome:setSmall().
           vinput-pais-nome:setDisabled(?).

    assign vmob-space = new OSpace(20).
    vmob-space:setHr().

    assign vbtn-inserir-estado = new OButton("binserir-estado","Inserir").
           vbtn-retornar       = new OButton("bretornar", "Retornar").
           vbtn-inserir-estado:setColor("green").
           vbtn-retornar:setColor("blue").
           vbtn-retornar:setLink("wmadfg002mob5").


    TForm:addObject(vmob-label).
    TForm:addObject(vmob-space).
    TForm:addObject(vinput-pais-cod).
    TForm:addObject(vinput-pais-nome).
    TForm:addObject(vinput-sigla).
    TForm:addObject(vinput-nome).
    TForm:addObject(vbtn-inserir-estado).
    TForm:addObject(vbtn-retornar).


    vpad-mobile:add(TForm).
end procedure.

procedure p_criareg:

    if get-value("ipt-sigla") = ""
    then do: 
        vpad-mobile:setMessage("warning","Informe a sigla do estado").
    end.

    if get-value("ipt-nome") = ""
    then do: 
        vpad-mobile:setMessage("warning","Informe o nome do estado").
    end.

    if get-value("ipt-pais-cod") = ""
    then do: 
        vpad-mobile:setMessage("warning","Informe o país").
    end.

    else do:
        def var vcodigo as int init 1. 

        find last estado no-lock no-error.
        if avail estado 
        then assign vcodigo = estado.est-cod + 1.

        create estado. 
        assign estado.est-cod = vcodigo
               estado.est-estado = get-value("ipt-sigla")
            estado.est-nome = get-value("ipt-nome")
            estado.pai-pais = int(get-value("ipt-pais-cod")).
    
        flocation("","wmadfg002mob5","").
    end.
end procedure.