{webpro.i}
{wpadfunc.i}

procedure output-header:
end procedure.

&scoped-define vpad-tabela [tabela]
def query q1 for [tabela] scrolling.

{wpadco03.i}

procedure p_setvalue:
end procedure.

procedure p_setparams:
    assign vpad-titulo  = "Titulo"
           vpad-modo    = "CON"
           vpad-ordena  = ""
           vpad-pesq    = false
           vpad-btnaveg = false
           vpad-numlin  = 20
           vpad-numcol  = 10
           vpad-btret   = ""
           vpad-btinc   = ""
           vpad-btexc   = "".
end procedure.

procedure p_insere_botao:
    def output parameter vadd-botao as char.
    assign vadd-botao = "".
end procedure.

procedure p_botao_action:
    frunprog("idbotao","procedure","").
end procedure.

procedure p_abrequery:
    open query q1 for each [tabela] no-lock indexed-reposition.
end procedure.

procedure p_browse:
    finicio(vpad-cor,"").
    fcaixa("C","conteudo","C","titulo","",0,0).
    final(no,100,"").
end procedure.

procedure p_finalizar:
end procedure.

procedure p_excluir:
end procedure.