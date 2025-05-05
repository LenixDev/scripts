local Translations = {
    notify = {
        ["hud_restart"] = "HUD Is now restarting!",
        ["hud_restarted"] = "HUD is successfully restarted!",
        ["playanim_disabled"] = "Gear animation is disabled!",
        ["playanim_enabled"] = "Gear animation is enabled!",
    },
    error = {
        ["gain_stress"] = "You are starting to feel stressed..",
        ["relax_stress"] = "You are starting to feel relaxed..",
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})