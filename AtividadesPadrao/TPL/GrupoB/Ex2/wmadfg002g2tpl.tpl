<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta - Países</title>
    <link rel="stylesheet" href="/sistema/templates/webstyle.css">
    <script src="/sistema/jquery/jquery.min.js"></script>
    <!-- BEGIN BLOCK_CACHE -->
    <link rel="stylesheet" href="/sistema/templates/wmadfg002g2tpl.css?vcache=[cache]">
    <script src="/sistema/templates/wmadfg002g2tpl.js?vcache=[cache]"></script>
    <!-- END BLOCK_CACHE -->
</head>

<body>
    <div class="box_navegacao">
        <input type="button" class="aba active" id="vaba_paises" onclick="activate_aba(this)" value="Países">
        <input type="button" class="aba" id="vaba_estados" onclick="activate_aba(this)" value="Estados">
        <input type="button" class="aba" id="vaba_cidades" onclick="activate_aba(this)" value="Cidades">
    </div>

    <div class="box_titulo">
        <div class="box_effect">
            Consulta - Países
        </div>
    </div>

    <div class="box_naveg">

        <select name="vordena" id="vordena" class="select_auto">
            <option value="C">Código</option>
            <option value="N">Nome</option>
        </select>
        <input type="text" name="vpadpesq" id="vpadpesq" class="char">
    </div>

    <div class="box_dados">
        <table>
            <thead>
                <tr id="thead_row">
                    <th>Código</th>
                    <th>Nome</th>
                    <th>Siscomex</th>
                    <th>Centro de Custo</th>
                    <th>Área Geográfica</th>
                    <th>União Europeia</th>
                </tr>
            </thead>
            <tbody id="dados">

            </tbody>
        </table>
    </div>
</body>

</html>