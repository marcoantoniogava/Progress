{webpro.i}
{wpadfunc.i}
{wpadmob.i}

//zoom - países

def var TForm as class TForm.
def var TLista-pais as class TListView.

procedure p_load:

    def var vmob-label as class OLabel.
    def var vmob-space as class OSpace.

    find first pais no-lock no-error.

    assign TForm  = new TForm().
    assign TLista-pais = new TListView().
    for each pais no-lock:
        TLista-pais:addCard("Nome: " + pais.pai-nome, "Código: " + string(pais.pai-pais), ""):setZoom(get-value("vcampo"),
                       string(pais.pai-pais) + "," + pais.pai-nome).
    end.

    assign vmob-label = new OLabel("Zoom - Países").
    vmob-label:setAlign("center").
    vmob-label:setColor("blue").
    vmob-label:setBold().
    vmob-label:setSize(30).

    assign vmob-space = new OSpace(20).
    vmob-space:setHr().

    TForm:addObject(vmob-label).
    TForm:addObject(vmob-space).

    vpad-mobile:add(TForm).
    vpad-mobile:add(TLista-pais).
end procedure.