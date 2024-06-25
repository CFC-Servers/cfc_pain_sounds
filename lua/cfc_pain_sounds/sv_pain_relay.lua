local Recipientfilter, IsValid, CurTime
do
  local _obj_0 = _G
  Recipientfilter, IsValid, CurTime = _obj_0.Recipientfilter, _obj_0.IsValid, _obj_0.CurTime
end
local min
min = math.min
local COOLDOWN = 0.1
local unreliable = true
local checkIsEnabled
checkIsEnabled = function(ply)
  return ply:GetInfoNum("cfc_painsounds_enabled", 1) == 1
end
local enabled = { }
timer.Create("CFC_PainSounds_Options", 1, 0, function()
  do
    local _tbl_0 = { }
    local _list_0 = player.GetAll()
    for _index_0 = 1, #_list_0 do
      local ply = _list_0[_index_0]
      _tbl_0[ply] = checkIsEnabled(ply)
    end
    enabled = _tbl_0
  end
end)
util.AddNetworkString("CFC_PainSounds_TookDamage")
return hook.Add("PostEntityTakeDamage", "CFC_PainSounds", function(victim, dmg, took)
  if not (took) then
    return 
  end
  if not (IsValid(victim)) then
    return 
  end
  if not (victim:IsPlayer()) then
    return 
  end
  if not ((victim.lastPainSound or 0) < CurTime() - COOLDOWN) then
    return 
  end
  local damageAmount = min(dmg:GetDamage(), 1000)
  if not (damageAmount >= 1) then
    return 
  end
  local rf
  do
    local _with_0 = RecipientFilter()
    _with_0:AddPAS(victim:GetPos())
    local _list_0 = _with_0:GetPlayers()
    for _index_0 = 1, #_list_0 do
      local p = _list_0[_index_0]
      if not enabled[p] then
        _with_0:RemovePlayer(p)
      end
    end
    rf = _with_0
  end
  net.Start("CFC_PainSounds_TookDamage", unreliable)
  net.WriteEntity(victim)
  net.WriteUInt(7, damageAmount)
  net.Send(rf)
  victim.lastPainSound = CurTime()
end)
