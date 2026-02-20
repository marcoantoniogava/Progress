{webpro.i}
{wpadfunc.i}

procedure output-header:
    flista("add","vpad-btpesq.x","true").
end procedure.

&scoped-define vpad-tabela item
def query q1 for item scrolling.

{wpadco04.i}

procedure p_setvalue:
end procedure.

procedure p_setparams:
    assign vpad-titulo  = "Itens"
           vpad-ordena  = ""
           vpad-pesq    = false
           vpad-btnaveg = true
           vpad-numlin  = 30
           vpad-numcol  = 10
           vpad-btret   = ""
           vpad-btinc   = ""
           vpad-btsal   = ""
           vpad-btexc   = "".
end procedure.

procedure p_insere_botao:
    def output parameter vadd-botao as char.
    assign vadd-botao = "".
end procedure.

procedure p_botao_action:
    frunprog("idbotao","procedure","").
end procedure.

procedure p_abrequery:                //se usuario nao digitar nada: item.ite-dtlibera >= item.ite-dtlibera (TRUE) logo, mostra todos os registros
    open query q1 for each item where //se digitar, compara com a data de liberacao do produto no banco, se ela for maior ou igual a digitada, ele aparece.
                           item.ite-dtlibera >= (if get-value("vdatainic") = "" then item.ite-dtlibera else date(get-value("vdatainic"))) and
                           item.ite-dtlibera <= (if get-value("vdatafim") = "" then item.ite-dtlibera else date(get-value("vdatafim")))
    no-lock indexed-reposition.
end procedure.

procedure p_filtro:

    {&out}
        flabel("Data Início:","right",0,no,no,0,no,no)
        fpad-text("vdatainic",10,10,get-value("vdatainic"),"DT",no,"left",0,no,no,0,no,no,"document.forms[0].submit();","")

        flabel("Data Fim:","right",0,no,no,0,no,no)
        fpad-text("vdatafim",10,10,get-value("vdatafim"),"DT",no,"left",0,no,no,0,no,no,"document.forms[0].submit();","")
    .
end procedure.

procedure p_valida:

    if get-value("vdatainic") > get-value("vdatafim") and get-value("vdatafim") <> ""
    then do:
        {wpaderro.i "erro" "'A data inicial deve ser menor que a data final'"}
    end.
end procedure.

procedure p_browse:
    finicio(vpad-cor,"").
    fcaixa("C",string(item.ite-codigo),"C","Código","",0,0).
    fcaixa("E",item.ite-descricao,"E","Descrição","",0,0).
    fcaixa("C",string(item.ite-dtlibera),"C","Libera","",0,0).
    final(no,100,"").
end procedure.