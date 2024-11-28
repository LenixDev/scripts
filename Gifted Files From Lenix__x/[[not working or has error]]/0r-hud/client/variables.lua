Koci           = {}
Koci.Framework = Utils.Functions:GetFramework()
Koci.Utils     = Utils.Functions
Koci.Callbacks = {}
Koci.Client    = {
    HUD = {
        data = {
            isVisible = true,
            bars = {
                voice = {
                    microphone = false,
                    radio = false,
                    isTalking = false,
                    range = 1,
                },
                health = nil,
                armor = nil,
                hunger = nil,
                thirst = nil,
                oxygen = nil,
                stamina = nil,
                stress = nil,
                terminal = nil,
                leaf = nil,
            },
            vehicle = {
                thick = {
                    wait = 200
                },
                entity = nil,
                kmH = Config.Settings.VehicleHUD.kmH,
                show = false,
                isSeatbeltOn = false,
                isPassenger = false,
                cruiseControlStatus = nil,
                inVehicle = false,
                speed = 0,
                fuel = {
                    level = 0,
                    max_level = 0,
                    type = nil,
                },
                rpm = 0,
                gear = nil,
                miniMap = {
                    style = "square"
                },
                speedoMeter = {
                    fps = nil
                },
                type = 2,
                lightsOn = false,
                manualMode = false,
                manualGear = "N"
            },
            compass = {
                show = false,
                heading = 0,
                lastCrossRoadCheck = -1,
                crossRoad = {
                    street1 = nil,
                    street2 = nil
                },
            }
        },
    }
}
