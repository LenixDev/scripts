function FormatTemplate(licenseType, key, values) {
    var html = Config.Cards.Formats[licenseType].Formatting[key]
    for (const [k, v] of Object.entries(values)) {
        html = html.replaceAll(`{${k}}`, v)
    }
    return html
}

function DisplayCard(values) {
    var container = values.container
    for (const [k, v] of Object.entries(values.formatValues)) {
        container = container.replaceAll(`{${k}}`, v)
    }
    $("#app-card").html(container)
    $("#app-card").attr("style",values.appStyle)
    $("#app-card").attr("class", "inactive")
    $("#app-document").attr("class", "inactive")
    $("#ac-photo").attr("style", `background: url('${values.photoURL}'); background-size: auto 100%; background-position: center;`)
    var metaHTML = "";
    for (var i=0; i<values.metaValues.length; i++) {
        metaHTML += `
            <div>
                <span>${values.metaValues[i].label}</span>
                <b>${values.metaValues[i].value}</b>
            </div>
        `
    }
    $("#ac-info3").html(metaHTML);
    $("#app-card").attr("class","active")
}

window.addEventListener("message", function(ev) { 
    if (ev.data.name == "DisplayCard") {
        DisplayCard(ev.data.value)
    }
    else if (ev.data.name == "HideScreen") {
        $("#app-card").attr("class", "inactive")
    }
})