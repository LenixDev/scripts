console.log("discord.gg/debux | Tebex : debux.tebex.io");
$(document).ready(function () {
  window.addEventListener("message", function (event) {
    if (event.data.action == "OpenMenu") {
      $("body").css("display", "block");
      $(".ui-1").css("display", "flex");
    } else if (event.data.action == "updateDetail") {
      detail = event.data.details;
      $(".MoneyAmount").html("$" + detail.money);
      $(".KeyAmount").html(detail.key + " Key");
    } else if (event.data.action == "addContainer") {
      if (event.data.CasePriceTyp == "money") {
        html =
          `
        <div class="Product" >
            <div class="ProductImage"></div>
            <div class="ProductLabel">
              ` +
          event.data.CaseName +
          `
              <div class="ProductAltLabel">CASE</div></div>
              <div class="ProductDetail">` +
          event.data.CaseName +
          ` Case<p>` +
          event.data.CaseDesc +
          `</p></div>
              <div onclick="GetProductDetail(this.id)" id="` +
          event.data.id +
          `" class="OpenProduct">Open for $` +
          event.data.CasePrice +
          `</div>
          </div>
    `;
      } else {
        html =
          `
        <div class="Product">
            <div class="ProductImage"></div>
            <div class="ProductLabel">
              ` +
          event.data.CaseName +
          `
              <div class="ProductAltLabel">CASE</div></div>
              <div class="ProductDetail">` +
          event.data.CaseName +
          ` Case<p>` +
          event.data.CaseDesc +
          ` </p></div>
              <div onclick="GetProductDetail(this.id)" id="` +
          event.data.id +
          `" class="OpenProduct" >Open for ` +
          event.data.CasePrice +
          ` Key</div>
          </div>
    `;
      }
      $(".Products").prepend(html);
    } else if (event.data.action == "getDetail") {
      $(".ProductItems").empty();
      if (event.data.CasePriceTyp == "money") {
        $(".OpenDetailCase").html("Open for $" + event.data.CasePrice);
      } else {
        $(".OpenDetailCase").html("Open for " + event.data.CasePrice + " Key");
      }
      $(".DetailCaseLabel").html(
        event.data.CaseName + " Case <p>" + event.data.CaseDesc + "</p>"
      );
      $(".DetailProductLabel").html(
        event.data.CaseName + '<div class="DetailProductAltLabel">CASE</div>'
      );
    } else if (event.data.action == "addProduct") {
      html =
        `
          <div class="ProductItem">
            <div class="ProductItemLine"></div>
            <div class="ProductItemImage" style="background-image: url(./imgs/items/` +
        event.data.productimg +
        `);"></div>
            <div class="ProductItemLabel">` +
        event.data.productName +
        ` </div>
          </div>
        `;
      $(".ProductItems").prepend(html);
    } else if (event.data.action == "away") {
      $(".ui-3").css("display", "none");
      $("body").css("display", "block");
      $(".ui-2").css("display", "flex");
      $(".away-label").html(event.data.itemlabel);
      $(".away-count").html("Count : " + event.data.itemcount);
      $(".away-image").css(
        "background-image",
        "url(./imgs/items/" + event.data.itemimage + ")"
      );
    } else if (event.data.action == "skip") {
      $(".skip-anim").html("Skip Video");
      $("body").css("display", "block");
      $(".ui-3").css("display", "flex");
    }
  });
});

$(document).on("keydown", function (event) {
  switch (event.keyCode) {
    case 27: // ESC
      closex();
  }
});

function closex() {
  $("body").css("display", "none");
  $(".ui-2").css("display", "none");
  $(".ui-1").css("display", "none");
  $(".Products").empty();
  $(".ProductItems").empty();
  $.post("https://BakiTelli_container/close");
}

function GetProductDetail(id) {
  $.post(
    "https://BakiTelli_container/getdetail",
    JSON.stringify({
      id: id,
    })
  );
}

function OpenCase() {
  $.post("https://BakiTelli_container/OpenCase");
  closex();
}

function Okey() {
  closex();
}

function SkipVideo() {
  $(".skip-anim").html("Waiting...");
  $.post("https://BakiTelli_container/SkipVideo");
}
