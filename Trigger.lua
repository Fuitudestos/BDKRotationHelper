function(event, _, message, _, sourceGUID, _, _, _, destGUID, _, _, _, spellID, spellName, _, failedType)
    local soundPath = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\BikeHorn.ogg"
    local boneShieldID = 195181
    local marrowendID = 195182
    local deathStrikeID = 49998
    local DRW_buff_ID = 81256
    local DRW_spell_ID = 49028
    local DCaressID = 195292
    local DeathCoilID = 47541
    local threshold = 7
    local currentTime = GetTime()
    
    if currentTime - aura_env.timeLastMistake > 6 then
        aura_env.lastMistake = 0
    end
    
    if InCombatLockdown() then
        if event == "COMBAT_LOG_EVENT_UNFILTERED" then
            if message == "SPELL_AURA_REMOVED_DOSE"
            and spellID == boneShieldID
            then
                aura_env.nbStack = select(3, WA_GetUnitBuff("player", boneShieldID)) or 0
            end
            
            if message == "SPELL_AURA_REMOVED"
            and spellID == boneShieldID
            then
                aura_env.nbStack = 0
                aura_env.lastMistake = 2
                aura_env.timeLastMistake = currentTime
                PlaySoundFile(soundPath,"SFX");
            end
            
            if message == "SPELL_CAST_SUCCESS"
            and sourceGUID == WeakAuras.myGUID
            then
                if spellID == DeathCoilID then
                    aura_env.lastMistake = 4
                    aura_env.timeLastMistake = currentTime
                    PlaySoundFile(soundPath, "SFX");
                end
                if spellID == marrowendID then
                    if aura_env.nbStack > threshold then
                        if currentTime - aura_env.startTime < 24 then
                            aura_env.lastMistake = 3
                            aura_env.timeLastMistake = currentTime
                            PlaySoundFile(soundPath, "SFX");
                        end
                    end
                    aura_env.nbStack = select(3, WA_GetUnitBuff("player", boneShieldID))
                    aura_env.startTime = currentTime
                end
                if spellID == DCaressID then
                    if aura_env.nbStack > 8 then
                        if currentTime - aura_env.startTime < 24 then
                            aura_env.lastMistake = 3
                            aura_env.timeLastMistake = currentTime
                            PlaySoundFile(soundPath, "SFX");
                        end
                    end
                    aura_env.nbStack = select(3, WA_GetUnitBuff("player", boneShieldID))
                    aura_env.startTime = currentTime
                end
                if spellID == deathStrikeID then
                    aura_env.nbStack = select(3, WA_GetUnitBuff("player", boneShieldID))
                    if aura_env.nbStack == nil or aura_env.nbStack < 5 then
                        aura_env.lastMistake = 1
                        aura_env.timeLastMistake = currentTime
                        PlaySoundFile(soundPath,"SFX");
                    end
                end
            end
        end
    end
    return true
end
