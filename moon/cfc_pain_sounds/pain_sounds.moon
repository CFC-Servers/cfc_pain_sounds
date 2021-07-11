modelSounds = include "sounds.lua"

import cit_male, cit_female from modelSounds
import IsValid, rawget, rawset from _G
import random from table
import find from string

modelCache = {}
guessSounds = (mdl) -> cit_female if find mdl, "/female" else cit_male
guessSounds = (mdl) -> find(mdl, "/female") and cit_female or cit_male
randomSound = (sounds) -> rawget sounds, random #sounds

sound = randomSound sounds
level = 70
pitch = 100
volume = 1
channel = CHAN_VOICE

hook.Add "PostEntityTakeDamage", "CFC_PainSounds", (victim, dmg, took) ->
    return unless took
    return unless IsValid victim
    return unless victim\IsPlayer!
    return unless dmg\GetDamage! > 20

    mdl = victim\GetModel!
    sounds = rawget(modelSounds, mdl) or rawget(modelCache, mdl) or guessSounds mdl
    rawset modelCache, mdl, sounds

    victim\EmitSound sound, level, pithc, volume, channel
