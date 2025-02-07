let squadCount = 0;
let maxSquadCount = 0;

$(function() {
    $.post(`https://${GetParentResourceName()}/loaded`);

    window.addEventListener("message", function(event) {
        let edata = event.data;
        let action = edata.action;

        if (action == "openMenu"){
            $.post(`https://${GetParentResourceName()}/getPlayerData`, JSON.stringify({}), function(data){
                squadCount = 0;
                maxSquadCount = 0;
                let level = Math.floor(data.exp / 100);
                $("#playerName").html(data.name);
                $("#playerImage").attr("src", data.image);
                $("#playerLevel").html(level + " Level");
                $("#toggle-invite-input").prop("checked", data.invites);
                $(".start-btn").removeClass("disabled");
                $(".missions").removeClass("disabled");
                ResetSquad(edata.squad, edata.isLeader)

                $(".missions").html("")

                for (let i = 0; i < data.missions.length; i++){
                    let diffHtml = "";

                    for (let j = 0; j < 3; j++){
                        if (data.missions[i].Difficulty <= j){
                            diffHtml += `<div class="box"></div>`
                        } else {
                            if (data.missions[i].Difficulty == 2){
                                diffHtml += `<div class="box active" style="background:#FFC120;"></div>`
                            }else if (data.missions[i].Difficulty == 3){
                                diffHtml += `<div class="box active" style="background:#FF2E00;"></div>`
                            }else{
                                diffHtml += `<div class="box active"></div>`
                            }
                        }
                    }

                    if (level >= data.missions[i].Level){
                        $(".missions").append(`
                        <div class="mission" data-max="${data.missions[i].MaxMembers}">
                            <div class="mission-image">
                                <div class="overlay"></div>
                                <img src="${data.missions[i].Image}" class="img">
                            </div>
                            <div class="mission-title-wrapper">
                                <div class="title">${data.missions[i].Name}</div>
                                <div class="subtitle">${data.missions[i].Description}</div>
                            </div>
                            <div class="mission-details-wrapper">
                                <div class="details">
                                    <div class="detail level">
                                        <div class="title">${data.missions[i].Level}</div>
                                        <div class="subtitle">Level</div>
                                    </div>
                                    <div class="detail members">
                                        <div class="title">${data.missions[i].MinMembers}-${data.missions[i].MaxMembers}</div>
                                        <div class="subtitle">Members</div>
                                    </div>
                                    <div class="detail salary">
                                        <div class="title">$${Math.round(data.missions[i].Salary) / 1000}k</div>
                                        <div class="subtitle">Salary</div>
                                    </div>
                                </div>
        
                                <div class="difficulties">
                                    ${diffHtml}
                                </div>
                            </div>
                        </div>
                        `)
                    }else{
                        $(".missions").append(`
                        <div class="mission locked">
                            <div class="mission-image">
                                <div class="overlay"></div>
                                <img src="${data.missions[i].Image}" class="img">
                            </div>
                            <div class="mission-title-wrapper">
                                <img src="assets/lock.png" class="icon">
                                <div class="locked-text">LOCKED / ${data.missions[i].Level} LEVEL REQ</div>
                                <div class="title">${data.missions[i].Name}</div>
                                <div class="subtitle">${data.missions[i].Description}</div>
                            </div>
                            <div class="mission-details-wrapper">
                                <div class="difficulties">
                                    ${diffHtml}
                                </div>
                            </div>
                        </div>
                        `)
                    }
                }

                $("body").fadeIn(150);
            });
        }

        if(action == "closeMenu"){
            $("body").fadeOut(150);
        }

        if(action == "refreshSquads"){
            ResetSquad(edata.squad, edata.isLeader)
        }
    })

    $(document).on("click", ".mission", function(){
        if ($(this).data("max") - squadCount > 0){
            maxSquadCount = $(this).data("max");
            $(".mission").removeClass("active");
            $(this).addClass("active");
            SetMaxSquadMembers($(this).data("max"))
        }
    })

    $(document).on("click", ".kick-btn", function(){
        let license = $(this).data("license")
        $.post(`https://${GetParentResourceName()}/kickPlayer`, JSON.stringify(license))
    })

    $(document).on("click", ".invite-btn", function(){
        $(".input-wrapper").fadeIn(150);
        $(".box-1").show();
        $(".box-2").hide();
        $(".input-wrapper").css("display", "flex");
        $(".input-wrapper #invite-input").val("");
    })

    $(document).on("click", "#invite-btn", function(){
        $.post(`https://${GetParentResourceName()}/sendInvite`, JSON.stringify($(".input-wrapper #invite-input").val()), function(cb){
            $(".input-wrapper").fadeOut(150);
        });
    })

    $(document).on("click", ".change-pp-btn", function(){
        $(".input-wrapper").fadeIn(150);
        $(".box-2").show();
        $(".box-1").hide();
        $(".input-wrapper").css("display", "flex");
        $(".input-wrapper #change-input").val("");
    })

    $(document).on("click", "#change-btn", function(){
        $.post(`https://${GetParentResourceName()}/changeImage`, JSON.stringify($(".input-wrapper #change-input").val()), function(cb){
            $(".input-wrapper").fadeOut(150);
            $("body").fadeOut(150);
        });
    })

    $(document).on("click", ".start-btn", function(){
        if ($(".mission.active").length == 0) return;
        $.post(`https://${GetParentResourceName()}/startMission`, JSON.stringify({id: $(".mission.active").index(), members: squadCount}), function(cb){
            if (cb){
                $("body").fadeOut(150);
            }
        });
    })

    $(".closebtn").click(function(){
        $(".input-wrapper").fadeOut(150);
    })

    $("#close").click(function(){
        $("body").fadeOut(150);
        $.post(`https://${GetParentResourceName()}/close`);
    })

    $("#toggle-invite-input").change(function(){
        $.post(`https://${GetParentResourceName()}/toggleInvite`, JSON.stringify($(this).prop("checked")));
    })
})

function SetMaxSquadMembers(maxx){
    $(".invite-btn").remove()
    let max = maxx - squadCount;
    for (let i = 0; i < max - 1; i++){
        $(".squad-members").append(`
            <div class="invite-btn">
                <img src="assets/invite-icon.png" class="icon">
                <div class="text">Invite Player</div>
                <img src="assets/invite-btn.png" class="btn">
            </div>
        `)
    }
}

function ResetSquad(data, isLeader){
    let leader = data.leader
    $(".squad-members").html("")
    $(".squad-members").append(`
        <div class="member">
            <div class="member-box">
                <div class="image-wrapper">
                    <img src="${leader?.image || ""}" class="pp">
                    <img src="assets/pp-box-s.png" class="box">
                </div>
                <div class="info-wrapper">
                    <div class="title-wrapper">
                        <div class="title">Nickname</div>
                        <div class="level-wrapper">
                            <img src="assets/level-icon.png">
                            <div class="level">${Math.floor(leader.exp / 100)} Level</div>
                        </div>
                    </div>
                    <div class="name">${leader.name}</div>
                </div>
            </div>
        </div>
    `)

    squadCount = data.members.length || 0;

    data.members.forEach(member => {
        let image = member.image
        let name = member.name
        let exp = Math.floor(member.exp / 100)

        $(".squad-members").append(`
        <div class="member">
            <div class="member-box" ${!isLeader ? 'style="width: 100%"' : ""}>
                <div class="image-wrapper">
                    <img src="${image}" class="pp">
                    <img src="assets/pp-box-s.png" class="box">
                </div>
                <div class="info-wrapper">
                    <div class="title-wrapper">
                        <div class="title">Nickname</div>
                        <div class="level-wrapper">
                            <img src="assets/level-icon.png">
                            <div class="level">${Math.floor(exp / 100)} Level</div>
                        </div>
                    </div>
                    <div class="name">${name}</div>
                </div>
            </div>
            ${isLeader ? `
            <div class="kick-btn" data-license="${member.license}">
                <img src="assets/kick-btn.png">
            </div>
            ` : ""}
            
        </div>
    `)
    });

    if (!isLeader){
        $(".start-btn").addClass("disabled");
        $(".missions").addClass("disabled");
        $(".invite-btn").css("display", "none");
    }

    SetMaxSquadMembers(maxSquadCount)

    document.onkeyup = function(data){
        if (data.which == 27){
            $("body").fadeOut(150);
            $.post(`https://${GetParentResourceName()}/close`);
        }
    }
}

function checkImage(url) {
    var request = new XMLHttpRequest();
    request.open("GET", url, true);
    request.send();
    request.onload = function() {
    status = request.status;
    if (request.status == 200)
        {
            return true;
        } else {
            return false;
        }
    }

    return false;
}