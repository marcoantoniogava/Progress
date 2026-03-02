{webpro.i}
{wpadfunc.i}

def var vtpl      as class Template.
def var vpad-html as longchar.

function fput returns char(vjson as longchar) forward.

def temp-table tt_pais
    field codigo   as int
    field nome     as char
    field siscomex as int
    field ccu      as int
    field areageo  as int
    field unieu    as log.

run p_load_html. /* Carrega layout HTML padrão */
run p_replace_html. /* Efetua a substituição das Tags coringas por conteudo dinâmico */
run p_show_html. /* Gera o HTML final */

procedure p_load_html:

    copy-lob file "/agroweb/templates/wmadfg002tpl.tpl" to vpad-html.
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
    def var vordena  as char.

    assign vordena = get-value("vordena").

    if vordena = "" or vordena = "C" then do:
        for each pais where 
                 string(pais.pai-pais) matches "*" + get-value("vpadpesq") + "*"  no-lock
            by pais.pai-pais:
            create tt_pais.
            assign tt_pais.codigo   = pais.pai-pais
                   tt_pais.nome     = pais.pai-nome
                   tt_pais.siscomex = pais.pai-pais-siscomex
                   tt_pais.ccu      = pais.ccu-ccusto
                   tt_pais.areageo  = pais.codareageo
                   tt_pais.unieu    = pais.uniao-europeia.
        end.
    end.

    else if vordena = "N" then do:
        for each pais where 
                 pais.pai-nome matches "*" + get-value("vpadpesq") + "*"  no-lock
            by pais.pai-nome:
            create tt_pais.
            assign tt_pais.codigo   = pais.pai-pais
                   tt_pais.nome     = pais.pai-nome
                   tt_pais.siscomex = pais.pai-pais-siscomex
                   tt_pais.ccu      = pais.ccu-ccusto
                   tt_pais.areageo  = pais.codareageo
                   tt_pais.unieu    = pais.uniao-europeia.
        end.
    end.

    temp-table tt_pais:write-json("longchar", vretorno, TRUE).
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