{webpro.i}
{wpadma05.i}

def var vhidden as log.


procedure output-header:

    flista("add","vpad-modo",if get-value("vmodo-param") = "" then "MAN" else get-value("vmodo-param")).
end procedure.

procedure p_setvalue:

    if get-value("vpad-rowid") <> "" then
        find clifor where rowid(clifor) = to-rowid(get-value("vpad-rowid")) no-lock no-error.
end procedure.

procedure p_setparams:

    assign vpad-titulo = if get-value("vpad-modo") = "MAN" then "Manutenção" else "Inclusão"
           vpad-numcol = 2
           vpad-progco = "wmadfg004c3"
           vpad-btret  = ""
           vpad-btsal  = if get-value("vpad-modo") = "MAN" and not avail clifor then "false" else "true"
           vpad-btinc  = ""
           vpad-btexc  = if get-value("vpad-modo") = "MAN" and avail clifor then "true" else "false".
end procedure.

procedure p_insere_botao:

    def output parameter vadd-botao as char.
    assign vadd-botao = fbotao_frame("Voltar","btn-voltar","Voltar","wmadfg004c3","window").
end procedure.

procedure p_setinitial:

    assign vhidden = logical(get-value("vhidden-initial") <> "vhidden-initial").

    {&out}
        fbranco(2,vpad-numcol)
        flabel("Nome:","right",0,yes,no,38,yes,yes)
        fpad-text("vemp-nome",20,100,if vhidden
                                     then "" 
                                     else get-value("vemp-nome"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        flabel("Telefone:","right",0,yes,no,0,yes,yes)
        fpad-text("vemp-fone",20,100,if vhidden
                                     then "" 
                                     else get-value("vemp-fone"),"C",no,"left",0,no,yes,0,yes,yes,"","")
    .

    fhidden("vhidden-initial","vhidden-initial").
end procedure.

procedure p_mostra:

    if avail clifor
    then do:

        {&out}
            fbranco(2,vpad-numcol)
            flabel("Nome:","right",0,yes,no,38,yes,yes)
            fpad-text("vemp-nome",20,100,clifor.cli-fantasi,"C",no,"left",0,no,yes,0,yes,yes,"","")
            flabel("Telefone:","right",0,yes,no,0,yes,yes)
            fpad-text("vemp-fone",20,100,string(clifor.cli-fone1),"C",no,"left",0,no,yes,0,yes,yes,"","")
        .
    end.
end procedure.

procedure p_criareg:

    def var vcodigo as int init 1.

    find last clifor no-lock no-error.
    if avail clifor
    then assign vcodigo = clifor.cli-codigo + 1.

    create clifor.
    assign clifor.cli-codigo = vcodigo.
end procedure.

procedure p_grava:

    if get-value("vpad-modo") = "MAN"
    then do:
        find clifor where rowid(clifor) = to-rowid(get-value("vpad-rowid")) exclusive-lock no-error.
    end.

    if get-value("vemp-nome") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o nome da empresa'"}
    end.

    assign clifor.cli-fantasi   = get-value("vemp-nome")
           clifor.cli-fone1 = get-value("vemp-fone").

    assign vpad-rowid = rowid(clifor).

    flocation("","wmadfg004c3","vpad-rowid=" + string(vpad-rowid)).
end procedure.

procedure p_excluir:

    find clifor where rowid(clifor) = to-rowid(get-value("vpad-rowid")) exclusive-lock no-error.
    if avail clifor
        then delete clifor.
    fatubr("wmadfg004c3","").
end procedure.