{webpro.i}
{wpadfunc.i}

&scoped-define vpad-tabela ccusto
def query q1 for ccusto scrolling.

if get-value("vpad-ordena") = ""
then open query q1 for each ccusto where 
                            string(ccusto.ccu-ccusto) matches ("*" + get-value("vpad-pesq") + "*") no-lock
                         by ccusto.ccu-ccusto indexed-reposition.

{wpadzoom.i}

procedure p_setparams:

    assign vpad-ordena = ",Centro de Custo"
           vpad-pesq   = true
           vpad-numlin = 30
           vpad-numcol = 10.
end procedure.

procedure p_browse:

    finicio(vpad-cor,"").
    fcaixa("C",string(ccusto.ccu-ccusto),"C","Centro de Custo",furlzoom(get-value("vcampo"),string(ccusto.ccu-ccusto)),12,0).
    final(no,100,"").
end procedure.