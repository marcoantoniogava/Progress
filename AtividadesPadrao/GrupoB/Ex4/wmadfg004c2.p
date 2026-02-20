{webpro.i}
{wpadfunc.i}

procedure output-header:
end procedure.

&scoped-define vpad-tabela pais
def query q1 for pais scrolling.

{wpadco03.i}

procedure p_setvalue:
end procedure.

procedure p_setparams:
    assign vpad-titulo  = "Países"
           vpad-modo    = "CON"
           vpad-ordena  = ""
           vpad-pesq    = false
           vpad-btnaveg = true
           vpad-numlin  = 30
           vpad-numcol  = 10
           vpad-btret   = ""
           vpad-btinc   = ""
           vpad-btexc   = "".
end procedure.

procedure p_insere_botao:
    def output parameter vadd-botao as char.
    assign vadd-botao = fbotao_input("btnsalvar","grava","Salvar","wmadfg004c2").
end procedure.

procedure p_botao_action:
    frunprog("grava","p_salvar","").
end procedure.

procedure p_abrequery:
    open query q1 for each pais no-lock indexed-reposition.
end procedure.

procedure p_browse:
    finicio(vpad-cor,string(rowid(pais))).
    fcaixa("C",string(pais.pai-pais),"C","Código","",0,0).
    fcaixa("C",pais.pai-nome,"C","Nome","",0,0).
    fcaixa("C",fpad-check("vcheckpais" + string(pais.pai-pais),"yes",pais.uniao-europeia,no,"left",0,no,no,0,no,no,"",""),"C","União Europeia","",0,0).
    final(no,100,"").
    fhidden("vhidden-pais" + string(pais.pai-pais),string(rowid(pais))).
end procedure.

procedure p_salvar:

    def var vcont as int.
    def var vcod  as int.
    def var vval  as char.

    //percorre todos os checkbox
    do vcont = 1 to flista-num("PAR","vhidden-pais"):

        assign vcod = int(flista-val("PAR", vcont, "vhidden-pais", "R")). //pega o radical (codigo do país)
        assign vval = get-value("vcheckpais" + string(vcod)).
        
        find pais where pais.pai-pais = vcod //pega o pais que tem o codigo = ao do vhidden
        exclusive-lock no-error.

        if avail pais then //se achou o pais,
            assign pais.uniao-europeia = (vval = "yes").
    end. //se n achar o pais, vira (no)

end procedure.