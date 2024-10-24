$(".continer").hide()


window.addEventListener("message", function (event) { 
    
    if(event.data.action == "open"){
        $(".continer").show()
        $(".continer-name").html(event.data.title)
        $(".CA-p").html(event.data.des)
    } 
    if(event.data.action == "close"){
    $(".continer").hide()
    }
})


function key1(name){
    $.post(`https://${GetParentResourceName()}/givekey1`, JSON.stringify({ item: name}));
}

function drill(name){
    $.post(`https://${GetParentResourceName()}/givedrill`, JSON.stringify({ item: name}));
}

function armor(name){
    $.post(`https://${GetParentResourceName()}/givearmor`, JSON.stringify({ item: name}));
}

function weapon_pistol_mk2(name){
    $.post(`https://${GetParentResourceName()}/giveweapon_pistol_mk2`, JSON.stringify({ item: name}));
}

function pistol_ammo(name){
    $.post(`https://${GetParentResourceName()}/givepistol_ammo`, JSON.stringify({ item: name}));
}

function smg_ammo(name){
    $.post(`https://${GetParentResourceName()}/givesmg_ammo`, JSON.stringify({ item: name}));
}

function rifle_ammo(name){
    $.post(`https://${GetParentResourceName()}/giverifle_ammo`, JSON.stringify({ item: name}));
}

function cancel(){
    $.post( `https://${GetParentResourceName()}/cancel`, JSON.stringify({}));
}