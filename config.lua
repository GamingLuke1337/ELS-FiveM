Config = {}

Config.update = true

Config.playButtonPressSounds = true

Config.vehicleSyncDistance = 150
Config.environmentLightBrightness = 0.006
Config.lightDelay = 10 -- Time in MS
Config.flashDelay = 15

Config.panelEnabled = true
Config.panelType = "original"
Config.panelOffsetX = 0.0
Config.panelOffsetY = 0.0

Config.allowedPanelTypes = {"original", "old"}

-- https://docs.fivem.net/game-references/controls

Config.shared = {
    horn = 86
}

Config.keyboard = {
    modifyKey = 132,
    stageChange = 85, -- Q
    guiKey = 199, -- P
    takedown = 83, -- =
    siren = {
        tone_one = 157, -- 1
        tone_two = 158, -- 2
        tone_three = 160 -- 3
    },
    pattern = {
        primary = 163, -- 9
        secondary = 162, -- 8
        advisor = 161 -- 7
    },
    hazard = {
        hazard_key = 202, -- Backspace
        left_signal_key = 84, -- [
        right_signal_key = 83 -- ]
    },
    warning = 246, -- Y
    secondary = 303, -- U
    primary = 7 -- ??
}

Config.controller = {
    modifyKey = 73,
    stageChange = 80,
    takedown = 74,
    siren = {
        tone_one = 173,
        tone_two = 85,
        tone_three = 172
    }
}
