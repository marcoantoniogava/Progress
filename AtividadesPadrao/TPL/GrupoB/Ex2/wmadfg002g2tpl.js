$(document).ready(function() {
    $("#vordena").change(function() { fpesquisaAtiva(); });
    $("#vpadpesq").change(function() { fpesquisaAtiva(); });
    fpesquisaPais();
});

function activate_aba(btn) {
    $(".aba").removeClass("active");
    $(btn).addClass("active");

    const id = $(btn).attr("id");

    if (id === "vaba_paises") {
        $(".box_titulo .box_effect").text("Consulta - Países");
        $("#thead_row").html(`
            <th>Código</th>
            <th>Nome</th>
            <th>Siscomex</th>
            <th>Centro de Custo</th>
            <th>Área Geográfica</th>
            <th>União Europeia</th>
        `);
        fpesquisaPais();
    } else if (id === "vaba_estados") {
        $(".box_titulo .box_effect").text("Consulta - Estados");
        $("#thead_row").html(`
            <th>Código</th>
            <th>Nome</th>
            <th>Sigla</th>
        `);
        fpesquisaEstado();
    } else if (id === "vaba_cidades") {
        $(".box_titulo .box_effect").text("Consulta - Cidades");
        $("#thead_row").html(`
            <th>Código</th>
            <th>Nome</th>
        `);
        fpesquisaCidade();
    }
}

function fpesquisaAtiva() {
    const abaAtiva = $(".aba.active").attr("id");
    if (abaAtiva === "vaba_paises")  fpesquisaPais();
    else if (abaAtiva === "vaba_estados") fpesquisaEstado();
    else if (abaAtiva === "vaba_cidades") fpesquisaCidade();
}

function fpesquisaPais() {
    const vaux = window.location.href.indexOf("?") > -1 ? "&" : "?";
    let vordena  = $("#vordena").val();
    let vpadpesq = $("#vpadpesq").val();

    $.ajax({
        type: "POST",
        contentType: 'Content-type: text/plain; charset=iso-8859-1',
        beforeSend: function(jqXHR) { jqXHR.overrideMimeType('text/html;charset=iso-8859-1'); },
        url: window.location.href + vaux + "vpad_proc=p_getdadosPais",
        data: "vordena=" + vordena + "&vpadpesq=" + vpadpesq,
        dataType: "html",
        success: function(vresult) {
            vresult = JSON.parse(vresult);
            let tbody = $("#dados");
            tbody.empty();
            $.each(vresult.tt_pais, function(i, d) {
                tbody.append(`
                    <tr data-codigo="${d.codigo}">
                        <td>${d.codigo}</td>
                        <td>${d.nome}</td>
                        <td>${d.siscomex}</td>
                        <td>${d.ccu}</td>
                        <td>${d.areageo}</td>
                        <td>${d.unieu ? "Sim" : "Não"}</td>
                    </tr>
                `);
            });
        },
        error: function(verror) { console.log(verror); }
    });
}

function fpesquisaEstado() {
    const vaux = window.location.href.indexOf("?") > -1 ? "&" : "?";
    let vordena  = $("#vordena").val();
    let vpadpesq = $("#vpadpesq").val();

    $.ajax({
        type: "POST",
        contentType: 'Content-type: text/plain; charset=iso-8859-1',
        beforeSend: function(jqXHR) { jqXHR.overrideMimeType('text/html;charset=iso-8859-1'); },
        url: window.location.href + vaux + "vpad_proc=p_getdadosEstado",
        data: "vordena=" + vordena + "&vpadpesq=" + vpadpesq,
        dataType: "html",
        success: function(vresult) {
            vresult = JSON.parse(vresult);
            let tbody = $("#dados");
            tbody.empty();
            $.each(vresult.tt_estado, function(i, d) {
                tbody.append(`
                    <tr data-codigo="${d.codigo}">
                        <td>${d.codigo}</td>
                        <td>${d.nome}</td>
                        <td>${d.sigla}</td>
                    </tr>
                `);
            });
        },
        error: function(verror) { console.log(verror); }
    });
}

function fpesquisaCidade() {
    const vaux = window.location.href.indexOf("?") > -1 ? "&" : "?";
    let vordena  = $("#vordena").val();
    let vpadpesq = $("#vpadpesq").val();

    $.ajax({
        type: "POST",
        contentType: 'Content-type: text/plain; charset=iso-8859-1',
        beforeSend: function(jqXHR) { jqXHR.overrideMimeType('text/html;charset=iso-8859-1'); },
        url: window.location.href + vaux + "vpad_proc=p_getdadosCidade",
        data: "vordena=" + vordena + "&vpadpesq=" + vpadpesq,
        dataType: "html",
        success: function(vresult) {
            vresult = JSON.parse(vresult);
            let tbody = $("#dados");
            tbody.empty();
            $.each(vresult.tt_cidade, function(i, d) {
                tbody.append(`
                    <tr data-codigo="${d.codigo}">
                        <td>${d.codigo}</td>
                        <td>${d.nome}</td>
                    </tr>
                `);
            });
        },
        error: function(verror) { console.log(verror); }
    });
}