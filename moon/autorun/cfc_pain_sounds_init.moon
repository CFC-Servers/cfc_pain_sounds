AddCSLuaFile "cfc_pain_sounds/cl_sounds.lua"
AddCSLuaFile "cfc_pain_sounds/cl_pain_sounds.lua"
AddCSLuaFile "cfc_pain_sounds/cl_options.lua"

return include "cfc_pain_sounds/sv_pain_relay.lua" if SERVER

include "cfc_pain_sounds/cl_options.lua"
include "cfc_pain_sounds/cl_pain_sounds.lua"
