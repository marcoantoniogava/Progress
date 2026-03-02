{webpro.i}
{wpadfunc.i}

def var vtpl      as class Template.
def var vpad-html as longchar.


run p_load_html. /* Carrega layout HTML padrão */
run p_replace_html. /* Efetua a substituição das Tags coringas por conteudo dinâmico */
run p_show_html. /* Gera o HTML final */

procedure p_load_html:

    copy-lob file "/agroweb/templates/wmadfg001tpl.tpl" to vpad-html.
    assign vtpl = new Template(vpad-html).
end procedure.

procedure p_replace_html:

    /*vtpl:troca("[teste]","teste").
    vtpl:block("BLOCK_TESTE").*/
end procedure.

procedure p_show_html:
    vtpl:show().
end procedure.