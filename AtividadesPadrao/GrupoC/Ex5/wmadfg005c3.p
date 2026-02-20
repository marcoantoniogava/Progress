{webpro.i}
{wpadfunc.i}

function festado returns char() forwards.
function fpais returns char() forwards.

procedure output-header:
end procedure.

&scoped-define vpad-tabela cidade
def query q1 for cidade, estado, pais scrolling.

{wpadco03.i}

procedure p_setvalue:
end procedure.

procedure p_setparams:
    assign vpad-titulo  = "Cidades"
           vpad-modo    = "CON"
           vpad-ordena  = ""
           vpad-pesq    = false
           vpad-btnaveg = true
           vpad-numlin  = 30
           vpad-numcol  = 10
           vpad-btret   = ""
           vpad-btinc   = ""
           vpad-btexc   = "true".
end procedure.

procedure p_insere_botao:
    def output parameter vadd-botao as char.
    assign vadd-botao = fbotao_input("btnsalvar","grava","Salvar","").
end procedure.

procedure p_botao_action:
    frunprog("grava","p_salvar","").
end procedure.

procedure p_abrequery:
    open query q1 for each cidade no-lock,
                     first estado of cidade no-lock, /* //relaciona as cidades com seus estados */
                     first pais   of cidade no-lock /* //relaciona estados com seus paises */
                        by cidade.cid-nome indexed-reposition. /* //ordena pelo nome do pais */
end procedure.

procedure p_browse:
    finicio(vpad-cor,"").
    fcaixa("C",fpad-check("vcheckexcluir" + string(cidade.cid-cidade),"yes",no,no,"left",0,no,no,0,no,no,"",""),"C","Exluir","",0,0).
    fcaixa("C", string(cidade.cid-cidade),"C","Código","",20,0).
    fcaixa("C", fpad-text("vcid-nome" + string(cidade.cid-cidade),10,10,cidade.cid-nome,"C",no,"left",0,no,no,0,no,no,"",""),"C","Nome","",40,0).
    fcaixa("C",if avail cidade then fselect("vest-nome" + string(cidade.cid-cidade),festado(),estado.est-estado,1,no,no,"left",0,no,no,0,no,no,"") else "","C","Estado","",40,0).
    fcaixa("C",if avail cidade then fselect("vpais-nome" + string(cidade.cid-cidade),fpais(),string(pais.pai-pais),1,no,no,"left",0,no,no,0,no,no,"") else "","C","País","",40,0).
    final(no,100,"").
    fhidden("vhidden-cidade" + string(cidade.cid-cidade),string(rowid(cidade))).
end procedure.

procedure p_salvar: //SE ALTERA ESTADO OU PAÍS, EXCLUI A CIDADE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    def var vcont as int.
    def var vcod  as int.
    def var vval-cid-nome  as char.
    def var vval-est-nome as char.
    def var vval-pai-pais as char.

    //percorre todos os checkbox
    do vcont = 1 to flista-num("PAR","vhidden-cidade"):

        assign vcod = int(flista-val("PAR", vcont, "vhidden-cidade", "R")). //pega o radical (codigo da cidade)
        assign vval-cid-nome = get-value("vcid-nome" + string(vcod))
               vval-est-nome = get-value("vest-nome" + string(vcod))
               vval-pai-pais = get-value("vpais-nome" + string(vcod)).

            find cidade where cidade.cid-cidade = vcod exclusive-lock no-error.

            if avail cidade then //se achou a cidade,
                assign cidade.cid-nome   = vval-cid-nome
                       cidade.est-estado = vval-est-nome
                       cidade.pai-pais   = int(vval-pai-pais)
                       .
            end.
end procedure.


procedure p_excluir:

    def var vcont as int.
    def var vcod  as int.
    def var vval  as char.

    //percorre todos os checkbox
    do vcont = 1 to flista-num("PAR","vcheckexcluir"):

        assign vcod = int(flista-val("PAR", vcont, "vcheckexcluir", "R")). //pega o radical (codigo da cidade)
        assign vval = flista-val("PAR", vcont, "vcheckexcluir", "V"). //pega o valor da checkbox (yes/no)

        if vval = "yes" then do:
            find cidade where cidade.cid-cidade = vcod //pega a cidade que tem o codigo = ao da checkbox
            exclusive-lock no-error.

            if avail cidade then //se achou a cidade,
                delete cidade. //exclui
            end. //se n achar a cidade, n faz nada
        end.
end procedure.

function festado returns char(): 

    def var vselect as char.
    def buffer bestado for estado.

    for each bestado no-lock
          by bestado.est-nome:
        assign vselect = vselect + bestado.est-estado + "," + bestado.est-nome + ",".
    end. 

    return vselect.
end function.

function fpais returns char(): 

    def var vselect as char.
    def buffer bpais for pais.

    for each bpais no-lock
          by bpais.pai-nome:
        assign vselect = vselect + string(bpais.pai-pais) + "," + bpais.pai-nome + ",".
    end. 

    return vselect.
end function.