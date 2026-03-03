{webpro.i}
{wpadfunc.i}

def var vtpl      as class Template.
def var vpad-html as longchar.

run p_load_html. /* Carrega layout HTML padrão */
run p_replace_html. /* Efetua a substituição das Tags coringas por conteudo dinâmico */
run p_show_html. /* Gera o HTML final */

procedure p_load_html:

    copy-lob file "/agroweb/templates/wmadfg003g3tpl.tpl" to vpad-html.
    assign vtpl = new Template(vpad-html).
end procedure.

procedure p_replace_html: /* APENAS A PRIMEIRA VEZ QUE CARREGA A TELA */

    for each estado no-lock:
        vtpl:troca("[vest-estado]", estado.est-estado).
        vtpl:troca("[vest-nome]",   estado.est-nome).

        for each cidade
            where cidade.est-estado = estado.est-estado no-lock:
            vtpl:troca("[vcid-cod]",  string(cidade.cid-cidade)).
            vtpl:troca("[vcid-nome]", cidade.cid-nome).
            vtpl:block("BLOCK_CIDADE").
        end.
        vtpl:block("BLOCK_ESTADO").
    end.

    vtpl:troca("[cache]", string(today, "99999999") + string(time, "999999")).
    vtpl:block("BLOCK_CACHE").
end procedure.

procedure p_show_html:
    vtpl:show().
end procedure.