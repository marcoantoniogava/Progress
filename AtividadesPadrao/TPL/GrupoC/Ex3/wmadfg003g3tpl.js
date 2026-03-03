$(document).ready(function () {
    $(".estado-grid").on("click", ".estado-card, .estado-card .botao-ver-cidades", function (e) {
        const $card = $(this).hasClass("estado-card") ? $(this) : $(this).closest(".estado-card");
        const modalId = $card.data("modal");

        if (modalId) {
            $("#" + modalId).addClass("aberto");
        }
    });

    $(".modal").on("click", ".modal-fechar, .modal-backdrop", function () {
        $(this).closest(".modal").removeClass("aberto");
    });
});