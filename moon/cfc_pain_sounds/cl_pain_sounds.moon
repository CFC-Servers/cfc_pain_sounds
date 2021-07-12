modelSounds = include "cl_sounds.lua"

import cit_male, cit_female from modelSounds
import IsValid, RealTime, rawget, rawset from _G
import random from math
import find from string

modelCache = {}
guessSounds = (mdl) -> find(mdl, "/female") and cit_female or cit_male
randomSound = (sounds) -> rawget sounds, random #sounds

volume = 1
channel = CHAN_VOICE

local _enabled
enabled = ->
    _enabled or= GetConVar "cfc_painsounds_enabled"
    _enabled\GetBool!

local _minDamage
minDamage = ->
    _minDamage or= GetConVar "cfc_painsounds_min_dmg"
    _minDamage\GetInt!


local _cooldown
cooldown = ->
    _cooldown or= GetConVar "cfc_painsounds_cooldown"
    _cooldown\GetFloat!

local _quiet
quiet = ->
    _quiet or= GetConVar "cfc_painsounds_quiet"
    _quiet\GetBool!


net.Receive "CFC_PainSounds_TookDamage", ->
    return unless enabled!

    victim = net.ReadEntity!
    return if (victim.lastPainSound or 0) > RealTime! - cooldown!

    dmg = net.ReadUInt 7
    return if dmg < minDamage!

    mdl = victim\GetModel!
    sounds = rawget(modelSounds, mdl) or rawget(modelCache, mdl) or guessSounds mdl
    rawset modelCache, mdl, sounds

    sound = randomSound sounds
    level = quiet! and 45 or 75
    volume = quiet! and 0.4 or 1
    pitch = random 90, 110

    victim\EmitSound sound, level, pitch, volume, channel
    victim.lastPainSound = RealTime!
