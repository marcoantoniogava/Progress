<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta - Países</title>
    <link rel="stylesheet" href="/sistema/templates/webstyle.css">
    <script src="/sistema/jquery/jquery.min.js"></script>
    <!-- BEGIN BLOCK_CACHE -->
    <link rel="stylesheet" href="/sistema/templates/wmadfg001g3tpl.css?vcache=[cache]">
    <script src="/sistema/templates/wmadfg001g3tpl.js?vcache=[cache]"></script>
    <!-- END BLOCK_CACHE -->
</head>

<body>
    <div class="box_titulo">
        <div class="box_effect">
            Desenho
        </div>
    </div>

    <div class="box_naveg">
        <div class="grupo-esquerda">
            <label for="cor">Cor:</label>
            <input type="color" id="cor" value="#000000">

            <label for="espessura">Espessura:</label>
            <input type="range" id="espessura" min="1" max="40" value="5">
            <span id="espessura-valor">5px</span>
        </div>

        <div class="grupo-direita">
            <input type="button" class="botao" id="btnCaneta" value="Caneta">
            <input type="button" class="botao" id="btnBorracha" value="Borracha">
            <input type="button" class="botao" id="btnLimpar" value="Limpar">
            <input type="button" class="botao" id="btnSalvar" value="Salvar Imagem">
        </div>
    </div>

    <div class="box_dados">
        <canvas id="desenho" width="900" height="500"></canvas>
    </div>
</body>

</html>