{webpro.i}
{wpadfunc.i}
{wpadmob.i}

//inserir pais

def var TForm as class TForm.

procedure p_botao_action:
    frunprog("binserir-pais","p_criareg","").
end procedure.

procedure p_load:

    def var vmob-label    as class OLabel.
    def var vinput-nome   as class OText.
    def var vmob-space    as class OSpace.
    def var vbtn-inserir-pais as class OButton.
    def var vbtn-retornar as class OButton.

    assign TForm  = new TForm().

    assign vmob-label = new OLabel("Inserir País").
    vmob-label:setAlign("center").
    vmob-label:setColor("blue").
    vmob-label:setBold().
    vmob-label:setSize(30).

    assign vinput-nome   = new OText("ipt-nome","Nome",get-value("ipt-nome")).

    assign vmob-space = new OSpace(20).
    vmob-space:setHr().

    assign vbtn-inserir-pais = new OButton("binserir-pais","Inserir").
           vbtn-retornar     = new OButton("bretornar", "Retornar").
           vbtn-inserir-pais:setColor("green").
           vbtn-retornar:setColor("red").
           vbtn-retornar:setLink("wmadfg002mob5").


    TForm:addObject(vmob-label).
    TForm:addObject(vmob-space).
    TForm:addObject(vinput-nome).
    TForm:addObject(vbtn-inserir-pais).
    TForm:addObject(vbtn-retornar).


    vpad-mobile:add(TForm).
end procedure.

procedure p_criareg:

    if get-value("ipt-nome") = ""
    then do: 
        vpad-mobile:setMessage("warning","Informe o nome do país").
    end.
    
    else do:
        def var vcodigo as int init 1. 

        find last pais no-lock no-error.
        if avail pais 
        then assign vcodigo = pais.pai-pais + 1.

        create pais. 
        assign pais.pai-pais = vcodigo
               pais.pai-nome = get-value("ipt-nome").
    
        flocation("","wmadfg002mob5","").
    end.
end procedure.