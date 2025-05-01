CreateClientConVar("cfc_painsounds_enabled", 1, true, true, "Are CFC PainSounds enabled", 0, 1)
CreateClientConVar("cfc_painsounds_quiet", 0, true, false, "Should the pain sounds be quieter?", 0, 1)
CreateClientConVar("cfc_painsounds_min_dmg", 25, true, false, "How much damage do players have to take before making a sound?", 1, 100)
CreateClientConVar("cfc_painsounds_cooldown", 1, true, false, "How often can a player make sounds?", 0, 2)
local populatePanel
populatePanel = function(panel)
  do
    local _with_0 = panel
    _with_0:CheckBox("Enable Pain Sounds", "cfc_painsounds_enabled")
    _with_0:CheckBox("Quiet Mode (reduces volume)", "cfc_painsounds_quiet")
    _with_0:NumSlider("Minimum Damage to trigger Pain Sounds", "cfc_painsounds_min_dmg", 1, 100, 0)
    _with_0:NumSlider("Per-player cooldown", "cfc_painsounds_cooldown", 0, 2, 1)
    return _with_0
  end
end
hook.Add("AddToolMenuCategories", "CFC_PainSounds_ListManager", function()
  return spawnmenu.AddToolCategory("Options", "CFC", "CFC")
end)
return hook.Add("PopulateToolMenu", "CFC_PainSounds_MenuOption", function()
  return spawnmenu.AddToolMenuOption("Options", "CFC", "painsounds_is_enabled", "Pain Sounds", "", "", function(panel)
    return populatePanel(panel)
  end)
end)
