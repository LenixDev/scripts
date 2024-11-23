cartArr = []
shared = []
count = 1
control = false
totalCartPrice = 0;
itemList = []
marketType = ""
shopname = ""

window.addEventListener("message", function (e) {
    e = e.data
    switch (e.action) {
        case "OPEN":
            return openMenu(e.data)
        case "CLOSE":
            return closeNUI()
        case "UPDATE":
            return update(e.data)
        default:
            return;
    }
});

$(document).on('click', '.fa-shopping-cart', function (e) {
    var type = $(this).data("type");
    var price = $(this).data("price");
    var image = $(this).data("image");
    var id = $(this).data("id");
    var itemname = $(this).data("itemname");
    var iteminfo = $(this).data("iteminfo");
    var cid = $(this).data("cid");
    var pos = $(this).data("pos");
    var amount = $(this).data("amount");

    var existingCartItem = cartArr.find(item => item.id === id);

    if (existingCartItem) {
        if (existingCartItem.amount > existingCartItem.count) {
            existingCartItem.count++;
        }
    } else {
        cartArr.push({
            type: type,
            price: price,
            id: id,
            itemname: itemname,
            iteminfo: iteminfo,
            count: 1,
            cid: cid,
            pos: pos,
            amount: amount,
        });
        if (marketType == "market") {

            $(".cart-box").append(`
      <div class="cart-item item-${id}">
          <div class="cart-img">
          <img src="nui://qb-inventory/html/images/${shared[itemname].image}" alt="">
          </div>
          <div class="cart-name" style="text-transform: capitalize;">${shared[itemname].label}</div>
          <div class="cart-price">$${price}</div>
          <div class="cart-count">x1</div>  
          <div data-id=${id} class="eksi-box">
          <div class="ex">-</div>
          </div>
          <div data-id=${id} class="arti-box">
          <div class="arti">+</div>
          </div>
          <div data-id=${id} class="delete-box">
          <div class="delete">
          <i class="fas fa-trash-alt"></i>
          </div>
          </div>
      </div>
      `);
        } else {
            $(".job-cart-box").append(`
      <div class="job-cart-item item-${id}">
      <div class="cart-img">
        <img src="nui://qb-inventory/html/images/${shared[itemname].image}" alt="">
      </div>
      <div class="cart-name" style="text-transform: capitalize;">${shared[itemname].label}</div>
      <div class="cart-price">$${price}</div>
        <div class="cart-count">x3</div>  
      <div data-id=${id} class="eksi-box">
          <div class="ex">-</div>
        </div>
        <div data-id=${id} class="arti-box">
          <div class="arti">+</div>
        </div>
        <div data-id=${id} class="delete-box">
          <div class="delete">
            <i class="fas fa-trash-alt"></i>
          </div>
        </div>
    </div>
      `);
        }

        $.post("https://qb-shops/setCart", JSON.stringify({
            type: type,
            price: price,
            image: image,
            id: id,
            count: 1
        }));
    }

    updateCartView();
});


$(document).on('click', '.eksi-box', function (e) {
    var id = $(this).data("id");
    var existingCartItem = cartArr.find(item => item.id === id);
    if (existingCartItem.count === 1) {
        cartArr = cartArr.filter(item => item.id !== id);
        $(`.item-${id}`).remove();
    } else {
        existingCartItem.count--;
    }
    
    updateCartView();
});

$(document).on('click', '.arti-box', function (e) {
    var id = $(this).data("id");
    var existingCartItem = cartArr.find(item => item.id === id);
    if (existingCartItem.amount > existingCartItem.count) {
        existingCartItem.count++;
        updateCartView();
    }
});

$(document).on('click', '.delete-box', function (e) {
    var id = $(this).data("id");
    cartArr = cartArr.filter(item => item.id !== id);
    $(`.item-${id}`).remove();

    updateCartView();
});

$(document).on('click', '.MDMDLeftSide', function (e) {
    var category = $(this).data("category");
    $(".item-box").empty()
    appendItem(itemList[category])
})

$(document).on('click', '.job-category-item', function (e) {
    var category = $(this).data("category");
    $(".job-item-box").empty()
    appendJobItem(itemList[category])
})

$(document).on('click', '.pay', function (e) {
    payType = $(this).data("type");
    $.post("https://qb-shops/pay", JSON.stringify({ price: totalCartPrice, payType: payType, cartArr: cartArr, shopname: shopname }));
    $(".cart-box").html("")
    $(".total-price,.job-cart-price").html("$0");
    cartArr = []
    $("body").hide()
    $.post("https://qb-shops/close", JSON.stringify({}));
    $(".job-box,.job-cart-circle").animate({
        top: "15rem"
    }, 500)
})



document.getElementById('scrollBox').addEventListener('wheel', function (e) {
    if (e.deltaY < 0) {
        this.scrollLeft += 50;
    } else {
        this.scrollLeft -= 50;
    }
    e.preventDefault();
});

document.getElementById('jobscroll').addEventListener('wheel', function (e) {
    if (e.deltaY < 0) {
        this.scrollLeft += 30;
    } else {
        this.scrollLeft -= 30;
    }
    e.preventDefault();
});


function updateCartView() {
    totalCartPrice = cartArr.reduce((total, item) => total + item.price * item.count, 0);

    $(".total-price,.job-cart-price").html(`$${totalCartPrice}`);
    cartArr.forEach(item => {
        $(`.item-${item.id}`).find(".cart-count").html(`x${item.count}`);
        $(`.item-${item.id}`).find(".cart-price").html(`$${item.price * item.count}`);
    });
}
//        <img class="icon" src="../html/miniicon.png" alt=""> line 203
function appendItem(data) {
    $.each(data, function (i, v) {
        $(".item-box").append(`
        <div class="item">

        <div class="itemoney">${v.price}$</div>
        <div class='amount'>x${v.amount}</div>
        <div class="moneybox"></div>
        <img class="img" src="nui://qb-inventory/html/images/${shared[v.name].image}" alt="">
        <div class="itemalt">
            <div class="item-name">${shared[v.name].label}</div>
            <div class="item-altcategory">Weapons</div>
            <div class="cartbox">
            <i data-id="${i}-${v.name}" data-image="${v.image}" data-type="${v.type}" data-price="${v.price}" data-itemname="${v.name}" data-amount="${v.amount}" data-cid="${v.cid}" data-pos="${i}" id="shopcart-${i}" class="fas fa-shopping-cart"></i></div>
        </div>
        <div class="itemalthr"</div>
      </div>`)
      var $store = $("#shopcart-"+i)
      $store.data('iteminfo', v.info)
    })
}

//      <img class="job-icon" src="../html/miniicon.png" alt="">  -- line 228

function appendJobItem(data) {
    $(".job-item-box").empty();
    $.each(data, function (i, v) {
        $(".job-item-box").append(`
    <div class="job-item">

      <div class="job-dollarbox">
      </div>
      <i class="fa-solid fa-dollar-sign job-dollaricon"></i>
      <div class="job-itemoney">${v.price}</div>
      <div class="job-moneybox"></div>
      <img class="job-img" src="nui://qb-inventory/html/images/${shared[v.name].image}" alt="">
      <div class="job-itemaltt">
        <div class="job-item-name">${shared[v.name].label}</div>
        <div class="job-item-altcategory">Weapons</div>
        <div class="job-cartbox">
        <i data-id="${i}" data-image="${v.image}" data-type="${v.type}" data-price="${v.price}" data-itemname="${v.name}" data-iteminfo="${v.info}" class="fas fa-shopping-cart"></i>
        </div>
      </div>
      <div class="job-itemalthr"</div>
    </div>`)
    })
}

function openMenu(data) {
    var firstData = data.marketItemList[1];
    itemList = data.marketItemList;
    shared = data.shared
    shopname = data.marketName
    $(".total-price,.job-cart-price").html("$0");
    $(".cart-box").html("")
    cartArr = []
    if (data.marketJob != "") {
        marketType = "job"
        $(".box,.bg").hide()
        $(".job-market,body").show()
        $(".job-box,.job-cart-circle").animate({
            top: "0px"
        }, 500)

        var str = data.marketName;
        var words = str.split(' ');

        if (words.length >= 2) {
            $(".job-header").html(`${words[0]} <span style="font-family: AkrobatExtraLight;">${words[1]}</span>`)
        } else {
            $(".job-header").html(`${words[0]}`)
        }

        $(".job-text-box").html("News")
    
        $(".job-category").empty()
        $.each(data.marketCategoryList, function (i, v) {
            $(".job-category").append(`
      <div data-category="${i}" class="job-category-item">
      <div class="job-category-name">${i}</div>
      <div class="job-itemalt"></div>
    </div>
      `)
        })

        appendJobItem(firstData)

    } else {
        marketType = "market"
        $("body,.box,.bg").show()
        $(".job-market").hide()
        $(".category,.item-box").empty()
        $(".header").html(data.marketName)
        $(".alt").html(data.marketCategory)
        firstelement = Object.keys(data.marketCategoryList)[0]
        appendItem(itemList[firstelement])
    

        appendItem(firstData)

        $.each(data.marketCategoryList, function (i, v) {
            $(".category").append(`
      <div id="MDMarkerDiv">
      <div data-category="${i}" class="MDMDLeftSide">
      <div class="MDMDLDDiv1"></div>
      <div class="MDMDLDDiv2">
      <i style="transform: rotate(-135deg); font-size: 10px;" class="fad fa-building"></i>
      </div>
        <div class="categoryname">${i}</div>
        <div class="categorydesc">${v}</div>
        <div class="MDMDLDDiv3">
        </div>
        </div>
        </div> 
        
        `)
        })
    }
}

function capitalizeFirstLetter(word) {
    return word.charAt(0).toUpperCase() + word.slice(1);
}

function closeNUI() {
    $(".cart-box").html("")
    $(".total-price,.job-cart-price").html("$0");
    cartArr = []
    $("body").hide()
    $.post("https://qb-shops/close", JSON.stringify({}));
    $(".job-box,.job-cart-circle").animate({
        top: "15rem"
    }, 500)
}

document.addEventListener('keydown', function (event) {

    if (event.key === 'Escape') {
        closeNUI();
    }
});