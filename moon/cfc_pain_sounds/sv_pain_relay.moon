import Recipientfilter, IsValid, CurTime from _G
COOLDOWN = 0.1

checkIsEnabled = (ply) -> ply\GetInfoNum("cfc_painsounds_enabled", 1) == 1

enabled = {}
timer.Create "CFC_PainSounds_Options", 1, 0, ->
    enabled = {ply, checkIsEnabled ply for ply in *player.GetAll!}

util.AddNetworkString "CFC_PainSounds_TookDamage"
hook.Add "PostEntityTakeDamage", "CFC_PainSounds", (victim, dmg, took) ->
    return unless took
    return unless IsValid victim
    return unless victim\IsPlayer!
    return unless (victim.lastPainSound or 0) < CurTime! - COOLDOWN

    damageAmount = dmg\GetDamage!
    return unless damageAmount >= 1

    with rf = RecipientFilter!
        \AddPAS victim\GetPos!
        \RemovePlayer p for p in *rf\GetPlayers! when not enabled[p]

    net.Start "CFC_PainSounds_TookDamage"
    net.WriteEntity victim
    net.WriteUInt 7, damageAmount
    net.Send rf

    victim.lastPainSound = CurTime!
