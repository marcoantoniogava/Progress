<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta - Estados</title>
    <link rel="stylesheet" href="/sistema/templates/webstyle.css">
    <script src="/sistema/jquery/jquery.min.js"></script>
    <!-- BEGIN BLOCK_CACHE -->
    <link rel="stylesheet" href="/sistema/templates/wmadfg003g3tpl.css?vcache=[cache]">
    <script src="/sistema/templates/wmadfg003g3tpl.js?vcache=[cache]"></script>
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
        <div class="estado-grid">
            <!-- BEGIN BLOCK_ESTADO -->
            <div class="estado-card" data-modal="modal-[vest-estado]">
                <div class="estado-sigla">[vest-estado]</div>
                <div class="estado-nome">[vest-nome]</div>
                <button type="button" class="botao botao-ver-cidades">
                    Cidades
                </button>
            </div>

            <div class="modal" id="modal-[vest-estado]">
                <div class="modal-backdrop"></div>
                <div class="modal-conteudo">
                    <div class="modal-header">
                        <span>[vest-nome] ([vest-estado])</span>
                        <button type="button" class="modal-fechar">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="cidade-grid">
                            <!-- BEGIN BLOCK_CIDADE -->
                            <div class="cidade-card">
                                <div class="cidade-nome">[vcid-nome]</div>
                                <div class="cidade-cod">Código: [vcid-cod]</div>
                            </div>
                            <!-- END BLOCK_CIDADE -->
                        </div>
                    </div>
                </div>
            </div>
            <!-- END BLOCK_ESTADO -->
        </div>
    </div>
</body>

</html>