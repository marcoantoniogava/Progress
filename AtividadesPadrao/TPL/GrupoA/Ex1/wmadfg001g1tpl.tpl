<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta - Países</title>
    <link rel="stylesheet" href="/sistema/templates/webstyle.css">
    <!-- BEGIN BLOCK_CACHE -->
    <link rel="stylesheet" href="/sistema/templates/wmadfg001g1tpl.css?vcache=[cache]">
    <!-- END BLOCK_CACHE -->
</head>

<body>
    <div class="box_titulo">
        <div class="box_effect">
            Consulta - Países
        </div>
    </div>

    <div class="box_naveg">

    </div>
    <div class="box_dados">
        <table>
            <thead>
                <tr>
                    <th></th>
                    <th>Código</th>
                    <th>Nome</th>
                    <th>Siscomex</th>
                    <th>Centro de Custo</th>
                    <th>Área Geográfica</th>
                    <th>União Europeia</th>
                </tr>
            </thead>
            <tbody id="dados">
                <!-- BEGIN BLOCK_PAIS -->
                <tr>
                    <td>
                        <input type="radio" name="vpad-radio">
                    </td>
                    <td>[vpai-pais]</td>
                    <td>[vpai-nome]</td>
                    <td>[vpai-pais-siscomex]</td>
                    <td>[vpai-ccu-ccusto]</td>
                    <td>[vpai-codareageo]</td>
                    <td>[vpai-uniao-europeia]</td>
                </tr>
                <!-- END BLOCK_PAIS -->
            </tbody>
        </table>
    </div>
    
    <div class="box_botoes">
        <input type="submit" value="Incluir" name="vbt-inc.x" class="botao">
        <input type="submit" value="Alterar" name="vbt-alt.x" class="botao">
        <input type="submit" value="Excluir" name="vpad-btexc.x" class="botao">
    </div>
</body>

</html>