$(document).ready(function() {
    $("#vbt-salvar").click(fsalvar); /* ao clicar no botão de salvar chama a função fsalvar() */
});

function fsalvar() {

    const vaux = window.location.href.indexOf("?") > -1 ? "&" : "?";

    let vdata = ""; /* acumula todos os parametros que serão enviados */
    let vi = 1; /* contador de linhas */

    $("select[data-estcod]").each(function() { /* varre todos os selects que tem [data-estcod] */
        let vestcod  = $(this).data("estcod"); /* pega codigo do estado que ta no data-estcod  */
        let vpaipais = $(this).val(); /* pega o value do select (codigo do pais) */
        
        /* monta os parametros no formato vestcod_x=y&vpaipais_x=y */
        vdata += "&vestcod_"  + vi + "=" + vestcod;
        vdata += "&vpaipais_" + vi + "=" + vpaipais;
        vi++;
    });

    vdata += "&vtotal=" + (vi - 1); /* adiciona o total de linhas */

    $.ajax({
        type: "POST",
        contentType: 'Content-type: text/plain; charset=iso-8859-1',
        beforeSend: function(jqXHR) {
            jqXHR.overrideMimeType('text/html;charset=iso-8859-1');
        },
        url: window.location.href + vaux + "vpad_proc=p_salvar",
        data: vdata,
        dataType: "html",
        success: function(vresult) {
            if (vresult.trim() === "OK") { /* se o progress retornar OK recarrega a página */
                location.reload();
            } else { /* se não, dá erro */
                alert("Erro ao salvar.");
                console.log("Retorno inesperado:", vresult);
            }
        },
        error: function(verror) {
            alert("Erro na requisição.");
            console.log(verror);
        }
    });
}