window.addEventListener('message', function (event) {
	let e = event.data;
	
	if (e.show == true && e.type == "policebadge") {
		const badgeInfo = e.info
		$(".policebadge-img").attr("src", badgeInfo['picture'])
		$(".policebadge-callsign").html(badgeInfo['callsign'])
		$(".policebadge-firstname").html(badgeInfo['firstname'])
		$(".policebadge-lastname").html(badgeInfo['lastname'])
		$(".policebadge-dept").html(badgeInfo['job'])
		$(".policebadge-rank").html(badgeInfo['rank'])
		$("#image1").attr('xlink:href', "img/lspdbadge.png");
		$(".badge-dept-img").attr("src", "img/lspd.png")
		$(".badge-dept-container").css("background", "#347BC8")
		$(".policebadge-container").slideDown(250)
	} else if (e.show == false) {
		$(".policebadge-container").slideUp(250)
		$(".emsbadge-container").slideUp(250)
		$(".idcard-container").fadeOut(250)
		$(".unocard-container").fadeOut(250)
		$(".mediabadge-container").fadeOut(250)
		if (e.type == "axon") {
			$(".axon-container").fadeOut(250)
		}
	}	
});