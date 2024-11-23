function FormatDocTemplate(docType, key, values) {
    var html = Config.Documents.Formats[docType].Formatting[key]
    for (const [k, v] of Object.entries(values)) {
        html = html.replaceAll(`{${k}}`, v)
    }
    return html
}

function DisplayDocument(values) {
    var container = values.container
    $("#app-document").html(container)
    $("#app-document").attr("style",values.appStyle)
    $("#app-card").attr("class", "inactive")
    $("#app-document").attr("class", "inactive")
    for (const [key, value] of Object.entries(values.elements)) {
        var html = "";
        for (var i=0; i<value.length; i++) {
            if (value[i].html) {
                html += value[i].html
            }
            else  {
                html += `
                    <div class="row">
                        <b>${value[i].label}</b>
                        <span style="margin-left: auto;">${value[i].value}</span>
                    </div>
                `
            }
        }
        $(key).html(html);
    }
    $("#app-document").attr("class", "active")
}

window.addEventListener("message", function(ev) { 
    if (ev.data.name == "DisplayDocument") {
        DisplayDocument(ev.data.value)
    }
    else if (ev.data.name == "HideScreen") {
        $("#app-document").attr("class", "inactive")
    }
})