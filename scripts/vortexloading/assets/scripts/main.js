$("#read-more").on("click", function() {
    let newHeight = $(".information .description > p").height();

    $("#collapse").fadeIn(150);
    $(this).fadeOut(150);

    $(".information .description").css("height", newHeight + "px")
})

$("#collapse").on("click", function() {
    $("#read-more").fadeIn(150);
    $(this).fadeOut(150);

    $(".information .description").css("height", "");
})

$(".hideoverlay .bind").html(Config.CustomBindText == "" ? String.fromCharCode(Config.HideoverlayKeybind).toUpperCase() : Config.CustomBindText)

$(document).on('mousemove', function(e) {
    $('#cursor').css({top: e.pageY + 'px', left: e.pageX + 'px'});
});

var overlay = true;
$(document).keydown(function(e) {
    if(e.which == Config.HideoverlayKeybind) {
        overlay = !overlay;
        if(!overlay) {
            $(".overlay").css("opacity", ".0")
            $(".bg").css("filter", "none");
        } else {
            $(".overlay").css("opacity", "")
            $(".bg").css("filter", "");
        }
    }
})

function setup() {
    // Socials
    Config.Socials.forEach((social, index) => {
        $(".socials .buttons").append(`<a href="#" data-link="${social.link}" data-id="${index}"><img src="${social.icon}"></a>`)
    });

    var copyTimeouts = {};
    $(".socials .buttons a").on("click", function() {
        let id = $(this).data("id")
        let link = $(this).data("link")
        if(copyTimeouts[id]) clearTimeout(copyTimeouts[id]);

        copyToClipboard(link)

        $(this).addClass("copied");
        copyTimeouts[id] = setTimeout(() => {
            $(this).removeClass("copied")
            copyTimeouts[id] = undefined;
        }, 1000);
    })

    // Carousel
    Config.Team.forEach((member, index) => {
        $(".team .innercards").append(`<div class="card" data-id="${index}" style="--color: ${member.color}">
            <p class="name">${member.name}</p>
            <p class="description">${member.description}</p>
            <img class="avatar" src="${member.image}">
        </div>`);
        if(index < Config.Team.length - 1) {
            $(".team .pages").append(`<div data-id="${index}"></div>`);
        }
        $(`.team .pages > div[data-id="0"]`).addClass("active")

        if(Config.Team.length < 3) {
            $(".team .pages").hide();
            $(".team .previous").hide();
            $(".team .next").hide();
        }
    })

    var currentPage = 0;
    $(".team .next").on("click", function() {
        if(currentPage < Config.Team.length - 2) {
            $(`.team .pages > div[data-id="${currentPage}"]`).removeClass("active")
            currentPage++
            $(`.team .pages > div[data-id="${currentPage}"]`).addClass("active")
            $(".team .innercards").css("transform", `translate3d(calc(-${currentPage * 50}% - ${(currentPage+1) * .7}vw), 0, 0)`)
        }
    });

    $(".team .previous").on("click", function() {
        if(currentPage > 0) {
            $(`.team .pages > div[data-id="${currentPage}"]`).removeClass("active")
            currentPage--
            $(`.team .pages > div[data-id="${currentPage}"]`).addClass("active")
            $(".team .innercards").css("transform", `translate3d(calc(-${currentPage * 50}% - ${(currentPage+1) * .7}vw), 0, 0)`)
        }
    });
}

function loadProgress(progress) {
    $(".loader .filled-logo").css("height", progress + "%");
    $(".loader .progress").html(progress + "%");
}

window.addEventListener('message', function(e) {
    if(e.data.eventName === 'loadProgress') {
        loadProgress(parseInt(e.data.loadFraction * 100));
    }
});

var tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

var player;
var muted = false;
function onYouTubeIframeAPIReady() {
    player = new YT.Player("youtube-player", {
        events: {
            'onReady': onPlayerReady
        }
    });
}

function onPlayerReady() {
    $('#sounds').on("change", function(){
        muted = !muted;
        if(muted)
            player.mute();
        else
            player.unMute();
    });
}

function copyToClipboard(text) {
    const body = document.querySelector('body');
    const area = document.createElement('textarea');
    body.appendChild(area);
  
    area.value = text;
    area.select();
    document.execCommand('copy');
  
    body.removeChild(area);
}

setup();