

var currentcompanents ;
var notifyon = false;
var wardrobeon = false;
window.addEventListener("message", function (event) {    
   if (event.data.action == "storeopen"){
      
      $('.storeall').fadeIn(500);
      controlmenu(event.data.states);
      ordercheck(event.data.orderlist);
      currentcompanents = event.data.companents;
      $("#totalinsert").html("$"+formatMoney(event.data.totalmoney));
      $(".storeleftmenu_item").removeClass("hover");
   }

   if (event.data.action == "texturenui"){
 
      $("#doktortexture").attr({ "max" : event.data.texturesimiz, "min" : 0 });
      texturemax = event.data.texturesimiz;
      // $('#doktortexture').html("0");
      $("#doktortexture").val(0);
   }

   if (event.data.action == "refreshorder"){
      ordercheck(event.data.orderlist);
      $("#totalinsert").html("$"+formatMoney(event.data.totalmoney))
   }

   if (event.data.action == "closestore"){
      $('.storetexture').fadeOut(0);
      $('.askforsave').fadeOut(0);
      $('.storeall').fadeOut(500);
      $('.storeleftmenuclothingpart').fadeOut(0);
   }

   if (event.data.action == "opensavepart"){
      $('.askforsave').fadeIn(300);
   }

   if (event.data.action == "wardrobeopen"){
      $('.wardrobe_all').fadeIn(300);
      writeward(event.data.wardrobeinfo);
      wardrobeon = true;
   }


   if (event.data.action == "rewardrobe"){
      writeward(event.data.wardrobeinfo);

   }

   if (event.data.action == "notify"){
       notifyfuntion(event.data.notifytext, event.data.time);
   }
});

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


function writeward(data){
   $('.wardromain_item_list').html('');

   for (let i = 0; i < data.length; i++) {
      const element = data[i];

      $('.wardromain_item_list').append('<div class="wardromain_item_list_item"> <div class="wardromain_item_list_item_name">👒 '+element.name+'</div> <div class="wardromain_item_list_item_use" data-wardid = "'+(i+1)+'">USE</div> <div class="wardromain_item_list_item_cancel" data-wardid = "'+(i+1)+'">DELETE</div> </div>');
      
   }

   writewardclick();
}

function writewardclick(){
   $( ".wardromain_item_list_item_use" ).each( function( i, obj ) {



    
      $( this ).click( function() { 
          var data = $( this ).data( "wardid" ); 


          $.post('https://ex_clothingstore/useward', JSON.stringify({
            wardid : data
          }));

          $('.wardrobe_all').fadeOut(300);
          wardrobeon = false;


      
       
      
      })

   });

   $( ".wardromain_item_list_item_cancel" ).each( function( i, obj ) {



    
      $( this ).click( function() { 
          var data = $( this ).data( "wardid" ); 


          $.post('https://ex_clothingstore/deleteward', JSON.stringify({
            wardid : data
          }));

      
       
      
      })

   });
}


function ordercheck(data){
   $('.storerightmenu_center').html('');
  for (let i = 0; i < data.length; i++) {
   const element = data[i];
   $('.storerightmenu_center').append('<div class="storerightmenu_center_item"> <div class="storerightmenu_center_item_img"><img src="bill.svg" alt=""></div> <div class="storerightmenu_center_item_text">'+element.itemname+'</div> <div class="storerightmenu_center_item_text2">Price: <div style="color:#3AFF89; width: 100%; margin-left:5px; ">$ '+formatMoney(element.itemprice)+'</div></div> <div class="storerightmenu_center_item_remove" data-deleteorder = "'+(i+1)+'"> <img src="remove.svg" alt="" style="margin: 5px;"> </div> </div>');
   
  }

  deleteorder();
}

function clearprop(){
   $.post('https://ex_clothingstore/clearprop', JSON.stringify());
}

function camerachange(){
   $.post('https://ex_clothingstore/camerachange', JSON.stringify());
}


function deleteorder(){
   $( ".storerightmenu_center_item_remove" ).each( function( i, obj ) {



    
      $( this ).click( function() { 
          var data = $( this ).data( "deleteorder" ); 


          $.post('https://ex_clothingstore/deleteorder', JSON.stringify(data));

      
       
      
      })

});
}

function controlmenu(data){
   for (const key in data) {
      if (Object.hasOwnProperty.call(data, key)) {
         const element = data[key];
         if (element){
            $('#'+key).fadeIn(0);
         }else{
            $('#'+key).fadeOut(0);

         }
         
      }
   }
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

function menuclick(data){
   $('.storeleftmenuclothingpart').fadeOut(200);
   $(".storeleftmenu_item").removeClass("hover");
   $("#"+data).addClass("hover");
   setTimeout(() => {
   $('.storeleftmenuclothingpart').html('');
   for (let index = 0; index < currentcompanents[data].length; index++) {
      const element =  currentcompanents[data][index];
      const actionum = JSON.stringify(element)
      $('.storeleftmenuclothingpart').append('<div class="storeleftmenuclothingpart_item" > <div class="storeleftmenuclothingpart_item_img" data-kid = "'+index+'"> <img src="'+element.itemimage+'" alt="" style = "max-width: 100%; max-height: 100%;"> </div> <div class="storeleftmenuclothingpart_item_text">'+element.itemname+'</div> <div class="storeleftmenuclothingpart_item_bottom"> <div class="storeleftmenuclothingpart_item_bottom_1"> <div style="margin-top: 3px; opacity:0.5;">$ '+formatMoney(element.itemprice)+'</div> </div> <div class="storeleftmenuclothingpart_item_bottom_2" data-cid = "'+index+'"> <img src="sepet.svg" alt="" style="margin-left: 7px; margin-top:6px; opacity:0.5;"> </div> </div> </div>')
      $('.storeleftmenuclothingpart_item_bottom_2[data-cid='+index+']').attr({"data-clothingvalues": actionum});
      $('.storeleftmenuclothingpart_item_img[data-kid='+index+']').attr({"data-clothingvalues": actionum});
   }

   
   clothingshow();
   $('.storeleftmenuclothingpart').fadeIn(200)
      
   }, 300);
}


function clothingshow(){
   $( ".storeleftmenuclothingpart_item_img" ).each( function( i, obj ) {



    
         $( this ).click( function() { 
             var data = $( this ).data( "clothingvalues" ); 
             $('.storetexture').fadeIn(200);
            //  console.log(JSON.stringify(data))
             texturename = data.itemvaluename;
             clothingvalue = data.itemvalue;
             clothingprice = data.itemprice;

             $.post('https://ex_clothingstore/showthiscloth', JSON.stringify(data));

         
          
         
         })
 
   });


   $( ".storeleftmenuclothingpart_item_bottom_2" ).each( function( i, obj ) {

    
      $( this ).click( function() { 
          var data = $( this ).data( "clothingvalues" ); 
         

          $.post('https://ex_clothingstore/addinorder', JSON.stringify(
            {
              orderinfo1:data,
              orderinfo2:$("#doktortexture").val()
            }
          ));

      
      })

   });
}



function changetexture(type){
    var currenttextureval = $("#doktortexture").val();
   if (type == "left"){
    var newdeger = currenttextureval - 1
    if (newdeger < 0 ){
      $("#doktortexture").val(0);
    }else{
      $("#doktortexture").val(newdeger);

    }

    $.post('https://ex_clothingstore/texturechange', JSON.stringify({
         clothingtype : texturename,
         texturevalue :  $("#doktortexture").val(),
         clothingvalue : clothingvalue
               
       }));
   }else if (type == "right"){
      // console.log(currenttextureval)
      var newdeger = Number(currenttextureval) + 1
      if (Number(newdeger) > Number(texturemax) ){
        $("#doktortexture").val(Number(texturemax));
      }else{
        $("#doktortexture").val(Number(newdeger));
  
      }

      $.post('https://ex_clothingstore/texturechange', JSON.stringify({
         clothingtype : texturename,
         texturevalue :  $("#doktortexture").val(),
         clothingvalue : clothingvalue
               
       }));


   }

}


function bankpay(){
   currentpaytype = "bank";
   $.post('https://ex_clothingstore/pay', JSON.stringify({
      data :"bank"
  }));
}

function walletpay(){
   currentpaytype = "cash";

   $.post('https://ex_clothingstore/pay', JSON.stringify({
      data :"cash"
  }));
}


function exitstore(){
   $.post('https://ex_clothingstore/exitstore', JSON.stringify({}));
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

// var $circle = $('.rotatetext_all');

// function moveCircle(e) {
//   if (inrotate == true){
//       TweenLite.to($circle, 0.1, {
//       css: {
//          left: e.pageX -840,
//          top: e.pageY - 300
//       }
//    });
// }
// }

// $(".rotatediv").on('mousemove', moveCircle);

var openrotate = false;

$('.rotatediv').mousedown(function(e) {
   if (e.which === 3) {
      
      $.post('https://ex_clothingstore/rotate', JSON.stringify({key: "left"}))
   }

   if (e.which === 1) {
      
      $.post('https://ex_clothingstore/rotate', JSON.stringify({key: "right"}))
   }
});


function yesavego() {
   var writetext = $('#emreid').val();
   if (writetext.length > 0){
      $.post('https://ex_clothingstore/pay3', JSON.stringify({
         data :currentpaytype,
         wardrobename : writetext
     }));

     $('#emreid').val('');
   }else{
      notifyfuntion("You need enter name", 2000);
   }
  
}


function nosavego() {
   $.post('https://ex_clothingstore/pay2', JSON.stringify({
      data :currentpaytype
  }));
}


$(document).keyup(function(e) {
   if (e.key === "Escape") { 
      if (wardrobeon == true){
         $('.wardrobe_all').fadeOut(300);
         $.post('https://ex_clothingstore/closenuiward', JSON.stringify({
            
         }));
         wardrobeon = false;
      }
        
   }
})