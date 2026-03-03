<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta - Estados</title>
    <link rel="stylesheet" href="/sistema/templates/webstyle.css">
    <script src="/sistema/jquery/jquery.min.js"></script>
    <!-- BEGIN BLOCK_CACHE -->
    <link rel="stylesheet" href="/sistema/templates/wmadfg002g1tpl.css?vcache=[cache]">
    <script src="/sistema/templates/wmadfg002g1tpl.js?vcache=[cache]"></script>
    <!-- END BLOCK_CACHE -->
</head>

<body>
    <div class="box_titulo">
        <div class="box_effect">
            Consulta - Estados
        </div>
    </div>

    <div class="box_naveg">

    </div>
    <div class="box_dados">
        <table>
            <thead>
                <tr>
                    <th>Código</th>
                    <th>Sigla</th>
                    <th>Nome</th>
                    <th>País</th>
                </tr>
            </thead>
            <tbody id="dados">
                <!-- BEGIN BLOCK_ESTADO -->
                <tr>
                    <td>[vest-cod]</td>
                    <td>[vest-estado]</td>
                    <td>[vest-nome]</td>
                    <td>
                        <select name="vselect-est-estado" id="vselect-est-estado" data-estcod="[vest-cod]"> <!-- data-estcod guarda o codigo do estado ([vest-cod]) -->
                            [vfpais]
                        </select>
                    </td>
                </tr>
                <!-- END BLOCK_ESTADO -->
            </tbody>
        </table>
    </div>
    
    <div class="box_botoes">
        <input type="button" value="Salvar" id="vbt-salvar" class="botao">
    </div>
</body>

</html>