$(document).ready(function () {
    const canvas = document.getElementById("desenho");
    const ctx = canvas.getContext("2d");

    let desenhando = false;
    let modo = "caneta"; // "caneta" ou "borracha"

    const $cor = $("#cor");
    const $espessura = $("#espessura");
    const $espessuraValor = $("#espessura-valor");

    // Atualiza texto da espessura quando mexer no slider
    $espessura.on("input", function () {
        $espessuraValor.text($(this).val() + "px");
    });

    // Função para pegar posição do mouse relativa ao canvas
    function getPosicaoMouse(evt) {
        const rect = canvas.getBoundingClientRect();
        return {
            x: evt.clientX - rect.left,
            y: evt.clientY - rect.top
        };
    }

    // Início do desenho
    canvas.addEventListener("mousedown", function (evt) {
        desenhando = true;
        const pos = getPosicaoMouse(evt);

        ctx.beginPath();
        ctx.moveTo(pos.x, pos.y);
    });

    // Movimento do mouse (desenho mesmo)
    canvas.addEventListener("mousemove", function (evt) {
        if (!desenhando) return;

        const pos = getPosicaoMouse(evt);
        const esp = parseInt($espessura.val(), 10) || 5;

        ctx.lineWidth = esp;
        ctx.lineCap = "round";

        if (modo === "caneta") {
            ctx.globalCompositeOperation = "source-over"; // desenhar normal
            ctx.strokeStyle = $cor.val();
        } else { // borracha
            ctx.globalCompositeOperation = "destination-out"; // apagar
        }

        ctx.lineTo(pos.x, pos.y);
        ctx.stroke();
        ctx.beginPath();
        ctx.moveTo(pos.x, pos.y);
    });

    // Fim do desenho
    canvas.addEventListener("mouseup", function () {
        desenhando = false;
        ctx.beginPath();
    });

    canvas.addEventListener("mouseleave", function () {
        desenhando = false;
        ctx.beginPath();
    });

    // Botão Caneta
    $("#btnCaneta").click(function () {
        modo = "caneta";
        canvas.style.cursor = "crosshair";
    });

    // Botão Borracha
    $("#btnBorracha").click(function () {
        modo = "borracha";
        canvas.style.cursor = "cell";
    });

    // Botão Limpar
    $("#btnLimpar").click(function () {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
    });

    // Botão Salvar Imagem
    $("#btnSalvar").click(function () {
        // Gera um PNG do canvas
        const dataURL = canvas.toDataURL("image/png");

        const link = document.createElement("a");
        link.href = dataURL;
        link.download = "desenho.png";
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    });
});