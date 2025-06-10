const levelInfo = $(".level-info");
const nameInfo = $(".name-info");
const cuttedTrees = $(".cutted-trees-text");
const moneyInfo = $(".earned-money-text");
const passedTime = $(".passing-time-text");
const tier2axePercent = $(".tier2axePercent");
const tier2axeNeed = $(".tier2axeNeed");
const tier3axePercent = $(".tier3axePercent");
const tier3axeNeed = $(".tier3axeNeed");
const bonusHeadder = $(".bonus-headder");
const bonusPercent = $(".bonus-percent");
const leaderboardContent = $(".leaderboard-content");
const contractPageBtn = $(".contract-page-btn")
const contractBackBtn = $(".contract-headder-back-btn")
const contractPage = $(".main-contract-div")
const contractList = $(".contract-list")
const makeContractBtn = $(".make-contract-btn")
const cutTreeInput = $(".cut-tree-input")
const cutTreePercentInput = $(".cut-tree-percent-input")
var jobstarted
var axeData
var cuttedTree
var playerLevel
var config
var mycitizenid
$(document).ready(function () {
  $.post(
    `https://${GetParentResourceName()}/gfx:client:lumberjack:getConfig`,
    JSON.stringify({}), function (data) {
      //console.log(JSON.stringify(data))
      config = data
      cutTreeInput.attr("placeholder", `Max: ${data.contractSettings.maxTreeCount}`)
      cutTreePercentInput.attr("placeholder", `Max: %${data.contractSettings.maxPercent}`)
      $(".contractlvl").text(`Made contracts at level ${data.contractSettings.makeContractLevel}`)
    });
});

window.addEventListener("message", function (e) {
  const data = e.data;
  if (data.action == "gfx:lumberjack:openUI") {
    DisplayScreen(true);
    contractPage.css("display", "none");
    $(".main-content").css("display", "flex");
    //console.log(JSON.stringify(data.database))
    levelInfo.text(data.database.level);
    nameInfo.text(data.database.lumberjackName);
    cuttedTrees.text(data.database.cuttingTrees);
    moneyInfo.text(`$${data.database.totalMoney}`);
    jobstarted = data.jobstatus
    axeData = data.axeData
    cuttedTree = data.database.cuttingTrees
    playerLevel = data.database.level

    if (cuttedTree >= axeData.tier3axeUpgradeLimit) {
      tier3axePercent.parent().parent().parent().parent().addClass("-equiped");
      bonusHeadder.css("display", "flex");
      bonusPercent.text(`${axeData.tier3axeBonusPercent}%`);
    } else if (cuttedTree >= axeData.tier2axeUpgradeLimit) {
      tier2axePercent.parent().parent().parent().parent().addClass("-equiped");
      bonusHeadder.css("display", "flex");
      bonusPercent.text(`${axeData.tier2axeBonusPercent}%`);
    } else {
      tier2axePercent.text(`${axeData.tier2axeBonusPercent}% EARNING`);
      tier2axeNeed.text(`${axeData.tier2axeUpgradeLimit} MORE trees`);
      tier3axePercent.text(`${axeData.tier3axeBonusPercent}% EARNING`);
      tier3axeNeed.text(`${axeData.tier3axeUpgradeLimit} MORE trees`);
      tier2axePercent.parent().parent().parent().parent().removeClass("-equiped");
      tier3axePercent.parent().parent().parent().parent().removeClass("-equiped");
      bonusHeadder.css("display", "none");
    }

    // if (data.passingTime !== 0) {
    //   var time = data.passingTime / 1000;
    //   var hours = Math.floor(time / 3600);
    //   var minutes = Math.floor((time % 3600) / 60);
    //   var seconds = Math.floor(time % 60);
    //   passedTime.text(`${String(hours).padStart(2, "0")} : ${String(minutes).padStart(2, "0")} : ${String(seconds).padStart(2, "0")}`);
    // }

    if (jobstarted) {
      $(".start-work h1").text("Stop Work!");
    }
    else {
      $(".start-work h1").text("Lest Get To WORK!");
    }
    StatusSection()
    $.post(
      `https://${GetParentResourceName()}/lumberjack:LeaderBoard`,
      JSON.stringify({}), function (data) {
        //console.log(JSON.stringify(data))
        if (data == false) { return }
        leaderboardContent.empty();
        for (let i = 0; i < data.length; i++) {
          leaderboardContent.append(`
              <div class="leaderboard-person">
                <div class="rank"><p>#${i + 1}</p></div>
                <div class="person-data-main">
                    <div class="person-data">
                        <img src="${data[i].profilePhoto}" alt="">
                        <h1 class="person-data-name">${data[i].name}</h1>
                    </div>
                    <div class="person-points">
                        <img src="assets/images/leaderboard-axe.png" alt="">
                        <h1 class="person-points-text">${data[i].cuttingTrees}</h1>
                    </div>
                </div>
              </div>
            `)
        }
      }
    );
  }
  if (data.action == "gfx:lumberjack:updateTime") {
    var time = data.passingTime / 1000;
    var hours = Math.floor(time / 3600);
    var minutes = Math.floor((time % 3600) / 60);
    var seconds = Math.floor(time % 60);
    passedTime.text(`${String(hours).padStart(2, "0")} : ${String(minutes).padStart(2, "0")} : ${String(seconds).padStart(2, "0")}`);
    cuttedTrees.text(data.cuttedtree);
    moneyInfo.text(`$${data.earnedmoney}`);
  }
});

$(document).on("keydown", function (e) {
  if (e.keyCode == 27) {
    DisplayScreen(false);
    //console.log("Closed");
  }
});

$(document).on("click", ".start-work", function (e) {
  if (jobstarted == false) {
    if (playerLevel == 0) {
      $.post(
        `https://${GetParentResourceName()}/gfx:client:lumberjack:startJob`,
        JSON.stringify({ bool: true, tutorial: true })
      );
      DisplayScreen(false)
      jobstarted = true
      StatusSection(true)
      //console.log("Started");
    } else {
      $.post(
        `https://${GetParentResourceName()}/gfx:client:lumberjack:startJob`,
        JSON.stringify({ bool: true, cuttedTree: cuttedTree })
      );
      DisplayScreen(false)
      jobstarted = true
      StatusSection(true)
      //console.log("Started");
    }
  }
  else {
    $.post(
      `https://${GetParentResourceName()}/gfx:client:lumberjack:stopJob`,
      JSON.stringify({ bool: false }.bool)
    );
    DisplayScreen(false)
    jobstarted = false
    StatusSection(false)
    //console.log("Stopped");
  }
});

$(document).on("click", ".contract-page-btn", function (e) {
  $(".main-content").css("display", "none");
  contractPage.css("display", "flex");
  $.post(
    `https://${GetParentResourceName()}/gfx:client:lumberjack:contractPage`,
    JSON.stringify({}), function (data) {
      //console.log(JSON.stringify(data))
      if (data == false) { return }
      contractList.empty();
      for (let i = 0; i < data.length; i++) {
        if (mycitizenid == undefined || mycitizenid == null ) { mycitizenid = data[i].citizenid }
        let takeJobtn = data[i].citizenid === data[i].contractCitizenid.toString() ? "Delete Contract" : "Take the JOB!";
        contractList.append(`
        <div class="contract-div" data-contractCitizenid = ${data[i].contractCitizenid} data-treeCount = ${data[i].treeCount} data-percent = ${data[i].percent} > 
          <div class="owner">
            <img src=${data[i].profilePhoto} class="owner-pp">
            <h1 class="owner-name">${data[i].owner}</h1>
          </div>  
          <div class="tree-count">
              <div class="contract-icon">
                <img src="assets/images/contract-icon.png" alt="">
                <h1>Tree Count</h1>
              </div>
              <h1 class="tree-count-text"><strong>${data[i].treeCount}</strong></h1>
          </div>
          <div class="contract-percent">
              <div class="contract-icon">
                <img src="assets/images/contract-icon2.png" alt="">
                <h1>Owner Percent</h1>
              </div>
              <h1 class="contract-percent-text"><strong>${data[i].percent}%</strong></h1>
          </div>
          <div class="take-contract-btn" data-contractCitizenid="${data[i].contractCitizenid}" >
              <h1>${takeJobtn}</h1>
          </div>
        </div>
        `)
      }
    }
  );
});

$(document).on("click", ".take-contract-btn", function (e) {
  let contractCitizenid = $(this).data("contractcitizenid")
  let contractOwnerid = $(this).parent().attr("data-contractCitizenid")
  let contractTreeCount = $(this).parent().attr("data-treeCount")
  let contractPercent = $(this).parent().attr("data-percent")
  if (mycitizenid == contractCitizenid) {
    $.post(
      `https://${GetParentResourceName()}/gfx:client:lumberjack:deleteContract`,
      JSON.stringify({ contractCitizenid : contractCitizenid })
    );
    $(this).parent().remove()
    //DisplayScreen(false)
    //console.log("Contract Deleted");
  } else {
    $.post(
      `https://${GetParentResourceName()}/gfx:client:lumberjack:takeContract`,
      JSON.stringify({
        ownerid: contractOwnerid,
        treeCount: contractTreeCount,
        percent: contractPercent,
        contractJob : true,
        startJob : true,
        cuttedTree : cuttedTree
        })
    );
    DisplayScreen(false)
    jobstarted = true
    StatusSection(true)
    //console.log("Contract Taken");
  }
});

$(document).on("click", ".make-contract-btn", function (e) {
  
  if (cutTreeInput.val() == "" || cutTreePercentInput.val() == "" || cutTreeInput.val() > config.contractSettings.maxTreeCount || cutTreePercentInput.val() > config.contractSettings.maxPercent || cutTreeInput.val() <= 0 || cutTreePercentInput.val() <= 0 || playerLevel < config.contractSettings.makeContractLevel) {
    return
  }
  $.post(
    `https://${GetParentResourceName()}/gfx:client:lumberjack:makeContract`,
    JSON.stringify({ treeCount: cutTreeInput.val(), percent: cutTreePercentInput.val() })
  );
  DisplayScreen(false)
  //console.log("Contract Made");
});

$(document).on("click", ".contract-headder-back-btn", function (e) {
  contractPage.css("display", "none");
  $(".main-content").css("display", "flex");
});

function DisplayScreen(bool) {
  var body = $(".main");
  if (bool == true) {
    body.css("display", "flex");
    StatusSection()
  } else if (bool == false) {
    body.css("display", "none");
    StatusSection(false)
    $.post(
      `https://${GetParentResourceName()}/gfx:client:lumberjack:closeUI`,
      JSON.stringify({ bool: false }.bool)
    );
  }
}
const statusDiv = $(".status");
const main = $(".main");
function StatusSection(bool){
  if (jobstarted && main.css("display") == "none") {
    //console.log("1111111")

    statusDiv.css("display", "flex");
    statusDiv.addClass("status-bottom")
    statusDiv.removeClass("status-top")
  } else if (main.css("display") == "flex") {
    //console.log("222222")
    
    statusDiv.css("display", "flex");
    statusDiv.addClass("status-top")
    statusDiv.removeClass("status-bottom")
  } else if (main.css("display") == "none" && jobstarted == false) {
    //console.log("333333")
    statusDiv.css("display", "none");
  }
}