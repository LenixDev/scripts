$(".continer").hide()


window.addEventListener("message", function (event) { 
    
    if(event.data.action == "open"){
        $(".continer").show()
        $(".continer-name").html(event.data.title)
        $(".hero-p").html(event.data.des)
    } 
    if(event.data.action == "close"){
    $(".continer").hide()
    }
})


function lockpickbutton(name){
    $.post(`https://${GetParentResourceName()}/givelockpick`, JSON.stringify({ item: name}));
}


function cancel(){
    $.post( `https://${GetParentResourceName()}/cancel`, JSON.stringify({}));
}

// $.post( `https://${GetParentResourceName()}/callsignchange`, JSON.stringify({}));