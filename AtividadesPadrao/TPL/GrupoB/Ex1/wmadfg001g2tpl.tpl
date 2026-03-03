<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta - Estados e Cidades</title>
    <link rel="stylesheet" href="/sistema/templates/webstyle.css">
    <script src="/sistema/jquery/jquery.min.js"></script>
    <!-- BEGIN BLOCK_CACHE -->
    <link rel="stylesheet" href="/sistema/templates/wmadfg001g2tpl.css?vcache=[cache]">
    <!-- END BLOCK_CACHE -->
</head>

<body>
    <div class="box_titulo">
        <div class="box_effect">
            Consulta - Estados e Cidades
        </div>
    </div>

    <div class="box_naveg">

    </div>
    <div class="box_dados">
        <table>
            <!-- BEGIN BLOCK_HEADER -->
            <thead>
                <tr>
                    <th>Estado: [vest-nome]</th>
                    <th>Total de cidades: [vtotal]</th>
                </tr>
                <tr>
                    <th>Código - Cidade</th>
                    <th>Nome - Cidade</th>
                </tr>
            </thead>
            <tbody id="dados">
                <!-- BEGIN BLOCK_DADOS -->
                <tr>
                    <td>[vcid-cod]</td>
                    <td>[vcid-nome]</td>
                </tr>
                <!-- END BLOCK_DADOS -->
            </tbody>
            <!-- END BLOCK_HEADER -->
        </table>
    </div>

</body>

</html>