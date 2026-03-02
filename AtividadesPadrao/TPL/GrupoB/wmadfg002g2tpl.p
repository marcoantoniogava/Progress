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

def temp-table tt_estado
    field codigo   as int
    field nome     as char
    field sigla    as char.

def temp-table tt_cidade
    field codigo   as int
    field nome     as char.

run p_load_html. /* Carrega layout HTML padrão */
run p_replace_html. /* Efetua a substituição das Tags coringas por conteudo dinâmico */
run p_show_html. /* Gera o HTML final */

procedure p_load_html:

    copy-lob file "/agroweb/templates/wmadfg002g2tpl.tpl" to vpad-html.
    assign vtpl = new Template(vpad-html).
end procedure.

procedure p_replace_html: /* APENAS A PRIMEIRA VEZ QUE CARREGA A TELA */

    vtpl:troca("[cache]",string(today, "99999999") + string(time, "999999")).
    vtpl:block("BLOCK_CACHE").
end procedure.

procedure p_show_html:
    vtpl:show().
end procedure.

procedure p_getdadosPais:

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

procedure p_getdadosEstado:

    def var vretorno as longchar.
    def var vordena  as char.

    assign vordena = get-value("vordena").

    if vordena = "" or vordena = "C" then do:
        for each estado where 
                 string(estado.est-cod) matches "*" + get-value("vpadpesq") + "*"  no-lock
            by estado.est-cod:
            create tt_estado.
            assign tt_estado.codigo   = estado.est-cod
                   tt_estado.nome     = estado.est-nome
                   tt_estado.sigla    = estado.est-estado.
        end.
    end.

    else if vordena = "N" then do:
        for each estado where 
                 estado.est-nome matches "*" + get-value("vpadpesq") + "*"  no-lock
            by estado.est-nome:
            create tt_estado.
            assign tt_estado.codigo   = estado.est-cod
                   tt_estado.nome     = estado.est-nome
                   tt_estado.sigla    = estado.est-estado.
        end.
    end.

    temp-table tt_estado:write-json("longchar", vretorno, TRUE).
    fput(vretorno).
    quit.
end procedure.

procedure p_getdadosCidade:

    def var vretorno as longchar.
    def var vordena  as char.

    assign vordena = get-value("vordena").

    if vordena = "" or vordena = "C" then do:
        for each cidade where 
                 string(cidade.cid-cidade) matches "*" + get-value("vpadpesq") + "*"  no-lock
            by cidade.cid-cidade:
            create tt_cidade.
            assign tt_cidade.codigo   = cidade.cid-cidade
                   tt_cidade.nome     = cidade.cid-nome.
        end.
    end.

    else if vordena = "N" then do:
        for each cidade where 
                 cidade.cid-nome matches "*" + get-value("vpadpesq") + "*"  no-lock
            by cidade.cid-nome:
            create tt_cidade.
            assign tt_cidade.codigo   = cidade.cid-cidade
                   tt_cidade.nome     = cidade.cid-nome.
        end.
    end.

    temp-table tt_cidade:write-json("longchar", vretorno, TRUE).
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