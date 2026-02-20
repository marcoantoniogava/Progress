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
           vpad-progco = "wmadfg006c3"
           vpad-btret  = ""
           vpad-btsal  = if get-value("vpad-modo") = "MAN" and not avail clifor then "false" else "true"
           vpad-btinc  = ""
           vpad-btexc  = if get-value("vpad-modo") = "MAN" and avail clifor then "true" else "false".
end procedure.

procedure p_insere_botao:

    def output parameter vadd-botao as char.
    assign vadd-botao = fbotao_frame("Voltar","btn-voltar","Voltar","wmadfg006c3","window").
end procedure.

procedure p_setinitial:

    assign vhidden = logical(get-value("vhidden-initial") <> "vhidden-initial").

    {&out} 
        flabel(fbotao_aba("Campos de Localização","bloc","Campos de Localização",1) +
        fbotao_aba("Campos de Cadastro","bcad","Campos de Cadastro",2),"right",0,no,no,0,no,no)
    .

    {&out}
        fpad-abaini(1)
        
        fbranco(2,vpad-numcol)
        flabel("Descrição do Bairro:","right",0,yes,no,38,yes,yes)
        fpad-text("vcli-bairro",20,100,if vhidden
                                     then "" 
                                     else get-value("vcli-bairro"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        flabel("Endereço:","right",0,yes,no,0,yes,yes)
        fpad-text("vcli-endere",20,100,if vhidden
                                     then "" 
                                     else get-value("vcli-endere"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        flabel("Inscrição Municipal:","right",0,yes,no,0,yes,yes)
        fpad-text("vcli-inscmuni",20,100,if vhidden
                                     then "" 
                                     else get-value("vcli-inscmuni"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        flabel("Ponto de Referência:","right",0,yes,no,0,yes,yes)
        fpad-text("vcli-ptref",20,100,if vhidden
                                     then "" 
                                     else get-value("vcli-ptref"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        flabel("Logradouro:","right",0,yes,no,0,yes,yes)
        fpad-text("vlgr-codigo",20,100,if vhidden
                                     then "" 
                                     else get-value("vlgr-codigo"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        flabel("Localização Global:","right",0,yes,no,0,yes,yes)
        fpad-text("vloc-global",20,100,if vhidden
                                     then "" 
                                     else get-value("vloc-global"),"C",no,"left",0,no,no,0,yes,yes,"","")
        fpad-text("vloc-global2",20,100,if vhidden
                                     then "" 
                                     else get-value("vloc-global2"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        
        fpad-abafim()
    .

    {&out}
        fpad-abaini(2)

        fbranco(2,vpad-numcol)
        flabel("Nome:","right",0,yes,no,38,yes,yes)
        fpad-text("vemp-nome",20,100,if vhidden
                                     then "" 
                                     else get-value("vemp-nome"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        flabel("Telefone:","right",0,yes,no,38,yes,yes)
        fpad-text("vemp-fone",20,100,if vhidden
                                     then "" 
                                     else get-value("vemp-fone"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        flabel("Código do Banco:","right",0,yes,no,38,yes,yes)
        fpad-text("vban-cod",20,100,if vhidden
                                     then "" 
                                     else get-value("vban-cod"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        /* flabel("Apelido:","right",0,yes,no,38,yes,yes)
        fpad-text("vcli-apelido",20,100,if vhidden
                                     then "" 
                                     else get-value("vcli-apelido"),"C",no,"left",0,no,yes,0,yes,yes,"","") */
        flabel("CNPJ:","right",0,yes,no,38,yes,yes)
        fpad-text("vcli-cgc",20,100,if vhidden
                                     then "" 
                                     else get-value("cli-cgc"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        /* flabel("Estabelecimento:","right",0,yes,no,38,yes,yes)
        fpad-text("vcli-codestab",20,100,if vhidden
                                     then "" 
                                     else get-value("vcli-codestab"),"C",no,"left",0,no,yes,0,yes,yes,"","") */
        flabel("Código Fax:","right",0,yes,no,38,yes,yes)
        fpad-text("vcli-codfax",20,100,if vhidden
                                     then "" 
                                     else get-value("vcli-codfax"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        flabel("Caixa Postal:","right",0,yes,no,38,yes,yes)
        fpad-text("vcli-cxpost",20,100,if vhidden
                                     then "" 
                                     else get-value("vcli-cxpost"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        flabel("E-mail:","right",0,yes,no,38,yes,yes)
        fpad-text("vcli-email",20,100,if vhidden
                                     then "" 
                                     else get-value("vcli-email"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        flabel("E-mail Fiscal:","right",0,yes,no,38,yes,yes)
        fpad-text("vcli-mailfisc",20,100,if vhidden
                                     then "" 
                                     else get-value("vcli-mailfisc"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        /* flabel("Observação:","right",0,yes,no,38,yes,yes)
        fpad-text("vcli-obsdocum",20,100,if vhidden
                                     then "" 
                                     else get-value("vcli-obsdocum"),"C",no,"left",0,no,yes,0,yes,yes,"","") */
        
        fpad-abafim()
    .

    fhidden("vhidden-initial","vhidden-initial").
end procedure.

procedure p_mostra:

    if avail clifor
    then do:

        {&out} 
            flabel(fbotao_aba("Campos de Localização","bloc","Campos de Localização",1) +
            fbotao_aba("Campos de Cadastro","bcad","Campos de Cadastro",2),"right",0,no,no,0,no,no)
        .

        {&out}
            fpad-abaini(1)

            fbranco(2,vpad-numcol)
            flabel("Descrição do Bairro:","right",0,yes,no,38,yes,yes)
            fpad-text("vcli-bairro",20,100,clifor.cli-bairro,"C",no,"left",0,no,yes,0,yes,yes,"","")

            flabel("Endereço:","right",0,yes,no,0,yes,yes)
            fpad-text("vcli-endere",20,100,clifor.cli-endere,"C",no,"left",0,no,yes,0,yes,yes,"","")

            flabel("Inscrição Municipal:","right",0,yes,no,38,yes,yes)
            fpad-text("vcli-inscmuni",20,100,clifor.cli-inscmuni,"C",no,"left",0,no,yes,0,yes,yes,"","")

            flabel("Ponto de Referência:","right",0,yes,no,38,yes,yes)
            fpad-text("vcli-ptref",20,100,clifor.cli-ptref,"C",no,"left",0,no,yes,0,yes,yes,"","")

            flabel("Logradouro:","right",0,yes,no,38,yes,yes)
            fpad-text("vlgr-codigo",20,100,clifor.lgr-codigo,"C",no,"left",0,no,yes,0,yes,yes,"","")

            flabel("Localização Global:","right",0,yes,no,38,yes,yes)
            fpad-text("vloc-global",20,100,clifor.loc-global[1],"C",no,"left",0,no,no,0,yes,yes,"","")
            fpad-text("vloc-global2",20,100,clifor.loc-global[2],"C",no,"left",0,no,yes,0,yes,yes,"","")

            fpad-abafim()
        .

        {&out}
        fpad-abaini(2)

        fbranco(2,vpad-numcol)
        flabel("Nome:","right",0,yes,no,38,yes,yes)
        fpad-text("vemp-nome",20,100,string(clifor.cli-fantasi),"C",no,"left",0,no,yes,0,yes,yes,"","")

        flabel("Telefone:","right",0,yes,no,38,yes,yes)
        fpad-text("vemp-fone",20,100,string(clifor.cli-fone1),"C",no,"left",0,no,yes,0,yes,yes,"","")

        flabel("Código do Banco:","right",0,yes,no,38,yes,yes)
        fpad-text("vban-cod",20,100,string(clifor.ban-cod),"C",no,"left",0,no,yes,0,yes,yes,"","")

        /* flabel("Apelido:","right",0,yes,no,38,yes,yes)
        fpad-text("vcli-apelido",20,100,clifor.cli-apelido,"C",no,"left",0,no,yes,0,yes,yes,"","") */

        flabel("CNPJ:","right",0,yes,no,38,yes,yes)
        fpad-text("vcli-cgc",20,100,clifor.cli-cgc,"C",no,"left",0,no,yes,0,yes,yes,"","")

        /* flabel("Estabelecimento:","right",0,yes,no,38,yes,yes)
        fpad-text("vcli-codestab",20,100,clifor.cli-codestab,"C",no,"left",0,no,yes,0,yes,yes,"","") */

        flabel("Código Fax:","right",0,yes,no,38,yes,yes)
        fpad-text("vcli-codfax",20,100,clifor.cli-codfax,"C",no,"left",0,no,yes,0,yes,yes,"","")

        flabel("Caixa Postal:","right",0,yes,no,38,yes,yes)
        fpad-text("vcli-cxpost",20,100,clifor.cli-cxpost,"C",no,"left",0,no,yes,0,yes,yes,"","")

        flabel("E-mail:","right",0,yes,no,38,yes,yes)
        fpad-text("vcli-email",20,100,clifor.cli-email,"C",no,"left",0,no,yes,0,yes,yes,"","")

        flabel("E-mail Fiscal:","right",0,yes,no,38,yes,yes)
        fpad-text("vcli-mailfisc",20,100,clifor.cli-mailfisc,"C",no,"left",0,no,yes,0,yes,yes,"","")

        /* flabel("Observação:","right",0,yes,no,38,yes,yes)
        fpad-text("vcli-obsdocum",20,100,clifor.cli-obsdocum,"C",no,"left",0,no,yes,0,yes,yes,"","") */

        fpad-abafim()
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
        {wpaderro.i "erro" "'Informe o nome'"}
    end.
    
    if get-value("vemp-fone") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o telefone'"}
    end.
    
    if get-value("vcli-bairro") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o bairro'"}
    end.
    
    if get-value("vcli-endere") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o endereço'"}
    end.
    
    if get-value("vcli-inscmuni") = ""
    then do: 
        {wpaderro.i "erro" "'Informe a inscrição municipal'"}
    end.
    
    if get-value("vcli-ptref") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o ponto de referência'"}
    end.

    if get-value("vlgr-codigo") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o logradouro'"}
    end.

    if get-value("vloc-global") = ""
    then do: 
        {wpaderro.i "erro" "'Informe a 1° localização global'"}
    end.

    if get-value("vloc-global2") = ""
    then do: 
        {wpaderro.i "erro" "'Informe a 2° localização global'"}
    end.

    if get-value("vban-cod") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o código do banco'"}
    end.

    /* if get-value("vcli-apelido") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o apelido'"}
    end. */

    if get-value("vcli-cgc") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o CNPJ'"}
    end.

    /* if get-value("vcli-codestab") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o estabelecimento'"}
    end. */

    if get-value("vcli-codfax") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o código fax'"}
    end.

    if get-value("vcli-cxpost") = ""
    then do: 
        {wpaderro.i "erro" "'Informe a caixa postal'"}
    end.

    if get-value("vcli-email") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o e-mail'"}
    end.

    if get-value("vcli-mailfisc") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o e-mail fiscal'"}
    end.

    /* if get-value("vcli-obsdocum") = ""
    then do: 
        {wpaderro.i "erro" "'Informe a observação'"}
    end. */

    assign clifor.cli-fantasi   = get-value("vemp-nome")
           clifor.cli-fone1     = get-value("vemp-fone")
           clifor.cli-bairro    = get-value("vcli-bairro")
           clifor.cli-endere    = get-value("vcli-endere")
           clifor.cli-inscmuni  = get-value("vcli-inscmuni")
           clifor.cli-ptref     = get-value("vcli-ptref")
           clifor.lgr-codigo    = get-value("vlgr-codigo")
           clifor.loc-global[1] = get-value("vloc-global")
           clifor.loc-global[2] = get-value("vloc-global2")
           clifor.ban-cod       = int(get-value("vban-cod"))
           /* clifor.cli-apelido   = get-value("vcli-apelido") */
           clifor.cli-cgc       = get-value("vcli-cgc")
           /* clifor.cli-codestab  = get-value("vcli-codestab") */
           clifor.cli-codfax    = get-value("vcli-codfax")
           clifor.cli-cxpost    = get-value("vcli-cxpost")
           clifor.cli-email     = get-value("vcli-email")
           clifor.cli-mailfisc  = get-value("vcli-mailfisc")
           /* clifor.cli-obsdocum  = get-value("vcli-obsdocum") */
           .

    assign vpad-rowid = rowid(clifor).

    flocation("","wmadfg006c3","vpad-rowid=" + string(vpad-rowid)).
end procedure.

procedure p_excluir:

    find clifor where rowid(clifor) = to-rowid(get-value("vpad-rowid")) exclusive-lock no-error.
    if avail clifor
        then delete clifor.
    fatubr("wmadfg006c3","").
end procedure.