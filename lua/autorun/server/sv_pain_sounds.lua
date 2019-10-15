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
        "npc_alyx.hurt04",
        "npc_alyx.hurt05",
        "npc_alyx.hurt06",
        "npc_alyx.hurt08"
    },
    ["models/player/monk.mdl"] = {
        "ravenholm.monk_pain01",
        "ravenholm.monk_pain02",
        "ravenholm.monk_pain03",
        "ravenholm.monk_pain04",
        "ravenholm.monk_pain05",
        "ravenholm.monk_pain06",
        "ravenholm.monk_pain07",
        "ravenholm.monk_pain08",
        "ravenholm.monk_pain09",
        "ravenholm.monk_pain10",
        "ravenholm.monk_pain12"
    },
    ["models/player/barney.mdl"] = {
        "npc_barney.ba_pain01",
        "npc_barney.ba_pain02",
        "npc_barney.ba_pain03",
        "npc_barney.ba_pain04",
        "npc_barney.ba_pain05",
        "npc_barney.ba_pain06",
        "npc_barney.ba_pain07",
        "npc_barney.ba_pain08",
        "npc_barney.ba_pain09",
        "npc_barney.ba_pain10"
    },
    ["models/player/eli.mdl"] = {
        "ep_02.eli_launch_pain04",
        "ep_02.eli_launch_pain05",
        "ep_02.eli_launch_pain06",
        "ep_02.eli_launch_pain09",
        "ep_02.eli_launch_pain139"
    },

    --Combine
    ["models/player/police.mdl"] = {
        "NPC_MetroPolice.Pain"
    },
    ["models/player/police_fem.mdl"] = {
        "NPC_MetroPolice.Pain"
    },
    ["models/player/combine_soldier.mdl"] = {
        "NPC_MetroPolice.Pain"
    },
    ["models/player/combine_soldier_prisonguard.mdl"] = {
        "NPC_MetroPolice.Pain"
    },
    ["models/player/combine_super_soldier.mdl"] = {
        "NPC_MetroPolice.Pain"
    }
}

local function genderOfPlayerModel( mdl )
    if string.find( mdl, "/female_" ) then return "F" end
    if string.find( mdl, "/male_" ) then return "M" end
end

hook.Remove( "EntityTakeDamage", "custom_sounds" )
hook.Add( "EntityTakeDamage", "custom_sounds", function( vic, dmginfo )
    if not IsValid( vic ) then return end
    if not vic:IsPlayer() then return end

    local mdl = vic:GetModel()
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
        --local duration = SoundDuration( randSound ) TODO: Convert all sounds to their .wav counterpart
        vic:EmitSound( randSound )
    end
end )
