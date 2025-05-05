$(function () {
    function display(bool) {
        if (bool) {
            $('.background').css('display', "block");
            $("#container").fadeIn(300);
            
        } else {
            $('.background').css('display', "none");
            $("#container").fadeOut(1);
        }
    }

    display(false)

    window.addEventListener("message", function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })

    //ESC = exit
    document.onkeyup = function (data) {
        if (data.which == 27) { // ESC
            $.post("https://demon-elevator/exit", JSON.stringify({}));
             display(false)
        }
    };
    $(".zero").click(function () {
        $.post("https://demon-elevator/Floor1ToFloor0", JSON.stringify({}));
        $.post("https://demon-elevator/exit", JSON.stringify({}));
             display(false)
    })
    $(".first").click(function () {
        $.post("https://demon-elevator/Floor0ToFloor1", JSON.stringify({}));
        $.post("https://demon-elevator/exit", JSON.stringify({}));
             display(false)
    })
    $(".second").click(function () {
        $.post("https://demon-elevator/Floor1ToFloor2", JSON.stringify({}));
        $.post("https://demon-elevator/exit", JSON.stringify({}));
             display(false)
    })
    $(".third").click(function () {
        $.post("https://demon-elevator/Floor2ToFloor3", JSON.stringify({}));
        $.post("https://demon-elevator/exit", JSON.stringify({}));
             display(false)
    })
    $(".fourth").click(function () {
        $.post("https://demon-elevator/Floor3ToFloor4", JSON.stringify({}));
        $.post("https://demon-elevator/exit", JSON.stringify({}));
             display(false)
    })
    $(".fifth").click(function () {
        $.post("https://demon-elevator/Floor4ToFloor5", JSON.stringify({}));
        $.post("https://demon-elevator/exit", JSON.stringify({}));
             display(false)
    })
    $(".sixth").click(function () {
        $.post("https://demon-elevator/Floor5ToFloor6", JSON.stringify({}));
        $.post("https://demon-elevator/exit", JSON.stringify({}));
             display(false)
    })
    $(".seventh").click(function () {
        $.post("https://demon-elevator/Floor6ToFloor7", JSON.stringify({}));
        $.post("https://demon-elevator/exit", JSON.stringify({}));
             display(false)
    })
    $(".eighth").click(function () {
        $.post("https://demon-elevator/Floor7ToFloor8", JSON.stringify({}));
        $.post("https://demon-elevator/exit", JSON.stringify({}));
             display(false)
    })
})

