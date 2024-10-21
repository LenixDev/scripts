main = {
    addPercentage = 10.0, -- This allows a 10% lee-way before classing the driver as speeding, set to 0 to disable
    addLimit = 2.0, -- This allows an addition of 2MPH to the speed limit before classing the driver as speeding, set to 0 to disable
    webhook = "https://discord.com/api/webhooks/1258905284584276059/o17zBPUMYyyfu2S48Id3zIPqFaNnELVGAqJnIXyMdt7mWQonAt4wTuu2flIxDI1EUr5X",
    webhookImage = "https://i.imgur.com/soIsgMS.jpg",
    webhookName = "Average Speed Camera",
    detectionRadius = 13.0, -- The distance from a camera you must be to start the detection process
    enableDiscordLogs = true,
    useKmh = true,
    exemptVehicleClasses = {}, -- Vehicle classes that are exempt from camera logging, use 18 for emergency, example = {18, 20} emergency + commercial
    flashScreen = true,
}

translations = {
    playerName = "Name:",
    cameraId = "Camera ID:",
    speedLimit = "Speed Limit:",
    speedDetected = "Speed Detected:",
    roadName = "Road Name:",
    name = "Name:",
    cameraActivation = "Camera Activation",
    timestamp = "Timestamp:",
    numberPlate = "Numberplate:",
}

config = {
    {
        limit = 40.0,
        cameraOne = {
            coords = vector3(444.98287963867,-1056.5445556641,31.312665939331),
            heading = 282.41,
        },
        cameraTwo = {
            coords = vector3(661.32177734375,-1029.9957275391,36.357902526855),
            heading = 276.83, 
        },
    },
	{
        limit = 40.0,
        cameraOne = {
            coords = vector3(658.33563232422,-1005.543762207,36.40079498291),
            heading = 95.75,
        },
        cameraTwo = {
            coords = vector3(473.50201416016,-1028.5477294922,34.133422851562),
            heading = 94.06, 
        },
    },
	{
        limit = 40.0,
        cameraOne = {
            coords = vector3(350.62048339844,-432.29998779297,44.790092468262),
            heading = 308.8,
        },
        cameraTwo = {
            coords = vector3(455.80966186523,-361.87857055664,46.9817237854),
            heading = 321.34, 
        },
    },
	{
        limit = 40.0,
        cameraOne = {
            coords = vector3(-107.51782226562,-81.61296081543,57.06286239624),
            heading = 72.55,
        },
        cameraTwo = {
            coords = vector3(-212.0237121582,-46.246025085449,50.180351257324),
            heading = 70.69, 
        },
    },
	{
        limit = 40.0,
        cameraOne = {
            coords = vector3(-434.33810424805,-283.46310424805,36.012050628662),
            heading = 231.67,
        },
        cameraTwo = {
            coords = vector3(-335.0393371582,-355.01068115234,30.285554885864),
            heading = 233.98, 
        },
    },
	{
        limit = 40.0,
        cameraOne = {
            coords = vector3(-360.45941162109,-375.57699584961,30.864515304565),
            heading = 78.45,
        },
        cameraTwo = {
            coords = vector3(-506.13827514648,-357.30908203125,35.157978057861),
            heading = 83.85, 
        },
    },
	{
        limit = 40.0,
        cameraOne = {
            coords = vector3(-650.45538330078,-695.44689941406,30.414356231689),
            heading = 180.12,
        },
        cameraTwo = {
            coords = vector3(-649.79779052734,-797.15832519531,24.987445831299),
            heading = 176.78, 
        },
    },
	{
        limit = 40.0,
        cameraOne = {
            coords = vector3(-75.229835510254,60.694786071777,71.862739562988),
            heading = 61.5,
        },
        cameraTwo = {
            coords = vector3(-185.1799621582,123.12972259521,69.926170349121),
            heading = 58.12, 
        },
    },
	{
        limit = 40.0,
        cameraOne = {
            coords = vector3(-260.5719909668,134.13558959961,69.172172546387),
            heading = 88.15,
        },
        cameraTwo = {
            coords = vector3(-362.3298034668,135.82562255859,66.313095092773),
            heading = 100.46, 
        },
    },
	{
        limit = 40.0,
        cameraOne = {
            coords = vector3(-353.70455932617,115.81559753418,66.584129333496),
            heading = 273.62,
        },
        cameraTwo = {
            coords = vector3(-251.89154052734,114.50567626953,69.402320861816),
            heading = 270.3, 
        },
    },
	{
        limit = 40.0,
        cameraOne = {
            coords = vector3(-190.12965393066,103.96865081787,69.984359741211),
            heading = 233.49,
        },
        cameraTwo = {
            coords = vector3(-129.3595123291,68.52970123291,71.103446960449),
            heading = 242.34, 
        },
    },
	{
        limit = 40.0,
        cameraOne = {
            coords = vector3(438.56994628906,-340.91506958008,47.560653686523),
            heading = 146.56,
        },
        cameraTwo = {
            coords = vector3(373.33578491211,-387.09866333008,46.267314910889),
            heading = 75.35, 
        },
    },
	{
        limit = 40.0,
        cameraOne = {
            coords = vector3(-60.305683135986,-1625.9523925781,29.349960327148),
            heading = 139.11,
        },
        cameraTwo = {
            coords = vector3(-122.76890563965,-1700.6539306641,29.390104293823),
            heading = 137.17, 
        },
    },
	{
        limit = 40.0,
        cameraOne = {
            coords = vector3(-490.53375244141,-1884.6572265625,17.126281738281),
            heading = 127.27,
        },
        cameraTwo = {
            coords = vector3(-657.22711181641,-2048.921875,15.876480102539),
            heading = 139.23, 
        },
    },
	{
        limit = 40.0,
        cameraOne = {
            coords = vector3(-697.54510498047,-2132.6315917969,12.92387676239),
            heading = 313.77,
        },
        cameraTwo = {
            coords = vector3(-509.18994140625,-1937.0714111328,16.271680831909),
            heading = 309.08, 
        },
    },
	{
        limit = 40.0,
        cameraOne = {
            coords = vector3(-525.49420166016,-1759.4007568359,21.476318359375),
            heading = 56.7,
        },
        cameraTwo = {
            coords = vector3(-631.42926025391,-1682.3999023438,24.854448318481),
            heading = 41.48, 
        },
    },
	{
        limit = 40.0,
        cameraOne = {
            coords = vector3(-648.3515625,-1686.1281738281,25.092130661011),
            heading = 222.64,
        },
        cameraTwo = {
            coords = vector3(-535.01446533203,-1770.5435791016,21.453063964844),
            heading = 234.4, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(-2210.8735351562,-329.95114135742,13.284916877747),
            heading = 83.93,
        },
        cameraTwo = {
            coords = vector3(-2443.3112792969,-213.90129089355,16.651031494141),
            heading = 58.97, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(-3078.5261230469,789.59637451172,19.577573776245),
            heading = 40.69,
        },
        cameraTwo = {
            coords = vector3(-3110.7919921875,1036.3386230469,19.774826049805),
            heading = 342.09, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(-2687.4711914062,2344.3610839844,16.974802017212),
            heading = 345.83,
        },
        cameraTwo = {
            coords = vector3(-2540.8559570312,3409.2993164062,13.260911941528),
            heading = 345.43, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(-2023.4357910156,4480.2866210938,56.99373626709),
            heading = 312.92,
        },
        cameraTwo = {
            coords = vector3(-1747.9794921875,4750.94921875,57.145847320557),
            heading = 306.99, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(-659.82476806641,5547.4184570312,38.510738372803),
            heading = 300.39,
        },
        cameraTwo = {
            coords = vector3(-511.00988769531,5789.7143554688,35.243755340576),
            heading = 329.52, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(1578.3236083984,6390.5654296875,25.315034866333),
            heading = 246.43,
        },
        cameraTwo = {
            coords = vector3(1955.3366699219,6180.5122070312,45.37133026123),
            heading = 200.29, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(2630.064453125,5060.2797851562,44.745746612549),
            heading = 12.36,
        },
        cameraTwo = {
            coords = vector3(2693.4572753906,4807.2514648438,44.49284362793),
            heading = 9.8, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(2901.0280761719,3812.6240234375,52.625896453857),
            heading = 168.9,
        },
        cameraTwo = {
            coords = vector3(2817.9675292969,3523.1821289062,54.388683319092),
            heading = 155.75, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(1768.6746826172,2124.34765625,64.619857788086),
            heading = 168.59,
        },
        cameraTwo = {
            coords = vector3(1713.0434570312,1642.7545166016,82.644905090332),
            heading = 170.44, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(895.64306640625,206.25086975098,76.915687561035),
            heading = 141.92,
        },
        cameraTwo = {
            coords = vector3(698.24737548828,-97.587524414062,54.69966506958),
            heading = 155.19, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(753.53826904297,-89.052146911621,55.726989746094),
            heading = 334.01,
        },
        cameraTwo = {
            coords = vector3(967.62841796875,219.27346801758,78.544624328613),
            heading = 315.97, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(1726.4494628906,1525.2784423828,84.682807922363),
            heading = 349.84,
        },
        cameraTwo = {
            coords = vector3(1925.5909423828,2426.2824707031,54.544471740723),
            heading = 337.98, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(2838.658203125,3503.50390625,54.494731903076),
            heading = 155.89,
        },
        cameraTwo = {
            coords = vector3(2928.4038085938,3810.8823242188,52.523067474365),
            heading = 170.11, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(2699.7863769531,4808.2485351562,44.465930938721),
            heading = 191.13,
        },
        cameraTwo = {
            coords = vector3(2640.6008300781,5072.4487304688,44.729747772217),
            heading = 195.73, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(-1388.2403564453,5111.3305664062,60.805278778076),
            heading = 119.64,
        },
        cameraTwo = {
            coords = vector3(-1780.3439941406,4752.9418945312,57.021892547607),
            heading = 131.62, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(-2554.3156738281,3469.7424316406,13.503871917725),
            heading = 157.08,
        },
        cameraTwo = {
            coords = vector3(-2716.2976074219,2351.6921386719,16.725425720215),
            heading = 170.4, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(-3012.1589355469,604.90832519531,19.905235290527),
            heading = 188.57,
        },
        cameraTwo = {
            coords = vector3(-3041.8798828125,262.9870300293,15.8274974823),
            heading = 169, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(-2409.8366699219,-268.48275756836,15.249264717102),
            heading = 236.04,
        },
        cameraTwo = {
            coords = vector3(-2242.6208496094,-358.13027954102,13.323234558105),
            heading = 267.33, 
        },
    },
	{
        limit = 70.0,
        cameraOne = {
            coords = vector3(-469.55352783203,-542.77563476562,25.32550239563),
            heading = 269.24,
        },
        cameraTwo = {
            coords = vector3(-119.56600189209,-540.83813476562,30.305284500122),
            heading = 268.4, 
        },
    },
}
