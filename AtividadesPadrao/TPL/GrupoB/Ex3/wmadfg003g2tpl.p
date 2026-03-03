{webpro.i}
{wpadfunc.i}

def var vtpl      as class Template.
def var vpad-html as longchar.

function fput returns char(vjson as longchar) forward.

def temp-table tt_programa
    field nome    as char.

run p_load_html. /* Carrega layout HTML padrão */
run p_replace_html. /* Efetua a substituição das Tags coringas por conteudo dinâmico */
run p_show_html. /* Gera o HTML final */

procedure p_load_html:

    copy-lob file "/agroweb/templates/wmadfg003g2tpl.tpl" to vpad-html.
    assign vtpl = new Template(vpad-html).
end procedure.

procedure p_replace_html: /* APENAS A PRIMEIRA VEZ QUE CARREGA A TELA */

    vtpl:troca("[cache]",string(today, "99999999") + string(time, "999999")).
    vtpl:block("BLOCK_CACHE").
end procedure.

procedure p_show_html:
    vtpl:show().
end procedure.

procedure p_getdados:

    def var vretorno as longchar.
    def var vpadpesq  as char.

    assign vpadpesq = get-value("vpadpesq").

    create tt_programa.
    assign tt_programa.nome = "/webpro/weball/" + vpadpesq.

    temp-table tt_programa:write-json("longchar", vretorno, TRUE).
    fput(vretorno).
    quit.
end procedure.

function fput returns char (vjson as longchar):
    def var vcont as int.
    def var vnum  as int init 1.

    if length(vjson) > 30000
    then do vcont = 1 to trunc(length(vjson) / 30000,0) + 1.
        {&out} string(substring(vjson,vnum,30000)).

        assign vnum = vnum + 30000.
    end.
    else {&out} string(vjson).
end function.