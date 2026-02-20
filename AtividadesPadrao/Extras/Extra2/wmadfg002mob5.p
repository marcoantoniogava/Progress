{webpro.i}
{wpadfunc.i}
{wpadmob.i}

//tela inicial

def var TForm as class TForm.
def var TLista-pais as class TListView.

procedure p_load:

    def var vmob-label           as class OLabel.
    def var vmob-space           as class OSpace.
    def var vbtn-inserir-pais    as class OButton.
    def var vbtn-inserir-estado  as class OButton.
    def var vbtn-inserir-cidade  as class OButton.

    find first pais no-lock no-error.

    assign TForm  = new TForm().
    assign TLista-pais = new TListView().
    for each pais no-lock:
        TLista-pais:addCard("Nome: " + pais.pai-nome, "Código: " + string(pais.pai-pais), "", 
        "wmadfg004mob5?codpais=" + string(pais.pai-pais) + "&nomepais=" + pais.pai-nome).
    end.

    assign vmob-label = new OLabel("Início").
    vmob-label:setAlign("center").
    vmob-label:setColor("blue").
    vmob-label:setBold().
    vmob-label:setSize(30).

    assign vmob-space = new OSpace(20).
    vmob-space:setHr().

    assign vbtn-inserir-pais   = new OButton("binserir-pais","Inserir País").
           vbtn-inserir-estado = new OButton("binserir-estado", "Inserir Estado").
           vbtn-inserir-cidade = new OButton("binserir-cidade", "Inserir Cidade").
           vbtn-inserir-pais:setColor("blue").
           vbtn-inserir-pais:setLink("wmadfg003mob5").
           vbtn-inserir-estado:setColor("blue").
           vbtn-inserir-estado:setLink("wmadfg005mob5").
           vbtn-inserir-cidade:setColor("blue").
           vbtn-inserir-cidade:setLink("wmadfg008mob5").

    TForm:addObject(vmob-label).
    TForm:addObject(vmob-space).
    TForm:addObject(vbtn-inserir-pais).
    TForm:addObject(vbtn-inserir-estado).
    TForm:addObject(vbtn-inserir-cidade).
    TForm:addObject(vmob-space).

    vpad-mobile:add(TForm).
    vpad-mobile:add(TLista-pais).
end procedure.