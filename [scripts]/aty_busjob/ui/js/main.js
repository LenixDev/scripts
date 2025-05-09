let routes = []
let level = 0
let added = false

$(function() {
    $.post(`https://${GetParentResourceName()}/uiLoaded`);

    window.addEventListener("message", function(event) {
        if (event.data.action == "openMenu") {
            level = event.data.level;
            $("#player-name").text(event.data.name);
            $("#player-pp img").attr("src", event.data.avatar);
            $("#player-level span").text(String(event.data.level).padStart(2, "0"));
            SetRoutes(event.data.routes);
            SetOldMissions(event.data.oldRoutes);
            SetActiveWorkers(event.data.workers)
            $("main").fadeIn(100);
            $("main").css("display", "flex")
            level = event.data.level;
            routes = event.data.routes;
        }

        if (event.data.action == "updateTime"){
            $(".timer").fadeIn();
            $(".timer span").text(event.data.time);
        }

        if (event.data.action == "hideTimer"){
            $(".timer").fadeOut();
        }

        if (event.data.action == "updateStops"){
            $(".stops-box").fadeIn(100)

            $("#stop-old").text(event.data.oldStop);
            $("#stop-active").text(event.data.activeStop);
            $("#stop-next").text(event.data.nextStop);
        }

        if (event.data.action == "hideStops"){
            $(".stops-box").fadeOut(100)
        }
    })

    $(document).on("click", "#routes .box", function() {
        $("#routes .box").removeClass("active");
        $(this).addClass("active");
        let routeId = $(this).data("id") - 1;
        let stops = routes[routeId].Stops;
        $("#stops").empty();
        $("#stops-sec .counter").text(String("0").padStart(2, "0"))

        stops.forEach((stop, i) => {
            $("#stops").append(`
            <div data-stopid="${i+1}" class="box ${stop.Level > level ? "disabled" : ""}">
                <div class="box-header">
                    <div class="item level">REQUIRED LEVEL <span>${String(stop.Level).padStart(2, "0")}</span></div>
                    <div class="item title"><img src="assets/road.png">STOP <span>${i+1}</span></div>
                </div>
                <div class="box-content">STOP <SPAN>${stop.StopName}</SPAN></div>
            </div>`);
    
            $("#stops-sec .counter").text(String(i+1).padStart(2, "0"))
        });

        $("#stops-sec").fadeIn(200)
        $("#stops-sec").css("display", "flex")
    })

    $(document).on("click", ".start-btn", function() {
        let routeId = $("#routes .box.active").data("id") - 1;
        let route = routes[routeId];

        if (route.Level > level) {
            $.post(`https://${GetParentResourceName()}/notify`, JSON.stringify("You don't have the required level to start this route."))
        }else{
            $.post(`https://${GetParentResourceName()}/startRoute`, JSON.stringify(route))
        }

        $("main").fadeOut("fast")
        $("#stops-sec").fadeOut(200)
    })
    
    $(document).on("mouseover", "#stops-sec .box", function() {
        if (added) return;
        added = true
        $(this).parent().parent().append(`<div class="image-box"><img src="${routes[$("#routes .box.active").data("id") - 1].Stops[$(this).data("stopid") - 1].Preview}"></div>`)
        $(".image-box").show()
    })
    
    $(document).on("mouseleave", "#stops-sec .box", function() {
        added = false
        $(".image-box").remove()
    })
})

function SetRoutes(routes){
    $("#routes").empty();
    $("#routes-sec .counter").text(String("0").padStart(2, "0"))

    routes.forEach((route, i) => {
        $("#routes").append(`
        <div class="box ${route.Level > level ? "disabled" : ""}" data-id="${i+1}">
            <div class="box-header">
                <div class="item">CLICK TO START</div>
                <div class="item salary">SALARY <span>${route.Salary}</span></div>
                <div class="item title"><img src="assets/road.png">LEVEL <span>${String(route.Level).padStart(2, "0")}</span></div>
            </div>
            <div class="box-content">ROUTE <span>${route.RouteName}</span></div>
        </div>`);

        $("#routes-sec .counter").text(String(i+1).padStart(2, "0"))
    });
}

function SetOldMissions(oldroutes){
    $("#old-routes").empty();
    $("#expedition .counter").text(String("0").padStart(2, "0"))

    oldroutes.forEach((route, i) => {
        $("#old-routes").prepend(`
        <div class="box">
            <div class="box-header">
                <div class="item title"><img src="assets/clock.png">${route.date}</div>
            </div>
            <div class="box-content">ROUTE <span>${route.routeName}</span></div>
        </div> `);

        $("#expedition .counter").text(String(i+1).padStart(2, "0"))
    });
}

function SetActiveWorkers(workers){
    $("#workers").empty();
    $("#workers-sec .counter").text(String("0").padStart(2, "0"))

    workers.forEach((worker, i) => {
        $("#workers").prepend(`
        <div class="user">
            <div class="name-wrapper">
                <div class="name">${worker.name}</div>
                <div class="current-place">CURRENTLY ON <span>${worker.place}</span></div>
            </div>
            <div class="pp"><img src="${worker.avatar}"></div>
        </div>`);

        $("#workers-sec .counter").text(String(i+1).padStart(2, "0"))
    });
}

$(window).on("keydown", function ({ originalEvent: { key } }) {
    if (key == "Escape") {
        $.post(`https://${GetParentResourceName()}/close`)
        $("main").fadeOut("fast")
        $("main").css("display", "flex")
        $("#stops-sec").fadeOut(200)
    }
})
