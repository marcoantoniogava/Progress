$(document).ready(function() {
    $("#btnAbrir").click(function() {
        fpesquisa();
    });
    fpesquisa();
});

function fpesquisa() {
    const vaux = window.location.href.indexOf("?") > -1 ? "&" : "?";
    let vpadpesq = $("#vpadpesq").val();

    $.ajax({
        type: "POST",
        contentType: 'Content-type: text/plain; charset=iso-8859-1',
        beforeSend: function(jqXHR) { jqXHR.overrideMimeType('text/html;charset=iso-8859-1'); },
        url: window.location.href + vaux + "vpad_proc=p_getdados",
        data: "vpadpesq=" + vpadpesq,
        dataType: "html",
        success: function(vresult) {
            vresult = JSON.parse(vresult);
            let tbody = $("#box_dados");
            tbody.empty();
            $.each(vresult.tt_programa, function(i, d) {
                tbody.append(`
                    <iframe src="${d.nome}" frameborder="0"></iframe>
                `);
            });
        },
        error: function(verror) { console.log(verror); }
    });
}