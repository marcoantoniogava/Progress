{webpro.i}
{wpadfunc.i}
{wpadmob.i}

//zoom - estados

def var TForm as class TForm.
def var TLista-estado as class TListView.

procedure p_load:

    def var vmob-label as class OLabel.
    def var vmob-space as class OSpace.

    find first estado no-lock no-error.

    assign TForm  = new TForm().
    assign TLista-estado = new TListView().
    for each estado no-lock:
        TLista-estado:addCard("Sigla: " + estado.est-estado, "Nome: " + estado.est-nome, ""):setZoom(get-value("vcampo"),
                       estado.est-estado + "," + estado.est-nome).
    end.

    assign vmob-label = new OLabel("Zoom - Estados").
    vmob-label:setAlign("center").
    vmob-label:setColor("blue").
    vmob-label:setBold().
    vmob-label:setSize(30).

    assign vmob-space = new OSpace(20).
    vmob-space:setHr().

    TForm:addObject(vmob-label).
    TForm:addObject(vmob-space).

    vpad-mobile:add(TForm).
    vpad-mobile:add(TLista-estado).
end procedure.