
var currentvalue = 0
var currenttextture = 0
var storepricejs = 0
var notifyon = false;

window.addEventListener("message", function (event) {  
    if (event.data.action == "barberopen"){
        var data = event.data.maxvalue;
        $('.storehairmenu').fadeOut(0);
        // $('#hairmenu').fadeIn(0);
        // $(".storeleftmenu_item").removeClass("hover");
        // $("#hairmenuid").addClass("hover");

        $('.storeall').fadeIn(300);
        $(".storerightmenu_bottom1_text2").html("$"+formatMoney(event.data.storeprice))
        storepricejs = Number(event.data.storeprice);
        checkmenus(event.data.categoryset);
        setplayervalues(event.data.playerinfos);
        for (const key in data) {
            if (Object.hasOwnProperty.call(data, key)) {
                const element = data[key];
               
                $('#'+String(key)).attr({ "max" : element, "min" : 0 });
            }
        }
        
    }

    if (event.data.action == "maxrefresh"){
        for (const key in data) {
            if (Object.hasOwnProperty.call(data, key)) {
                const element = data[key];
               
                $('#'+String(key)).attr({ "max" : element, "min" : 0 });
            }
        }
    }


    if (event.data.action == "colors"){
        setuphaircolors(event.data.hairColors);
    }

    if (event.data.action == "closestore"){
        $('.storeall').fadeOut(300);
    }
  
    if (event.data.action == "notify"){
        notifyfuntion(event.data.notifytext, event.data.time);
    }


    if( event.data.action == "tattoinfo"){
        $('#ZONE_HEAD').attr({ "max" : Number(event.data.tattodata.ZONE_HEAD.length), "min" : 1 });
        $('#ZONE_LEFT_LEG').attr({ "max" : Number(event.data.tattodata.ZONE_LEFT_LEG.length), "min" : 1 });
        $('#ZONE_LEFT_ARM').attr({ "max" : Number(event.data.tattodata.ZONE_LEFT_ARM.length), "min" : 1 });
        $('#ZONE_RIGHT_LEG').attr({ "max" : Number(event.data.tattodata.ZONE_RIGHT_LEG.length), "min" : 1 });
        $('#ZONE_TORSO').attr({ "max" : Number(event.data.tattodata.ZONE_TORSO.length), "min" : 1 });
        $('#ZONE_RIGHT_ARM').attr({ "max" : Number(event.data.tattodata.ZONE_RIGHT_ARM.length), "min" : 1 });


       
    }
});


function setplayervalues(data){
    for (const key in data) {
        if (Object.hasOwnProperty.call(data, key)) {
            const element = data[key];
           
            $('#'+String(key)).val(element);
            $('#'+String(key)+"_text").html(Number(Math.trunc(element)));
          
        }
    }
}


function notifyfuntion(text,time) {
    if (notifyon == false){
       $('.notify').fadeIn(300);
       $('.notify').html("⚠️"+" "+text);
       notifyon = true;
 
       setTimeout(() => {
          $('.notify').fadeOut(300);
          notifyon = false;
       }, Number(time));
    }
 }


function checkmenus(datas){
   for (const key in datas) {
    if (Object.hasOwnProperty.call(datas, key)) {
        const element = datas[key];
        if (key == "hair"){
            if (element == false){
              $('#hairmenuid').fadeOut(0);
            }else if(element == true){
              $('#hairmenuid').fadeIn(0);

            }
        }else if(key == "bread"){
            if (element == false){
                $('#beardmenuid').fadeOut(0);
            }else if(element == true){
                $('#beardmenuid').fadeIn(0);
            }
        }else if(key == "makeup"){
            if (element == false){
                $('#makeupmenuid').fadeOut(0);
            }else if(element == true){
                $('#makeupmenuid').fadeIn(0);
            }
        }else if(key == "tattoo"){
            if (element == false){
                $('#tattoomenuid').fadeOut(0);
            }else if(element == true){
                $('#tattoomenuid').fadeIn(0);
  
            }

        }
        
    }
   }
}

function menuopenclick(data){
    if (data == "hairmenu"){
 
        $('.storehairmenu').fadeOut(200);
        $('#hairmenu').fadeIn(500);
    }else if(data == "beardmenu"){
        $('.storehairmenu').fadeOut(200);
        $('#beardmenu').fadeIn(500);
    }else if(data == "makeupmenu"){
        $('.storehairmenu').fadeOut(200);
        $('#makeupmenu').fadeIn(500);
    }else if(data == "tattoomenu"){
        $('.storehairmenu').fadeOut(200);
        $('#tattoomenu').fadeIn(500);

    }

    $(".storeleftmenu_item").removeClass("hover");
    $("#"+data+"id").addClass("hover");

}

function setuphaircolors (data){
   
    $('.storehairmenu_category_empty_colorpart').html('');
    for (var i = 0; i < Object.keys(data).length; i++) {
        var color = data[i][0]+","+data[i][1]+","+data[i][2]
        
        $('.storehairmenu_category_empty_colorpart').append('<div data-value="'+i+'" class="storehairmenu_category_empty_colorpart_item" style="background: linear-gradient(45deg, rgba('+color+') 0%, rgba(151, 82, 43, 0) 100%); border: 1px solid rgba('+color+');"></div>');

    }

    clicksetup();
}

function clicksetup(){
    $( ".storehairmenu_category_empty_colorpart_item" ).each( function( i, obj ) {
    
 
        $( this ).click( function() { 
            var data = $( this ).data( "value" ); 
            var ssss = $(this).parents('.storehairmenu_category_empty_colorpart').attr('id')
            
            $.post('https://ex_bertatstore/colorchange', JSON.stringify({
                colortype : ssss,
                value : data
              
            }));

        })
    
        
     });
}


function changeinput(thiss){
    var value = (thiss.value-thiss.min)/(thiss.max-thiss.min)*100

   

    $('#'+thiss.id+"_text").html(Number(Math.trunc(thiss.value)));

    currentvalue = thiss.value;

    $.post('https://ex_bertatstore/change', JSON.stringify({
        value : currentvalue,
        typename : thiss.id
        // texture : currenttextture
    }));

    thiss.style.background = 'linear-gradient(to right, #FF0642 0%, #FF0642 ' + value + '%, rgba(217, 217, 217, 0.15) ' + value + '%, rgba(217, 217, 217, 0.15) 100%)'
}




var inrotate = false;

$('.rotatediv').keydown(function() {
   if(!$(this).data('timeDown')) { // if not pressed yet, save time
       $(this).data('timeDown', +new Date);
   }
}).keyup(function() {
   var diff = new Date - $(this).data('timeDown'); // time difference
   if(diff < 1000) { // less than one second
       alert(123);
   }
   $(this).data('timeDown', null); // reset time
});


$(".rotatediv").on({
   mouseenter: function (e) {
    
      $('.rotatetext_all').fadeIn(200);
      inrotate = true;
   },
   mouseleave: function () {
       //stuff to do on mouse leave
       $('.rotatetext_all').fadeOut(200);
      inrotate = false;

   }
});


var openrotate = false;

$('.rotatediv').mousedown(function(e) {
   if (e.which === 3) {
      
      $.post('https://ex_bertatstore/rotate', JSON.stringify({key: "left"}))
   }

   if (e.which === 1) {
      
      $.post('https://ex_bertatstore/rotate', JSON.stringify({key: "right"}))
   }
});


function camerachange(){
    $.post('https://ex_bertatstore/camerachange', JSON.stringify());
}


function cleartattoo(){
    $.post('https://ex_bertatstore/cleartattoo', JSON.stringify());
}

function formatMoney(number, decPlaces, decSep, thouSep) {
    decPlaces = isNaN(decPlaces = Math.abs(decPlaces)) ? 2 : decPlaces,
    decSep = typeof decSep === "undefined" ? "." : decSep;
    thouSep = typeof thouSep === "undefined" ? "," : thouSep;
    var sign = number < 0 ? "-" : "";
    var i = String(parseInt(number = Math.abs(Number(number) || 0).toFixed(decPlaces)));
    var j = (j = i.length) > 3 ? j % 3 : 0;
 
    return sign +
        (j ? i.substr(0, j) + thouSep : "") +
        i.substr(j).replace(/(\decSep{3})(?=\decSep)/g, "$1" + thouSep) +
        (decPlaces ? decSep + Math.abs(number - i).toFixed(decPlaces).slice(2) : "");
}

function exitstore(){
    $.post('https://ex_bertatstore/exitstore', JSON.stringify({}));
}


 function clearwear(){
    $.post('https://ex_bertatstore/takeonoff', JSON.stringify({}));

 }



 function bankpay(){
    currentpaytype = "bank";
    $.post('https://ex_bertatstore/pay', JSON.stringify({
       data :"bank",
       price : storepricejs
   }));
 }
 
 function walletpay(){
    currentpaytype = "cash";
 
    $.post('https://ex_bertatstore/pay', JSON.stringify({
       data :"cash",
       price : storepricejs
   }));
 }


function changetattoo(thiss){
    var value = (thiss.value-thiss.min)/(thiss.max-thiss.min)*100

   

    $('#'+thiss.id+"_TEXT").html(Number(Math.trunc(thiss.value)));

    currentvalue = thiss.value;

    $.post('https://ex_bertatstore/changetattoo', JSON.stringify({
        value : currentvalue,
        typename : thiss.id
        // texture : currenttextture
    }));

    thiss.style.background = 'linear-gradient(to right, #FF0642 0%, #FF0642 ' + value + '%, rgba(217, 217, 217, 0.15) ' + value + '%, rgba(217, 217, 217, 0.15) 100%)'
}
