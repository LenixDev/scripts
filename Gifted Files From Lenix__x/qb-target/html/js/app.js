function FadeIn(Object, Timeout) {
    $(Object).fadeIn(Timeout).css('display', 'block');
}

function FadeOut(Object, Timeout) {
    $(Object).fadeOut(Timeout)
    setTimeout(function(){
        $(Object).css("display", "none");
    }, Timeout)
}

const Targeting = Vue.createApp({
    data() {
        return {
            Show: false,
            ChangeTextIconColor: false, // This is if you want to change the color of the icon next to the option text with the text color
            StandardEyeIcon: 'https://media.discordapp.net/attachments/1231937897146351697/1259856201760641095/1234.png?ex=66b76405&is=66b61285&hm=b2c401f700f13172f39d3857d5d42888ef13e78d534c1a68785ff94cf7403b42&=&format=webp&quality=lossless', // Instead of icon it's using a image source found in HTML 
            CurrentIcon: 'https://media.discordapp.net/attachments/1231937897146351697/1259856201760641095/1234.png?ex=66b76405&is=66b61285&hm=b2c401f700f13172f39d3857d5d42888ef13e78d534c1a68785ff94cf7403b42&=&format=webp&quality=lossless', // Instead of icon it's using a image source found in HTML
            SuccessIcon: 'https://media.discordapp.net/attachments/1231937897146351697/1259856201760641095/1234.png?ex=66b76405&is=66b61285&hm=b2c401f700f13172f39d3857d5d42888ef13e78d534c1a68785ff94cf7403b42&=&format=webp&quality=lossless', // Instead of icon it's using a image source found in HTML
            SuccessColor: "#10CC9F;",
            StandardColor: "white",
            TargetHTML: "",
            TargetEyeStyleObject: {
                color: "white", // This is the standardcolor, change this to the same as the StandardColor if you have changed it
            },
        }
    },
    destroyed() {
        window.removeEventListener("message", this.messageListener);
        window.removeEventListener("mousedown", this.mouseListener);
        window.removeEventListener("keydown", this.keyListener);
    },
    mounted() {
        this.messageListener = window.addEventListener("message", (event) => {
            switch (event.data.response) {
                case 'opencircle':
                    let xx = event.data.post
                    OpenCircle(xx.x, xx.y, xx.id)
                    break;
                case 'closecircle':
                    FadeOut("#circle-"+event.data.post.id, 200)
                    break;
                case 'updatecircle':
                    $("#circle-"+event.data.post.id).css('left', event.data.post.x*100+"%");
                    $("#circle-"+event.data.post.id).css('right', (100 - event.data.post.x*100)+"%");
                    $("#circle-"+event.data.post.id).css('top', event.data.post.y*100+"%");
                    $("#circle-"+event.data.post.id).css('bottom',(100 - event.data.post.y*100)+"%");
                    break;
                case "openTarget":
                    this.OpenTarget();
                    break;
                case "closeTarget":
                    this.CloseTarget();
                    break;
                case "foundTarget":
                    $('.hexagon').css('filter', 'drop-shadow(0vw 0vw .8vw #10CC9F)');
                    $('.hexagon img').css('filter', 'drop-shadow(0vw 0vw .8vw #10CC9F)');
                    $('#target-eye').css('filter', 'drop-shadow(0vw 0vw .8vw #10CC9F)');
                    $('.alttakim img').css('top', '52.7vh');
                    $('.alttakim img').css('opacity', '0.6');
                    this.FoundTarget(event.data);
                    break;
                case "validTarget":
                    this.ValidTarget(event.data);
                    break;
                case "leftTarget":
                    $('.hexagon').css('filter', 'drop-shadow(0vw 0vw 0.0vw #10CC9F)');
                    $('.hexagon img').css('filter', 'drop-shadow(0vw 0vw 0.0vw #10CC9F)');
                    $('#target-eye').css('filter', 'drop-shadow(0vw 0vw 0.0vw #10CC9F)');
                    $('.alttakim img').css('top', '51.7vh');
                    $('.alttakim img').css('opacity', '0.0');
                    this.LeftTarget();
                    break;
            }
        });

        this.mouseListener = window.addEventListener("mousedown", (event) => {
            let element = event.target;
            let split = element.id.split("-");
            if (split[0] === 'target' && split[1] !== 'eye') {
                $.post(`https://qb-target/selectTarget`, JSON.stringify(Number(split[1]) + 1));
                this.TargetHTML = "";
                this.Show = false;
            }

            if (event.button == 2) {
                this.CloseTarget();
                $.post(`https://qb-target/closeTarget`);
            }
        });

        this.keyListener = window.addEventListener("keydown", (event) => {
            if (event.key == 'Escape' || event.key == 'Backspace') {
                this.CloseTarget();
                $.post(`https://qb-target/closeTarget`);
            }
        });
    },
    methods: {
        OpenTarget() {
            this.TargetHTML = "";
            this.Show = true;
            this.TargetEyeStyleObject.color = this.StandardColor;
        },

        CloseTarget() {
            this.TargetHTML = "";
            this.TargetEyeStyleObject.color = this.StandardColor;
            this.Show = false;
            this.CurrentIcon = this.StandardEyeIcon;
        },

        FoundTarget(item) {
            if (item.data) {
                this.CurrentIcon = item.data;
            } else {
                this.CurrentIcon = this.SuccessIcon;
            }
            this.TargetEyeStyleObject.color = this.SuccessColor;
        },

        ValidTarget(item) {
            this.TargetHTML = "";
            let TargetLabel = this.TargetHTML;
            const FoundColor = this.SuccessColor;
            const ResetColor = this.StandardColor;
            const AlsoChangeTextIconColor = this.ChangeTextIconColor;
            item.data.forEach(function(item, index) {
                if (AlsoChangeTextIconColor) {
                    TargetLabel += "<div style='transition: all 0.3s; user-select: none; white-space: nowrap; text-overflow: ellipsis; margin: 0.1vw; border-radius: 0.2667vw; background: linear-gradient(180deg, rgba(10, 30, 31, 0.48) 0%, rgba(10, 30, 31, 0.58) 11.98%, rgba(14, 44, 44, 0.59) 44.27%, rgba(4, 73, 69, 0.64) 100%);' id='target-" + index + "' style='margin-bottom: 1vh;'><span id='target-icon-" + index + "' style='color: " + ResetColor + "'><i style='margin-left: .35vw; color: #10CC9F;' class='" + item.icon + "'></i></span>&nbsp" + item.label + "</div>";
                } else {
                    TargetLabel += "<div style='transition: all 0.3s; user-select: none; white-space: nowrap; text-overflow: ellipsis; margin: 0.1vw; border-radius: 0.2667vw; background: linear-gradient(180deg, rgba(10, 30, 31, 0.48) 0%, rgba(10, 30, 31, 0.58) 11.98%, rgba(14, 44, 44, 0.59) 44.27%, rgba(4, 73, 69, 0.64) 100%);' id='target-" + index + "' style='margin-bottom: 1vh;'><span id='target-icon-" + index + "' style='color: " + FoundColor + "'><i style='margin-left: .35vw; color: #10CC9F;' class='" + item.icon + "'></i></span>&nbsp" + item.label + "</div>";
                };

                setTimeout(function() {
                    const hoverelem = document.getElementById("target-" + index);

                    hoverelem.addEventListener("mouseenter", function(event) {
                        event.target.style.background = '#34C3A6';
                    });

                    hoverelem.addEventListener("mouseleave", function(event) {
                        event.target.style.background = 'linear-gradient(180deg, rgba(17, 41, 43, 0.3) 0%, rgba(7, 87, 63, 0.3) 100%)';;
                    });
                }, 10)
            });
            this.TargetHTML = TargetLabel;
        },

        LeftTarget() {
            this.TargetHTML = "";
            this.CurrentIcon = this.StandardEyeIcon;
            this.TargetEyeStyleObject.color = this.StandardColor;
        }
    }
});

Targeting.use(Quasar, {
    config: {
        loadingBar: { skipHijack: true }
    }
});
Targeting.mount("#target-wrapper");

function OpenCircle(x, y, id) {
    $(".circle").append(`
        <img id="circle-${id}" style="display: none; top: 25vw; left: 50vw; position: absolute; width: 30px; height: 30px;" src="css/circle.svg" alt="">
    `);
    $("#circle-"+id).css('left', x*100+"%");
    $("#circle-"+id).css('right', (100 - x*100)+"%");
    $("#circle-"+id).css('top', y*100+"%");
    $("#circle-"+id).css('bottom',(100 - y*100)+"%");
    FadeIn("#circle-"+id, 200)
}