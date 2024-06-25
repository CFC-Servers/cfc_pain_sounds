local modelSounds = include("cl_sounds.lua")
local cit_male, cit_female
cit_male, cit_female = modelSounds.cit_male, modelSounds.cit_female
local IsValid, RealTime, rawget, rawset
do
  local _obj_0 = _G
  IsValid, RealTime, rawget, rawset = _obj_0.IsValid, _obj_0.RealTime, _obj_0.rawget, _obj_0.rawset
end
local random
random = math.random
local find
find = string.find
local modelCache = { }
local guessSounds
guessSounds = function(mdl)
  return find(mdl, "/female") and cit_female or cit_male
end
local randomSound
randomSound = function(sounds)
  return rawget(sounds, random(#sounds))
end
local volume = 1
local channel = CHAN_VOICE
local _enabled
local enabled
enabled = function()
  _enabled = _enabled or GetConVar("cfc_painsounds_enabled")
  return _enabled:GetBool()
end
local _minDamage
local minDamage
minDamage = function()
  _minDamage = _minDamage or GetConVar("cfc_painsounds_min_dmg")
  return _minDamage:GetInt()
end
local _cooldown
local cooldown
cooldown = function()
  _cooldown = _cooldown or GetConVar("cfc_painsounds_cooldown")
  return _cooldown:GetFloat()
end
local _quiet
local quiet
quiet = function()
  _quiet = _quiet or GetConVar("cfc_painsounds_quiet")
  return _quiet:GetBool()
end
return net.Receive("CFC_PainSounds_TookDamage", function()
  if not (enabled()) then
    return 
  end
  local victim = net.ReadEntity()
  if not (IsValid(victim)) then
    return 
  end
  if (victim.lastPainSound or 0) > RealTime() - cooldown() then
    return 
  end
  local dmg = net.ReadUInt(7)
  if dmg < minDamage() then
    return 
  end
  local mdl = victim:GetModel()
  local sounds = rawget(modelSounds, mdl) or rawget(modelCache, mdl) or guessSounds(mdl)
  rawset(modelCache, mdl, sounds)
  local sound = randomSound(sounds)
  local level = quiet() and 45 or 75
  volume = quiet() and 0.4 or 1
  local pitch = random(90, 110)
  victim:EmitSound(sound, level, pitch, volume, channel)
  victim.lastPainSound = RealTime()
end)
