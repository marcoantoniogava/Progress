{webpro.i}
{wpadma05.i}

def var vhidden as log.

def buffer bpais for pais.
def buffer bccusto for ccusto.

function fueu returns char() forwards.

procedure output-header:

    flista("add","vpad-modo",get-value("vmodo")).
end procedure.

procedure p_setparams:

    assign vpad-titulo = if get-value("vpad-modo") = "MAN" then "Manutenção" else "Inclusão"
           vpad-numcol = 2
           vpad-progco = "wmadfg005c2"
           vpad-btret  = ""
           vpad-btsal  = if get-value("vpad-modo") = "MAN" and not avail pais then "false" else "true"
           vpad-btinc  = "" 
           vpad-btexc  = if get-value("vpad-modo") = "MAN" and avail pais then "true" else "false".
end procedure.

procedure p_setinitial:

    assign vhidden = logical(get-value("vhidden-initial") <> "vhidden-initial").

    {&out}
        fbranco(2,vpad-numcol)
        flabel("Nome:","right",0,yes,no,42,yes,yes)
        fpad-text("vpais-nome",20,100,if vhidden
                                      then "" 
                                     else get-value("vpais-nome"),"C",no,"left",0,no,yes,0,yes,yes,"","")
        flabel("União Europeia:","right",0,yes,no,0,yes,yes)
        fselect("vpais-ueu",fueu(),if vhidden
                                             then ""
                                             else get-value("vpais-ueu"),1,no,no,"left",0,no,yes,0,yes,yes,"")
        flabel("Centro de Custo:","right",0,yes,no,0,yes,yes)
        fpad-text("vpais-ccu",10,10,get-value("vpais-ccu"),"C",no,"left",0,no,no,0,yes,no,"document.forms[0].submit();","")
        fzoom("wmadfg005z2","vpais-ccu",no,no)
    .

    fhidden("vhidden-initial","vhidden-initial").
end procedure.

procedure p_mostra:
end procedure.

procedure p_criareg:

    def var vcodigo as int init 1. 

    find last pais no-lock no-error.
    if avail pais 
    then assign vcodigo = pais.pai-pais + 1.

    create pais. 
    assign pais.pai-pais = vcodigo.
end procedure.

procedure p_grava:

    if get-value("vpad-modo") = "MAN"
    then do:
        find pais where rowid(pais) = to-rowid(get-value("vpad-radio")) exclusive-lock no-error.

        if not avail pais then do:
            {wpaderro.i "erro" "'Registro pais não encontrado'"}
            return.
        end.
    end.

    if get-value("vpais-nome") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o nome do país'"}
    end.
    
    if get-value("vpais-ueu") = ""
    then do: 
        {wpaderro.i "erro" "'Informe se o país faz parte da união europeia'"}
    end.

    if get-value("vpais-ccu") = ""
    then do: 
        {wpaderro.i "erro" "'Informe o centro de custo do país'"}
    end.

    find first bpais
     where bpais.pai-nome = get-value("vpais-nome")
       and rowid(bpais) <> to-rowid(get-value("vpad-radio"))
     no-lock no-error.

    if avail bpais then do:
        {wpaderro.i "erro" "'Já existe um país com esse nome'"}
        return.
    end.

    find first bccusto
     where bccusto.ccu-ccusto = int(get-value("vpais-ccu"))
     no-lock no-error.

    if not avail bccusto then do:
        {wpaderro.i "erro" "'Esse centro de custo não existe'"}
        return.
    end.

    assign pais.pai-nome   = get-value("vpais-nome")
           pais.uniao-europeia = (get-value("vpais-ueu") = "yes") //se for yes -> true, salva como Sim no banco, se n salva como Nao
           pais.ccu-ccusto = int(get-value("vpais-ccu")).

    fatubr("wmadfg005c2","").
end procedure.

function fueu returns char(): 

    def var vselect as char.
    
    assign vselect = "yes,Sim,no,Nao". 

    return vselect.
end function.