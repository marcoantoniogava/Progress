{webpro.i}
{wpadfunc.i}

def var vtpl      as class Template.
def var vpad-html as longchar.
def var vtotal    as int.

run p_load_html. /* Carrega layout HTML padrão */
run p_replace_html. /* Efetua a substituição das Tags coringas por conteudo dinâmico */
run p_show_html. /* Gera o HTML final */

procedure p_load_html:
    copy-lob file "/agroweb/templates/wmadfg001g2tpl.tpl" to vpad-html.
    assign vtpl = new Template(vpad-html).
end procedure.

procedure p_replace_html: /* APENAS A PRIMEIRA VEZ QUE CARREGA A TELA */

    for each cidade where
             cidade.cid-cidade < 1000 no-lock,
       first estado where
             estado.est-estado = cidade.est-estado no-lock
       break by cidade.est-estado.

        vtpl:troca("[vcid-cod]",string(cidade.cid-cidade)).
        vtpl:troca("[vcid-nome]",cidade.cid-nome).
        vtpl:block("BLOCK_DADOS").

        vtotal = vtotal + 1.

        if last-of(cidade.est-estado)
        then do:
            vtpl:troca("[vest-nome]",estado.est-estado).
            vtpl:troca("[vtotal]",string(vtotal)).
            vtpl:block("BLOCK_HEADER").

            assign vtotal = 0.
        end.
    end.

    vtpl:troca("[cache]",string(today, "99999999") + string(time, "999999")).
    vtpl:block("BLOCK_CACHE").

end procedure.

procedure p_show_html:
    vtpl:show().
end procedure.