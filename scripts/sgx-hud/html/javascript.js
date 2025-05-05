(() => {
    QBHud = {};

    QBHud.UpdateCarHud = function(data) {
        // Update the displayed speed with a formatted value
        var roundedSpeed = Math.round(data.speed);
        var speedStr = roundedSpeed.toString().padStart(3, '0');

        // Check if the current vehicle is a plane or helicopter
        var isHelicopter = data.vehicleType === 'Helicopter';
        var isPlane = data.vehicleType === 'Plane';

        this.harness = data.harness;

        // Determine the speed unit based on the vehicle type
        var speedUnit = (isHelicopter || isPlane) ? 'ALT' : (data.speedType ? 'MPH' : 'KPH');

        $(".speedtype").html(speedUnit);

        var nonZeroEncountered = false;
        var speedHtml = "";

        for (var i = 0; i < speedStr.length; i++) {
            if (speedStr[i] !== '0') {
                nonZeroEncountered = true;
            }
            if (nonZeroEncountered) {
                speedHtml += '<span style="color: white; text-shadow: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000, 1px 1px 0 #000;">' + speedStr[i] + '</span>';
            } else {
                speedHtml += '<span style="color: #5a5a5a;">' + speedStr[i] + '</span>';
            }
        }

        $(".speed").html(speedHtml);

        if (speedStr.length === 4) {
            $(".speed").css({
                "font-size": "4vh",
                "padding": ".85vh",
                "bottom": "4.9vh",
                "left": "-.5vh",
            });
        } else {
            $(".speed").css({
                "font-size": "",
                "padding": "",
                "bottom": "",
                "left": "",
            });
        }
        // $(".harnesshud ").fadeOut()

        $(".fuel").find('.fillbar').css("height", data.fuel + "%");

        previousSpeed = roundedSpeed;

        if (data.fuel >= 0 && data.fuel <= 30) {
            $(".fuel .barfill").css("background", "#cc4d53")
        } else {
            $(".fuel .barfill").css("background", "white")
        }

        if (data.engine >= 50 && data.engine <= 100) {
            $(".enginehud").fadeOut(0)
            $(".engine .barfill").css("background", "white");
        } else if (data.engine >= 20 && data.engine <= 50) {
            $(".enginehud").fadeIn(0)
            $(".engine .barfill").css("background", "#cc8c4d");
        } else if (data.engine >= 0 && data.engine <= 20) {
            $(".engine .barfill").css("background", "#cc4d53");
        }   
        
        if (data.harness === true) {
            $(".harnesshud").fadeIn(200)
        } else {
            $(".harnesshud").fadeOut(200)
        }
    };

    QBHud.UpdateHud = function(data) {
        $(".health").find('.barfill').css("width", data.health + "%");
        $(".armor").find('.barfill').css("width", data.armor + "%");
        $(".hunger").find('.barfill').css("width", data.hunger + "%");
        $(".thirst").find('.barfill').css("width", data.thirst + "%");
        $(".stress").find('.barfill').css("width", data.stress + "%");
        $(".nitrous").find('.barfill').css("width", data.nitrous + "%");
        $(".oxygen").find('.barfill').css("width", data.oxygen + "%");
        $(".sprint").find('.barfill').css("width", data.stamina + "%");
        $("#cash").html("$" + data.cash);
        $("#bank").html("$" + data.bank);
        $('.compassstreetname').html(data.street);
        $('.compasslocation').html(data.zones);
        

        if (data.engine >= 0 && data.engine <= 30) {
            $(".vehicleoil").show(200);
        } else {
            $(".vehicleoil").hide(200);
        }

        if (data.hunger >= 0 && data.hunger <= 95) {
            $(".borderhudhunger").fadeIn(200);
        } else {
            $(".borderhudhunger").fadeOut(200);
        }

        if (data.thirst >= 0 && data.thirst <= 95) {
            $(".borderhudthirst").fadeIn(200);
        } else {
            $(".borderhudthirst").fadeOut(200);
        }
        
        showHealth = function() {
            $(".health").find('.barfill').css("width", data.health + "%");
            var checkBox = document.getElementById("healthbox");

            if (checkBox.checked == true){
                $(".borderhudhealth").fadeIn(400);    
            } else {
                $(".borderhudhealth").fadeOut(400);    
            }
        }
                
        if (data.health >= 0 && data.health <= 80) {
            $(".borderhudhealth").fadeIn(200);
        } else {
            showHealth();
        }  

        showArmor = function() {
            var checkBox = document.getElementById("armorbox");
          
            if (checkBox.checked == true){
                $(".borderhudarmor").fadeIn(400);
              } else  {
                $(".borderhudarmor").fadeOut(400);
              }
        }

        showNitrous = function() {
            var checkBox = document.getElementById("shownitro");
          
            if (checkBox.checked == true){
                $(".borderhudnitrous").fadeIn(400);
              } else  {
                $(".borderhudnitrous").fadeOut(400);
              }
        }

        showHarness = function() {
            var checkBox = document.getElementById("showharness");
          
            if (checkBox.checked == true){
                $(".borderhudharness").fadeIn(400);
              } else  {
                $(".borderhudharness").fadeOut(400);
              }
        }

        if (data.armor >= 1 && data.armor <= 100) {
            $(".borderhudarmor").fadeIn(200);
        } else {
            showArmor();
        }
        
        if (data.oxygen >= 0 && data.oxygen <= 99) {
            $(".borderhudoxygen").fadeIn(200);
        } else {
            $(".borderhudoxygen").fadeOut(200);
        }  
        
        if (data.showUi == true) {
            $(".container").fadeIn(400);
        } else if (data.showUi == false) {
            $(".container").fadeOut(400);
        }

        window.addEventListener("message", function (event) {
            let data = event.data

            switch (data.action) {
                case 'voiceMode':
                    if (data.value == 1) {
                        $("#barfillvoice").css("width", "33%")
                        $("#barfillradio").css("width", "33%")
                    } else if (data.value == 2) {
                        $("#barfillvoice").css("width", "66%")
                        $("#barfillradio").css("width", "66%")
                    } else {
                        $("#barfillvoice").css("width", "100%")
                        $("#barfillradio").css("width", "100%")
                    }
                    
                break;
                case 'radio' :
                    if (data.value) {
                        $("#bgg").css("background", "#D6476359")
                        $("#barfillradio").css("background", "#D64763")
                        $("#bs").css("background", "radial-gradient(transparent, #d6476498")
                    } else if (data.value == false) {
                        $("#bgg").css("background", "#ffffff4c")
                        $("#bs").css("background", "radial-gradient(transparent, #d6d6d659)")
                        $("#barfillradio").css("background", "rgba(255, 255, 255, 0.5)")
                    }
                break;
            }
        })

        if (data.talking == 1) {
            $("#bggg").css("background", "rgba(255, 255, 0, 0.264)")
            $("#barfillvoice").css("background", "rgba(255, 255, 0, .6)")
            $("#ps").css("background", "radial-gradient(transparent, #ffff0059)")
        } else {
            $("#barfillvoice").css("background", "rgba(255, 255, 255, 0.5)")
            $("#bggg").css("background", "#ffffff4c")
            $("#ps").css("background", "radial-gradient(transparent, #d6d6d659)")
        }
    };

    closeMenu = function() {
        $(".settingscontainer").fadeOut(100);
        $.post("https://sgx-hud/closeMenu");
        hudSettings();
    }
      
    openSettings = function() {
        $(".settingscontainer").fadeOut(100);
        $.post("https://sgx-hud/Settings");
        hudSettings();
    }

    restartHud = function() {
        closeMenu();
        $.post("https://sgx-hud/restartHud");
    }
      
    hudSettings = function() {
        var element = document.getElementById("helpguideid");
        element.classList.remove("selected");
        var element = document.getElementById("hudesttingsid");
        element.classList.add("selected");
        $(".disabled-icon1").fadeOut(0);
        $(".selected-icon1").fadeIn(0);
        $(".disabled-icon2").fadeIn(0);
        $(".selected-icon2").fadeOut(0);
        $("#hudsetitems").fadeIn(0);
        $("#guidehelp").fadeOut(0);
    }
    
    helpGuide = function() {
        var element = document.getElementById("helpguideid");
        element.classList.add("selected");
        var element = document.getElementById("hudesttingsid");
        element.classList.remove("selected");
        $(".disabled-icon1").fadeIn(0);
        $(".selected-icon1").fadeOut(0);
        $(".disabled-icon2").fadeOut(0);
        $(".selected-icon2").fadeIn(0);
        $("#hudsetitems").fadeOut(0);
        $("#guidehelp").fadeIn(0);
    }

    updateRPM = function(rpm) {
        var rpmBar = document.getElementById('rpmBar');
        if (rpmBar) {
            rpmBar.innerHTML = '';
            for (var i = 0; i < 18; i++) {
                var item = document.createElement('div');
                item.className = 'itemcar';
                if (i < rpm) {
                    if (i >= 16) {
                        item.classList.add('critical');
                    } else {
                        item.classList.add('filled');
                    }
                }
                rpmBar.appendChild(item);
            }
        } else {
            // console.log("Element with ID 'rpmBar' not found");
        }
    }

     // RPM Counter Updater //
     window.addEventListener('message', function (event) {
        var rpm = event.data.rpm;
        if (rpm !== undefined) {
            // console.log("Received RPM: " + rpm);
            updateRPM((rpm / 1) * 18);
        } else {
            // console.log("RPM data not received");
        }
    });

    cinematicMode = function() {
        var checkBox = document.getElementById("cinematic");
    
        if (checkBox.checked == true){
            $(".cinematicmode").fadeIn(100);
            $(".compassui").fadeOut(100);
            $(".playerhud").fadeOut(100);
            $(".cinhudcar").fadeOut(100);
            $.post("https://sgx-hud/toggleMap");
            // $.post("https://sgx-hud/onCinematic");
          } else {
            $(".cinematicmode").fadeOut(100);
            $(".compassui").fadeIn(100);
            $(".playerhud").fadeIn(100);
            $(".cinhudcar").fadeIn(100);
            $.post("https://sgx-hud/toggleMap");
            // $.post("https://sgx-hud/offCinematic");
          }
    }

    hideMap = function() {
        var checkBox = document.getElementById("map");
      
        if (checkBox.checked == true){
            $.post("https://sgx-hud/toggleMap");
          } else {
            $.post("https://sgx-hud/toggleMap");
          }
      }

    hideplayerhud = function() {
        var checkBox = document.getElementById("showhud");
    
        if (checkBox.checked == true){
            $(".playerhud").fadeIn(100);
            $(".cinhudcar").fadeIn(100);
          } else {
            $(".playerhud").fadeOut(100);
            $(".cinhudcar").fadeOut(100);
          }
    }
    
    hideRadar = function() {
        var checkBox = document.getElementById("radar");
    
        if (checkBox.checked == true){
            $(".compassui").fadeIn(100);
          } else {
            $(".compassui").fadeOut(100);
          }
    }

    showOxy = function() {
        var checkBox = document.getElementById("oxygenbox");
      
        if (checkBox.checked == true){
            $(".borderhudsprint").fadeIn(400);
          } else {
            $(".borderhudsprint").fadeOut(400);
          }
    }

    showStress = function() {
        var checkBox = document.getElementById("stressbox");
      
        if (checkBox.checked == true){
            $(".borderhudstress").fadeIn(400);
          } else {
            $(".borderhudstress").fadeOut(400);
          }
    }

    window.addEventListener('message', function (event) {
        var rpm = event.data.rpm;
        if (rpm !== undefined) {
            // console.log("Received RPM: " + rpm);
            updateRPM((rpm / 1) * 18);
        } else {
            // console.log("RPM data not received");
        }
    });

    document.addEventListener("DOMContentLoaded", function() {
        window.addEventListener("message", function(event) {
            var gearElement = document.getElementById("gearscount");
            if (gearElement && event.data.gear) {
                // Update the gear display with the data from Lua
                gearElement.innerHTML = event.data.gear;
            }
        });
    });

    window.onload = function(e) {
        window.addEventListener('message', function(event) {
            switch(event.data.action) {

                    // Menu
                case "openSettings":
                    $(".settingscontainer").fadeIn(100);
                    break;
                case "closeSettings":
                    $(".settingscontainer").fadeOut(100);
                    break;

                    // Voice
                case "talking":
                    QBHud.SetTalkingState(event.data);
                    break;

                    // Hud Options
                case "hide-hud":
                    $(".container").fadeOut(200);
                    break;
                case "show-hud":
                    $(".container").fadeIn(200);
                    QBHud.UpdateHud(event.data);
                    break;
                case "hide-ui":
                    $(".cinhudcar").fadeOut(200);
                    $(".playerhud").fadeOut(200);
                    $(".moneyhud").fadeOut(200);
                    break;
                case "show-ui":
                    $(".cinhudcar").fadeIn(200);
                    $(".playerhud").fadeIn(200);
                    $(".moneyhud").fadeIn(200);
                    break;
                case "show-cash":
                    $("#cash").show(300);
                    break;
                case "hide-cash":
                    $("#cash").hide(300);
                    break;
                case "show-bank":
                    $("#bank").show(300);
                    break;
                case "hide-bank":
                    $("#bank").hide(300);
                    break;
                case "show-radio":
                    $(".borderhudradio").fadeIn(200);
                    break;
                case "hide-radio":
                    $(".borderhudradio").fadeOut(200);
                    break;

                    // Car HUD
                case "show-carhud":
                    $(".speedometerui").fadeIn(200);
                    QBHud.UpdateCarHud(event.data);
                    break;
                case "hide-carhud":
                    $(".speedometerui").fadeOut(200);
                    break;
                case "hide-seatbelt":
                    $(".seatbelt").hide(200);
                    break;
                case "show-seatbelt":
                    $(".seatbelt").show(200);
                    break;
            }
        })
    }

})();

window.addEventListener("message", function (event) {
    if (event.data.action == "display") {
        value = event.data.value
        
        if (value  !== undefined) {
            bar = document.getElementsByTagName("svg")[0];
            bar.setAttribute("viewBox", ''+ (value - 90) + ' 0 180 5');
            heading = document.getElementsByTagName("svg")[1];
            heading.setAttribute("viewBox", ''+ (value - 90) + ' 0 181 1.5');
        }

        $(".ui").fadeIn();
        $(".compass").fadeIn();
        $(".compasspoint").fadeIn();
    } else if (event.data.action == "hide") {
        $(".bar").show();
        $(".ui").fadeOut();
        $(".compasspoint").fadeOut();
        $(".compass").fadeOut();
    }
});