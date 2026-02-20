{webpro.i}
{wpadma05.i}

def var vhidden as log.


function festado returns char() forwards.


procedure output-header: //adicionar variaveis globais via flista
    flista("add","vpai-pais-global",get-value("vpai-pais")).
    flista("add","vpad-modo",get-value("vmodo")).
end procedure.


procedure p_setvalue:

    find cidade where rowid(cidade) = to-rowid(get-value("vpad-radio")) no-lock no-error.
end procedure.


procedure p_setparams:

    assign vpad-titulo = if get-value("vpad-modo") = "MAN" then "Manutenção" else "Inclusão"
           vpad-numcol = 2
           vpad-progco = "wmadfg006c2"
           vpad-btret  = ""
           vpad-btsal  = if get-value("vpad-modo") = "MAN" and not avail cidade then "false" else "true"
           vpad-btinc  = "" 
           vpad-btexc  = if get-value("vpad-modo") = "MAN" and avail cidade then "true" else "false".
end procedure.


procedure p_setinitial:

    assign vhidden = logical(get-value("vhidden-initial") <> "vhidden-initial").

    {&out}
        fbranco(2,vpad-numcol)
        flabel("Cidade:","right",0,yes,no,42,yes,yes)
        fpad-text("vcid-nome",20,100,if vhidden
                                     then "" 
                                     else get-value("vcid-nome"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        flabel("País:","right",0,yes,no,42,yes,yes)
        fpad-text("vpai-pais",20,100,if vhidden
                                     then "" 
                                     else get-value("vpai-pais"),"C",no,"left",0,no,no,0,yes,no,"document.forms[0].submit();","")
        fzoom("wmadfg0062z2","vpai-pais,vpais-nome",no,no)
        fpad-text("vpais-nome",20,100,if vhidden
                                     then "" 
                                     else get-value("vpais-nome"),"C",no,"left",0,no,no,0,yes,no,"","")
        flabel("Estado:","right",0,yes,no,42,yes,yes)
        fpad-text("vestado",20,100,if vhidden
                                     then "" 
                                     else get-value("vestado"),"C",no,"left",0,no,no,0,yes,no,"","")
        fzoom("wmadfg0063z2","vestado,vestado-nome",no,no)
        fpad-text("vestado-nome",20,100,if vhidden
                                     then "" 
                                     else get-value("vestado-nome"),"C",no,"left",0,no,no,0,yes,no,"","")
    .

    fhidden("vhidden-initial","vhidden-initial").
end procedure.


procedure p_mostra:

    def var vpais-nome-aux as char.
    def var vestado-nome-aux as char.

    assign vhidden = logical(get-value("vhidden-mostra") <> "vhidden-mostra").

    if avail cidade
    then do:

        find pais where pais.pai-pais = int(get-value("vpai-pais")) no-lock no-error. //procura o pais da tabela cidade, na tabela pais
        if avail pais //se encontrar
        then assign vpais-nome-aux = pais.pai-nome. //a variavel auxiliar vira o nome desse pais

        //mesma coisa pro estado
        find estado where estado.est-estado = cidade.est-estado no-lock no-error.
        if avail estado
        then assign vestado-nome-aux = estado.est-nome.

        {&out}
            fbranco(2,vpad-numcol)
            flabel("Cidade:","right",0,yes,no,42,yes,yes)
            fpad-text("vcid-nome",20,100,cidade.cid-nome,"C",no,"left",0,no,yes,0,yes,yes,"","")
            flabel("País:","right",0,yes,no,42,yes,yes)
            fpad-text("vpai-pais",20,100,(if vhidden  //vhidden: se for a primeira vez acessando a tela
                                          then string(cidade.pai-pais) //usa o pais.pai-pais
                                          else get-value("vpai-pais")),"C",no,"left",0,no,no,0,yes,no,"document.forms[0].submit();","") //se nao usa vpai-pais
            fzoom("wmadfg0062z2","vpai-pais,vpais-nome",no,no)
            fpad-text("vpais-nome",20,100,(if vhidden 
                                           then string(vpais-nome-aux)
                                           else get-value("vpais-nome")),"C",no,"left",0,no,no,0,yes,no,"","") //exibe tbm o nome, que veio da variavel auxiliar
            flabel("Estado:","right",0,yes,no,42,yes,yes)
            fpad-text("vestado",20,100,cidade.est-estado,"C",no,"left",0,no,no,0,yes,no,"","")
            fzoom("wmadfg0063z2","vestado,vestado-nome",no,no)
            fpad-text("vestado-nome",20,100,vestado-nome-aux,"C",no,"left",0,no,no,0,yes,no,"","") //aq tbm
        .
        fhidden("vhidden-mostra","vhidden-mostra").
    end.
end procedure.


procedure p_criareg:

    def var vcodigo as int init 1. 

    find last cidade no-lock no-error.
    if avail cidade 
    then assign vcodigo = cidade.cid-cidade + 1.

    create cidade. 
    assign cidade.cid-cidade = vcodigo.
end procedure.


procedure p_grava:

    if get-value("vpad-modo") = "MAN"
    then do:
        find cidade where rowid(cidade) = to-rowid(get-value("vpad-radio")) exclusive-lock no-error.
    end.

    if get-value("vcid-nome") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o nome da cidade'"}
    end.

    if get-value("vpai-pais") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o país'"}
    end.

    if get-value("vestado") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o estado'"}
    end.

    assign cidade.cid-nome   = get-value("vcid-nome")
           cidade.pai-pais   = int(get-value("vpai-pais"))
           cidade.est-estado = get-value("vestado").

    assign vpad-rowid = rowid(cidade).

    fatubr("wmadfg006c2",string(vpad-rowid)).
end procedure.


procedure p_excluir:

    find cidade where rowid(cidade) = to-rowid(get-value("vpad-radio")) exclusive-lock no-error.
    if avail cidade
    then delete cidade.

    fatubr("wmadfg006c2","").
end procedure.


function festado returns char(): 

    def var vselect as char.

    for each estado no-lock
          by estado.est-nome:
        assign vselect = vselect + estado.est-estado + "," + estado.est-nome + ",".
    end. 

    return vselect.
end function.