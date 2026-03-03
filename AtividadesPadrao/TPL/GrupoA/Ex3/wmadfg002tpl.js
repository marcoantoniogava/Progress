$(document).ready(function() {
    $("#vordena").change(fpesquisa);
    $("#vpadpesq").change(fpesquisa);
    fpesquisa();
});

function fpesquisa() {

    const vaux = window.location.href.indexOf("?") > -1 ? "&" : "?";
    
    let vordena = $("#vordena").val(); //"C" ou "N"
    let vpadpesq = $("#vpadpesq").val(); //valor do input
    $.ajax({
        type: "POST",
        contentType: 'Content-type: text/plain; charset=iso-8859-1',
        beforeSend: function(jqXHR) {
            jqXHR.overrideMimeType('text/html;charset=iso-8859-1');
        },
        url: window.location.href + vaux + "vpad_proc=p_getdados",
        data: "vordena=" + vordena +
              "&vpadpesq=" + vpadpesq,
        dataType: "html",
        success: function(vresult){
            console.log("Retorno bruto: ", vresult);

            vresult = JSON.parse(vresult);

            console.log("Retorno parseado: ", vresult);

            let tbody = $("#dados");
            tbody.empty();

            $.each(vresult.tt_pais, function(i, d) {
                tbody.append(`
                    <tr data-codigo="${d.codigo}">
                        <td>
                            <input type="radio" name="vpad-radio" value="${d.codigo}">
                        </td>
                        <td>${d.codigo}</td>
                        <td>${d.nome}</td>
                        <td>${d.siscomex}</td>
                        <td>${d.ccu}</td>
                        <td>${d.areageo}</td>
                        <td>${d.unieu ? "Sim" : "Não"}</td>
                    </tr>
                `)
            })
        },
        error: function(verror){
            $("#areaLoad").hide();
            console.log(verror);
        }
    });
}