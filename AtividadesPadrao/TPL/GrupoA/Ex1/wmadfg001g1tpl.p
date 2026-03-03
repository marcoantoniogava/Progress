{webpro.i}
{wpadfunc.i}

def var vtpl      as class Template.
def var vpad-html as longchar.

run p_load_html. /* Carrega layout HTML padrão */
run p_replace_html. /* Efetua a substituição das Tags coringas por conteudo dinâmico */
run p_show_html. /* Gera o HTML final */

procedure p_load_html:

    copy-lob file "/agroweb/templates/wmadfg001g1tpl.tpl" to vpad-html.
    assign vtpl = new Template(vpad-html).
end procedure.

procedure p_replace_html: /* APENAS A PRIMEIRA VEZ QUE CARREGA A TELA */

    for each pais no-lock:
        vtpl:troca("[vpai-pais]",string(pais.pai-pais)).
        vtpl:troca("[vpai-nome]",pais.pai-nome).
        vtpl:troca("[vpai-pais-siscomex]",string(pais.pai-pais-siscomex)).
        vtpl:troca("[vpai-ccu-ccusto]",string(pais.ccu-ccusto)).
        vtpl:troca("[vpai-codareageo]",string(pais.codareageo)).
        vtpl:troca("[vpai-uniao-europeia]",string(pais.uniao-europeia)).
        vtpl:block("BLOCK_PAIS"). 
    end.

    vtpl:troca("[cache]",string(today, "99999999") + string(time, "999999")).
    vtpl:block("BLOCK_CACHE").

end procedure.

procedure p_show_html:
    vtpl:show().
end procedure.