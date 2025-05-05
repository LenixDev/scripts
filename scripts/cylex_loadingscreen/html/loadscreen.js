var currentTheme = "red"


SetTheme = function(){
  // if (color == "green") {
    currentTheme = "green"
    console.log("new")
    var newControlContent = `<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 14 14" fill="none">  <path d="M4.0282 3.72045C5.73303 2.01562 8.4962 2.01416 10.2028 3.71608L8.36606 5.56161L12.7353 5.54081L12.7146 1.19238L11.0835 2.83127C8.88914 0.643935 5.33713 0.646089 3.14548 2.83773C2.04871 3.93451 1.50014 5.37325 1.50013 6.80994L2.74848 6.80994C2.74849 5.6908 3.17494 4.57371 4.0282 3.72045Z" fill="#0BF8BF"/>  <path d="M10.2072 9.89947C11.0605 9.0462 11.4869 7.9291 11.4869 6.80994L12.7353 6.80994C12.7353 8.24664 12.1867 9.68541 11.0899 10.7822C8.89829 12.9738 5.34627 12.976 3.15195 10.7887L1.52083 12.4275L1.50013 8.07911L5.86936 8.05831L4.03257 9.90384C5.73921 11.6058 8.50239 11.6043 10.2072 9.89947Z" fill="#0BF8BF"/></svg>`
    var newShufContent = `<svg xmlns="http://www.w3.org/2000/svg" width="13" height="14" viewBox="0 0 13 14" fill="none">  <path d="M10.0277 6.18579L12.5244 3.71286L10.0277 1.19238V3.1348C8.56484 3.27694 7.52797 3.63055 6.75922 4.14591C6.18273 4.53238 5.78499 4.99265 5.48078 5.46146C5.21319 5.00599 4.87074 4.55246 4.37776 4.17081C3.46942 3.46758 2.14102 3.06491 0.0409241 3.06491V4.31326C1.99797 4.31326 3.01022 4.69081 3.61356 5.15791C4.16121 5.5819 4.44634 6.12673 4.7736 6.81242C4.72862 6.91205 4.68724 7.00715 4.64761 7.09826C4.42066 7.61997 4.25072 8.0106 3.78598 8.3704C3.18264 8.8375 1.99797 9.30666 0.0409241 9.30666V10.555C2.14102 10.555 3.46942 10.1523 4.37776 9.44912C4.87074 9.06746 5.21319 8.61394 5.48077 8.15847C5.78498 8.62728 6.18273 9.08754 6.75922 9.47402C7.52797 9.98938 8.56484 10.343 10.0277 10.4851V12.4275L12.5244 9.95461L10.0277 7.43414V9.23027C8.77737 9.0953 7.98797 8.79485 7.45435 8.43711C6.81924 8.01134 6.4799 7.46379 6.15666 6.80996C6.4799 6.15614 6.81924 5.60858 7.45435 5.18281C7.98797 4.82508 8.77737 4.52462 10.0277 4.38965V6.18579Z" fill="#0BF8BF"/></svg>`
    var newSpotContent = `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20" fill="none">  <path fill-rule="evenodd" clip-rule="evenodd" d="M15.1984 8.50729C12.1396 6.69113 7.02569 6.49996 4.11027 7.40804C3.63233 7.55143 3.15439 7.26466 3.01101 6.83452C2.86763 6.35658 3.15439 5.87864 3.58454 5.73526C6.9779 4.73159 12.5698 4.92277 16.1065 7.0257C16.5367 7.26467 16.68 7.83819 16.4411 8.26833C16.2021 8.60289 15.6286 8.74626 15.1984 8.50729ZM15.1028 11.1837C14.8639 11.5183 14.4337 11.6617 14.0992 11.4227C11.5183 9.84552 7.59922 9.36759 4.58821 10.3235C4.20586 10.4191 3.77571 10.2279 3.68013 9.84553C3.58454 9.46318 3.77571 9.03303 4.15806 8.93744C7.64701 7.88598 11.9485 8.41171 14.9117 10.2279C15.1984 10.3713 15.3418 10.8492 15.1028 11.1837ZM13.9558 13.8124C13.7646 14.0992 13.4301 14.1948 13.1433 14.0036C10.897 12.6176 8.07716 12.3308 4.73159 13.0955C4.39703 13.1911 4.11027 12.9521 4.01468 12.6654C3.91909 12.3308 4.15806 12.044 4.44483 11.9485C8.07716 11.136 11.2315 11.4705 13.7168 12.9999C14.0514 13.1433 14.0992 13.5256 13.9558 13.8124ZM9.55876 0C4.30144 0 0 4.30144 0 9.55876C0 14.8161 4.30144 19.1175 9.55876 19.1175C14.8161 19.1175 19.1175 14.8161 19.1175 9.55876C19.1175 4.30144 14.8639 0 9.55876 0Z" fill="#0BF8BF"/></svg>`
    $(".spotif-div").html(newSpotContent)
    $(".shuf-svg").html(newShufContent)
    $(".control").html(newControlContent)
    document.documentElement.style.setProperty('--scarlet', '#0BF8BF');
    document.documentElement.style.setProperty('--bar', 'linear-gradient(90deg, #0BF8BF 0%, #64FCD7 100%)');
    document.documentElement.style.setProperty('--loading', 'linear-gradient(103deg, #0BF8BF 0%, #67F0CF 100%)');
  // }
}

UpdateSocialMedia = function(data) {
  for (var k in data.SocialMedias) {
    $("."+k).html(data.SocialMedias[k])
  }
}

SetKeys = function(keys){
  $.each(keys, function(key,value) {
    var group = `
    <div class="group-1">
        <div class="link">
          <div class="a-14 satoshi-bold-gunsmoke-17-9px">${value.key}</div>
        </div>
        <div class="flex-col">
          <div class="surname satoshi-bold-pale-slate-7-6px">
            ${value.keyHeader}
          </div>
          <p
            class="indicates-which-feat satoshi-medium-sonic-silver-7-1px"
          >
          ${value.keyDescription}
          </p>
        </div>
      </div>`
      $(".keyCont").append(group)
    })
}

function formatTime(minutes) {
  var days = Math.floor(minutes / (24 * 60));
  var hours = Math.floor((minutes % (24 * 60)) / 60);
  var remainingMinutes = minutes % 60;

  var formattedTime = "";

    formattedTime += days + "D ";
    formattedTime += hours + "H ";
    formattedTime += remainingMinutes + "M";
  return formattedTime;
}

ServerSettings = function(data) {
  $(".serverName").html(data.ServerName)
  $(".hint-message").html(data.Hint)
  $(".serverdesc").html(data.ServerDescription)
}

SetPlayerData = function(ip) {
  console.log(68, ip)
  $.post(`http://${ip}/cylex_loadingscreen/`, JSON.stringify({}), function(data) {
    var playerData = JSON.parse(data)
    console.log(73, playerData, playerData.steamName)
    $(".steamName").html(playerData.steamName)
    $(".steamId").html(playerData.steamId)
    $(".discordId").html(playerData.discordId)
    $(".steamPng").attr("src", playerData.steamPp)
    var formatted = formatTime(playerData.playTime);
    $(".time").html(formatted);

  })
}

var audioElement = document.getElementById("music")
var currentTrackIndex = 0;
var musicList = [];

SetMusicData = function(data) {
  for (var k in data) {
    musicList.push(
      {
        label : data[k].label,
        fileName : data[k].fileName,
        banner : data[k].banner,
        owner : data[k].owner

      }
    )
  }
  playTrack(currentTrackIndex);
}

// jquery on start
var dataSet = false

window.addEventListener("message",function(e) {
    let data = e.data.data
    let playerData = e.data.player
    if (e.data.eventName === "loadProgress") {
      const loaded = parseInt(e.data.loadFraction * 100);
      $(".rectangle-2").css("width", `${loaded}%`);
      $(".load").html("%"+loaded);
    }
})



audioElement.addEventListener("timeupdate", function() {
  var musicTimeDiv = document.querySelector(".musictime")
  var currentTime = audioElement.currentTime;
  var duration = audioElement.duration;
  var progress = (currentTime / duration) * 100;
  musicTimeDiv.style.width = progress + "%";
});




function playTrack(index) {
  audioElement.src = musicList[index].fileName;
  $(".label").html(musicList[index].label)
  $(".banner").attr("src", musicList[index].banner)
  $(".owner").html(musicList[index].owner)
  audioElement.play();
}

function playNextTrack() {
  currentTrackIndex = (currentTrackIndex + 1) % musicList.length;
  playTrack(currentTrackIndex);
}

function playPrevTrack() {
  currentTrackIndex = (currentTrackIndex - 1 + musicList.length) % musicList.length;
  playTrack(currentTrackIndex);
}



function pauseOrPlayMusic() {
  if (audioElement.paused) {
    audioElement.play();
  } else {
    audioElement.pause();
  }
}




$(document).ready(function() {
  console.log('js loaded')
  $.getJSON('config.json', function(data) {
    console.log(180, JSON.stringify(data))
    SetPlayerData(data.serverIp)

    ServerSettings(data)
    UpdateSocialMedia(data)
    SetSocialMedias(data)
    SetKeys(data.Keys)
    PatchNotes(data)
    SetMusicData(data.Music)
    if (data.Theme == "green") {
      console.log("worked")
      SetTheme()
    }
  });



  $(document).on("click", ".ps", function() {
    pauseOrPlayMusic()
  })
  $(document).on("click", ".next", function(){
    playNextTrack()
  })
  $(document).on("click", ".back", function(){
    playPrevTrack()
  })
  $(document).on("click", ".control", function() {
    audioElement.currentTime = 0;
  })
  $(document).on("click", ".svgDiv", function(){
    let value = $(this).attr("value")
    if (value == "false") {
      if (currentTheme == "red") {
        $(".svgDiv").html(`
        <svg width="27" height="19" viewBox="0 0 27 19" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M25.8699 14.5C26.0025 14.7302 26.0382 15.0037 25.9692 15.2603C25.9001 15.5169 25.732 15.7355 25.5018 15.8681C25.3878 15.9338 25.2619 15.9763 25.1315 15.9934C25.001 16.0104 24.8685 16.0016 24.7415 15.9674C24.4849 15.8984 24.2663 15.7302 24.1336 15.5L21.7586 11.35C20.379 12.2832 18.8572 12.9865 17.2524 13.4325L17.9861 17.835C18.0078 17.9646 18.0037 18.0972 17.9741 18.2252C17.9444 18.3532 17.8899 18.4742 17.8135 18.5811C17.7371 18.688 17.6404 18.7788 17.5289 18.8483C17.4174 18.9179 17.2933 18.9647 17.1636 18.9862C17.1103 18.995 17.0564 18.9996 17.0024 19C16.7658 18.9996 16.537 18.9154 16.3567 18.7623C16.1764 18.6092 16.0561 18.3971 16.0174 18.1637L15.2961 13.8412C13.7751 14.0529 12.2321 14.0529 10.7111 13.8412L9.98989 18.1637C9.95108 18.3976 9.8305 18.61 9.64964 18.7631C9.46877 18.9163 9.23939 19.0002 9.00239 19C8.94712 18.9998 8.89194 18.9952 8.83739 18.9862C8.70777 18.9647 8.58366 18.9179 8.47215 18.8483C8.36065 18.7788 8.26394 18.688 8.18755 18.5811C8.11117 18.4742 8.0566 18.3532 8.02697 18.2252C7.99735 18.0972 7.99324 17.9646 8.01489 17.835L8.75239 13.4325C7.14693 12.9855 5.62464 12.2809 4.24489 11.3463L1.87739 15.5C1.74478 15.7311 1.52582 15.9 1.26866 15.9696C1.0115 16.0392 0.737212 16.0039 0.506143 15.8713C0.275073 15.7386 0.106145 15.5197 0.0365224 15.2625C-0.0331005 15.0054 0.00228421 14.7311 0.134892 14.5L2.63489 10.125C1.75645 9.36669 0.948942 8.52989 0.222393 7.625C0.0784989 7.44704 0 7.22511 0 6.99625C0 6.76739 0.0784989 6.54546 0.222393 6.3675C2.57239 3.465 6.69614 0 13.0024 0C19.3086 0 23.4324 3.465 25.7799 6.375C25.9238 6.55296 26.0023 6.77489 26.0023 7.00375C26.0023 7.23261 25.9238 7.45454 25.7799 7.6325C25.0533 8.53739 24.2458 9.37419 23.3674 10.1325L25.8699 14.5Z" fill="#FF2540"/>
        </svg>
        `)
      } else {
        $(".svgDiv").html(`<svg xmlns="http://www.w3.org/2000/svg" width="27" height="19" viewBox="0 0 27 19" fill="none">
        <path d="M25.8699 14.5C26.0025 14.7302 26.0382 15.0037 25.9692 15.2603C25.9001 15.5169 25.732 15.7355 25.5018 15.8681C25.3878 15.9338 25.2619 15.9763 25.1315 15.9934C25.001 16.0104 24.8685 16.0016 24.7415 15.9674C24.4849 15.8984 24.2663 15.7302 24.1336 15.5L21.7586 11.35C20.379 12.2832 18.8572 12.9865 17.2524 13.4325L17.9861 17.835C18.0078 17.9646 18.0037 18.0972 17.9741 18.2252C17.9444 18.3532 17.8899 18.4742 17.8135 18.5811C17.7371 18.688 17.6404 18.7788 17.5289 18.8483C17.4174 18.9179 17.2933 18.9647 17.1636 18.9862C17.1103 18.995 17.0564 18.9996 17.0024 19C16.7658 18.9996 16.537 18.9154 16.3567 18.7623C16.1764 18.6092 16.0561 18.3971 16.0174 18.1637L15.2961 13.8412C13.7751 14.0529 12.2321 14.0529 10.7111 13.8412L9.98989 18.1637C9.95108 18.3976 9.8305 18.61 9.64964 18.7631C9.46877 18.9163 9.23939 19.0002 9.00239 19C8.94712 18.9998 8.89194 18.9952 8.83739 18.9862C8.70777 18.9647 8.58366 18.9179 8.47215 18.8483C8.36065 18.7788 8.26394 18.688 8.18755 18.5811C8.11117 18.4742 8.0566 18.3532 8.02697 18.2252C7.99735 18.0972 7.99324 17.9646 8.01489 17.835L8.75239 13.4325C7.14693 12.9855 5.62464 12.2809 4.24489 11.3463L1.87739 15.5C1.74478 15.7311 1.52582 15.9 1.26866 15.9696C1.0115 16.0392 0.737212 16.0039 0.506143 15.8713C0.275073 15.7386 0.106145 15.5197 0.0365224 15.2625C-0.0331005 15.0054 0.00228421 14.7311 0.134892 14.5L2.63489 10.125C1.75645 9.36669 0.948942 8.52989 0.222393 7.625C0.0784989 7.44704 0 7.22511 0 6.99625C0 6.76739 0.0784989 6.54546 0.222393 6.3675C2.57239 3.465 6.69614 0 13.0024 0C19.3086 0 23.4324 3.465 25.7799 6.375C25.9238 6.55296 26.0023 6.77489 26.0023 7.00375C26.0023 7.23261 25.9238 7.45454 25.7799 7.6325C25.0533 8.53739 24.2458 9.37419 23.3674 10.1325L25.8699 14.5Z" fill="#0BF8BF"/>
      </svg>`)
      }

      $(".group-192").css("opacity", 1)
      $(this).attr("value", "true")
    } else {
      $(".svgDiv").html(`
      <svg width="31" height="20" viewBox="0 0 31 20" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M30.0856 9.595C30.0419 9.49625 28.9831 7.1475 26.6294 4.79375C23.4931 1.6575 19.5319 0 15.1719 0C10.8119 0 6.85061 1.6575 3.71436 4.79375C1.36061 7.1475 0.296863 9.5 0.258113 9.595C0.201254 9.72289 0.171875 9.86129 0.171875 10.0012C0.171875 10.1412 0.201254 10.2796 0.258113 10.4075C0.301863 10.5062 1.36061 12.8538 3.71436 15.2075C6.85061 18.3425 10.8119 20 15.1719 20C19.5319 20 23.4931 18.3425 26.6294 15.2075C28.9831 12.8538 30.0419 10.5062 30.0856 10.4075C30.1425 10.2796 30.1719 10.1412 30.1719 10.0012C30.1719 9.86129 30.1425 9.72289 30.0856 9.595ZM15.1719 15C14.183 15 13.2163 14.7068 12.394 14.1573C11.5718 13.6079 10.9309 12.827 10.5525 11.9134C10.174 10.9998 10.075 9.99445 10.2679 9.02455C10.4609 8.05464 10.9371 7.16373 11.6363 6.46447C12.3356 5.7652 13.2265 5.289 14.1964 5.09607C15.1663 4.90315 16.1717 5.00216 17.0853 5.3806C17.9989 5.75904 18.7798 6.3999 19.3292 7.22215C19.8786 8.04439 20.1719 9.01109 20.1719 10C20.1719 11.3261 19.6451 12.5979 18.7074 13.5355C17.7697 14.4732 16.4979 15 15.1719 15Z" fill="#8A8A8A"/>
    </svg>`)
    $(".group-192").css("opacity", 0)
    $(this).attr("value", "false")
    }
  })
});


SetSocialMedias = function(data) {
  for (var item in data.SocialMedias) {
    var content = `
    <div class="overlap-group3-1" style="border: 1px solid rgba(36, 34, 38, 0.51);">
    <div class="discord-container">
      <div
        class="discord-server poppins-semi-bold-gunsmoke-17-3px"
      >
        ${data.SocialMedias[item].media}
      </div>
      <div class="wwwdiscordcominvitehere discord">
      ${data.SocialMedias[item].username}
      </div>
    </div>
    <img
      class="vector-1"
      src=" ${data.SocialMedias[item].src}"
      alt="Vector"
    />
  </div>`
  $(".mediaContent").append(content)
  console.log("append")
  }


}


PatchNotes = function(data){
  $.each(data.PatchNotes, function(key, value) {
    var content = `
    <div class="overlap-group">
      <div class="overlap-group1" style=" border: 1px solid transparent;
      border-image: linear-gradient(to right, rgba(36, 34, 38, 0.51), rgba(36, 34, 38, 1));
      border-image-slice: 1;">
        <div class="overlap-group-container">
          <div class="overlap-group2" >
            <div class="patch-note-1 poppins-medium-gunsmoke-18px">
              PATCH NOTE #${key + 1}
            </div>
            <div class="gncelleme-ad poppins-medium-scarlet-10-2px">
              ${value.header}
            </div>
          </div>
          <div class="overlap-group-1">
            <div class="date gothica1-bold-silver-chalice-9-7px">
              ${value.date}
            </div>
          </div>
        </div>
        <p class="lorem-ipsum-is-simpl satoshi-bold-white-9-6px">
          ${value.Text}
        </p>
      </div>
      <img
        class="line-1"
        src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=="
        anima-src="https://anima-uploads.s3.amazonaws.com/projects/64e7337ed3c216599309a3b0/releases/64e73477513587ee81bc38eb/img/line-1-1.svg"
        alt="Line 1"
      />
    </div>`
    $(".patchContent").append(content)
  })
}

