$(document).ready(function () {
    $("#corzera").colorpicker();
});

(function ($) {
    $.fn.colorpicker = function () {

        const cores = [
            "#000000", "#FFFFFF", "#FF0000", "#00FF00", "#0000FF",
            "#FFFF00", "#FF8800", "#FF00FF", "#00FFFF", "#888888"
        ];

        // Para cada input onde chamar $("#corzera").colorpicker()
        return this.each(function () {
            const $input = $(this);

            // Cria o popup de cores (um <div> com vários quadradinhos)
            const $popup = $("<div class='cp-popup'></div>").hide();
            cores.forEach(function (cor) {
                const $cor = $("<div class='cp-cor'></div>");
                $cor.css("background-color", cor);
                $cor.data("valor-cor", cor);
                $popup.append($cor);
            });

            // Adiciona o popup no body
            $("body").append($popup);

            // Quando o input ganhar foco, mostra o popup perto dele
            $input.on("focus", function () {
                const offset = $input.offset();
                $popup.css({
                    position: "absolute",
                    top: offset.top + $input.outerHeight(),
                    left: offset.left
                }).show();
            });

            // Ao clicar em uma cor do popup
            $popup.on("click", ".cp-cor", function () {
                const corSelecionada = $(this).data("valor-cor");
                $input.val(corSelecionada);
                $input.css("background-color", corSelecionada);
                $popup.hide();
            });

            // Se clicar em qualquer lugar fora, esconder o popup
            $(document).on("mousedown", function (e) {
                if (!$(e.target).closest($popup).length && e.target !== $input[0]) {
                    $popup.hide();
                }
            });
        });
    };
})(jQuery);