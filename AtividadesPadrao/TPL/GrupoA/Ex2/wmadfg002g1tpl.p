{webpro.i}
{wpadfunc.i}

def var vtpl      as class Template.
def var vpad-html as longchar.

function fpais returns char() forwards.

run p_load_html. /* Carrega layout HTML padrão */
run p_replace_html. /* Efetua a substituição das Tags coringas por conteudo dinâmico */
run p_show_html. /* Gera o HTML final */

procedure p_load_html:

    copy-lob file "/agroweb/templates/wmadfg002g1tpl.tpl" to vpad-html.
    assign vtpl = new Template(vpad-html).
end procedure.

procedure p_replace_html: /* APENAS A PRIMEIRA VEZ QUE CARREGA A TELA */

    for each estado no-lock:
        vtpl:troca("[vest-cod]",string(estado.est-cod)).
        vtpl:troca("[vest-estado]",estado.est-estado).
        vtpl:troca("[vest-nome]",estado.est-nome).
        vtpl:troca("[vpai-pais]",string(estado.pai-pais)).
        vtpl:troca("[vfpais]",fpais()).
        vtpl:block("BLOCK_ESTADO"). 
    end.

    vtpl:troca("[cache]",string(today, "99999999") + string(time, "999999")).
    vtpl:block("BLOCK_CACHE").

end procedure.

procedure p_show_html:
    vtpl:show().
end procedure.

procedure p_salvar:

    def var vestcod   as int.
    def var vpaipais  as int. /* código do novo país */
    def var vi        as int.
    def var vtotal    as int.
    def var vretorno  as char.

    assign vtotal = int(get-value("vtotal")). /* total de linhas */

    do vi = 1 to vtotal: /* pega o código do estado e o novo país da linha (vi) */
        assign vestcod  = int(get-value("vestcod_"  + string(vi)))
               vpaipais = int(get-value("vpaipais_" + string(vi))).
        /* pega o estado pelo código pra alterar */
        find estado where estado.est-cod = vestcod exclusive-lock no-error.

        if avail estado then do: /* se achar, altera o país do estado */
            assign estado.pai-pais = vpaipais.
            release estado.
        end.
    end.

    assign vretorno = "OK".
    {&out} vretorno. /* devolve o retorno pro js */
    quit.
end procedure.

function fpais returns char():

    def var voptions as longchar.

    /* Pega o país atual do estado */
    find first pais
         where pais.pai-pais = estado.pai-pais
         no-lock no-error.

    if avail pais then do:
        /* Coloca o país atual primeiro e já marcado como selecionado */
        assign voptions = "<option value='"
                        + string(pais.pai-pais)
                        + "' selected='selected'>"
                        + pais.pai-nome
                        + "</option>".
    end.
    else do:
        /* Se não encontrar, mostra o código */
        assign voptions = "<option value='"
                        + string(estado.pai-pais)
                        + "' selected='selected'>"
                        + string(estado.pai-pais)
                        + "</option>".
    end.

    /* Todos os outros países como opção */
    for each pais no-lock
         where pais.pai-pais <> estado.pai-pais
         by pais.pai-nome:

        assign voptions = voptions
                        + "~n<option value='"
                        + string(pais.pai-pais)
                        + "'>"
                        + pais.pai-nome
                        + "</option>".
    end.

    return string(voptions).
end function.