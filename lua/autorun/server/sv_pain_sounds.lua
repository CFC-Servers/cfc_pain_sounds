local combineSounds = {
    "npc/metropolice/pain1.wav",
    "npc/metropolice/pain2.wav",
    "npc/metropolice/pain3.wav",
    "npc/metropolice/pain4.wav"
}

local HurtSounds = {
    ["cit_male"] = {
        "vo/episode_1/npc/male01/cit_pain01.wav",
        "vo/episode_1/npc/male01/cit_pain02.wav",
        "vo/episode_1/npc/male01/cit_pain03.wav",
        "vo/episode_1/npc/male01/cit_pain04.wav",
        "vo/episode_1/npc/male01/cit_pain05.wav",
        "vo/episode_1/npc/male01/cit_pain06.wav",
        "vo/episode_1/npc/male01/cit_pain07.wav",
        "vo/episode_1/npc/male01/cit_pain08.wav",
        "vo/episode_1/npc/male01/cit_pain09.wav",
        "vo/episode_1/npc/male01/cit_pain10.wav",
        "vo/episode_1/npc/male01/cit_pain11.wav",
        "vo/episode_1/npc/male01/cit_pain12.wav",
        "vo/episode_1/npc/male01/cit_pain13.wav"
    },
    ["cit_female"] = {
        "vo/episode_1/npc/female01/cit_pain01.wav",
        "vo/episode_1/npc/female01/cit_pain02.wav",
        "vo/episode_1/npc/female01/cit_pain03.wav",
        "vo/episode_1/npc/female01/cit_pain04.wav",
        "vo/episode_1/npc/female01/cit_pain05.wav",
        "vo/episode_1/npc/female01/cit_pain06.wav",
        "vo/episode_1/npc/female01/cit_pain07.wav",
        "vo/episode_1/npc/female01/cit_pain08.wav",
        "vo/episode_1/npc/female01/cit_pain09.wav",
        "vo/episode_1/npc/female01/cit_pain10.wav"
    },
    ["models/player/alyx.mdl"] = {
        "*vo/npc/Alyx/hurt04.wav",
        "*vo/npc/Alyx/hurt05.wav",
        "*vo/npc/Alyx/hurt06.wav",
        "*vo/npc/Alyx/hurt08.wav"
    },
    ["models/player/monk.mdl"] = {
        "*vo/ravenholm/monk_pain01.wav",
        "*vo/ravenholm/monk_pain02.wav",
        "*vo/ravenholm/monk_pain03.wav",
        "*vo/ravenholm/monk_pain04.wav",
        "*vo/ravenholm/monk_pain05.wav",
        "*vo/ravenholm/monk_pain06.wav",
        "*vo/ravenholm/monk_pain07.wav",
        "*vo/ravenholm/monk_pain08.wav",
        "*vo/ravenholm/monk_pain09.wav",
        "*vo/ravenholm/monk_pain10.wav",
        "*vo/ravenholm/monk_pain11.wav",
        "*vo/ravenholm/monk_pain12.wav"
    },
    ["models/player/barney.mdl"] = {
        "*vo/npc/Barney/ba_pain01.wav",
        "*vo/npc/Barney/ba_pain02.wav",
        "*vo/npc/Barney/ba_pain03.wav",
        "*vo/npc/Barney/ba_pain04.wav",
        "*vo/npc/Barney/ba_pain05.wav",
        "*vo/npc/Barney/ba_pain06.wav",
        "*vo/npc/Barney/ba_pain07.wav",
        "*vo/npc/Barney/ba_pain08.wav",
        "*vo/npc/Barney/ba_pain09.wav",
        "*vo/npc/Barney/ba_pain10.wav"
    },
    ["models/player/eli.mdl"] = {
        "*vo/outland_12a/launch/eli_launch_pain01.wav",
        "*vo/outland_12a/launch/eli_launch_pain04.wav",
        "*vo/outland_12a/launch/eli_launch_pain05.wav",
        "*vo/outland_12a/launch/eli_launch_pain06.wav",
        "*vo/outland_12a/launch/eli_launch_pain09.wav",
        "*vo/outland_12a/launch/eli_launch_pain13.wav"
    },

    --Combine
    ["models/player/police.mdl"] = combineSounds,
    ["models/player/police_fem.mdl"] = combineSounds,
    ["models/player/combine_soldier.mdl"] = combineSounds,
    ["models/player/combine_soldier_prisonguard.mdl"] = combineSounds,
    ["models/player/combine_super_soldier.mdl"] = combineSounds
}

local function genderOfPlayerModel( mdl )
    if string.find( mdl, "/female_" ) then return "F" end
    if string.find( mdl, "/male_" ) then return "M" end
end

hook.Remove( "EntityTakeDamage", "custom_sounds" )
hook.Add( "EntityTakeDamage", "custom_sounds", function( victim, dmginfo )
    if not IsValid( victim ) then return end
    if not victim:IsPlayer() then return end

    local mdl = victim:GetModel()
    local soundTable = HurtSounds[ mdl ]

    if soundTable == nil then
        local sex = genderOfPlayerModel( mdl )

        if sex == "F" then
            soundTable = HurtSounds[ "cit_female" ]
        elseif sex == "M" then
            soundTable = HurtSounds[ "cit_male" ]
        else
            return
        end
    end

    if dmginfo:GetDamage() > 10 then
        local randSound = soundTable[ math.random( 1, table.Count( soundTable ) ) ]
        --local duration = SoundDuration( randSound )
        victim:EmitSound( randSound )
    end
end )
