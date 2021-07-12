CreateClientConVar "cfc_painsounds_enabled", 1, true, true, "Are CFC PainSounds enabled", 0, 1
CreateClientConVar "cfc_painsounds_quiet", 0, true, false, "Should the pain sounds be quieter?", 0, 1
CreateClientConVar "cfc_painsounds_min_dmg", 25, true, false, "How much damage do players have to take before making a sound?", 1, 100
CreateClientConVar "cfc_painsounds_cooldown", 1, true, false, "How often can a player make sounds?", 0, 2

populatePanel = (panel) ->
    with panel
        \CheckBox "Enable Pain Sounds", "cfc_painsounds_enabled"
        \CheckBox "Quiet Mode (reduces volume)", "cfc_painsounds_quiet"
        \NumSlider "Minimum Damage to trigger Pain Sounds", "cfc_painsounds_min_dmg", 1, 100, 0
        \NumSlider "Per-player cooldown", "cfc_painsounds_cooldown", 0, 2, 1

hook.Add "AddToolMenuCategories", "CFC_PainSounds_ListManager", ->
    spawnmenu.AddToolCategory "Options", "CFC", "CFC"

hook.Add "PopulateToolMenu", "CFC_PainSounds_MenuOption", ->
    spawnmenu.AddToolMenuOption "Options", "CFC", "painsounds_is_enabled", "Pain Sounds", "", "", (panel) ->
        populatePanel panel
