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
           vpad-ordena  = ",Código,N,Nome"
           vpad-pesq    = true
           vpad-btnaveg = true
           vpad-numlin  = 30
           vpad-numcol  = 10
           vpad-btret   = ""
           vpad-btinc   = ""
           vpad-btexc   = "".
end procedure.

procedure p_insere_botao:
    def output parameter vadd-botao as char.
    assign vadd-botao = fbotao_alert("Alertar País","Alerta","Alertar","","","").
end procedure.

procedure p_botao_action:
    frunprog("Alerta","p_alert","").
end procedure.

procedure p_abrequery:

    if get-value("vpad-ordena") = ""
    then open query q1 for each pais where 
                                pais.pai-pais >= (if int(get-value("vpad-pesq")) = 0
                                                      then pais.pai-pais
                                                      else int(get-value("vpad-pesq"))) no-lock 
                             by pais.pai-pais indexed-reposition.

    if get-value("vpad-ordena") = "N"
    then open query q1 for each pais where 
                                pais.pai-nome matches ("*" + get-value("vpad-pesq") + "*") no-lock 
                             by pais.pai-nome indexed-reposition.
end procedure.

procedure p_browse:
    finicio(vpad-cor, string(rowid(pais))).
    fcaixa("C", string(pais.pai-pais),"C","Código","",10,0).
    fcaixa("C", pais.pai-nome,"C","Nome","",10,0).
    fcaixa("C", string(pais.pai-pais-siscomex),"C","Siscomex","",10,0).
    fcaixa("C", string(pais.ccu-ccusto),"C","Centro de Custo","",10,0).
    fcaixa("C", string(pais.codareageo),"C","Área Geográfica","",10,0).
    fcaixa("C", string(pais.uniao-europeia),"C","União Europeia","",10,0).
    final(no,100,"").
end procedure.

procedure p_alert:

    def var valerta as char.
    find pais where rowid(pais) = to-rowid(get-value("vpad-radio")) no-lock no-error.
    //find pais -> busca na tabela pais; where rowid(pais) -> onde o rowid(pais) (país) é = ao vpad-radio (país selecionado)
    //to-rowid converte o get-value que vai retonar char, pra retornar um rowid
    if avail pais then do:
        assign valerta = string(pais.pai-pais) + " - " + pais.pai-nome.
    end.
    {wpaderro.i "alerta" "valerta"}
end procedure.
