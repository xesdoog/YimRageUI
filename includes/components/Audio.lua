---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- File created at [24/05/2021 00:00]
---
--- Ported To YimMenu-Lua by SAMURAI (xesdoog)
--- File Modified: [02/01/2024 17:44]
--- 

Audio = {}

---PlaySound
---
--- Reference : N/A
---
---@param Library string
---@param Sound string
---@param IsLooped? boolean
---@return nil
---@public
function Audio.PlaySound(Library, Sound, IsLooped)
    local soundID
    script.run_in_fiber(function(ps)
        if not IsLooped then
            AUDIO.PLAY_SOUND_FRONTEND(-1, Sound, Library, true)
        else
            if not soundID then
                soundID = AUDIO.GET_SOUND_ID()
                AUDIO.PLAY_SOUND_FRONTEND(soundID, Sound, Library, true)
                ps:sleep(1)
                AUDIO.STOP_SOUND(soundID)
                AUDIO.RELEASE_SOUND_ID(soundID)
                soundID = nil
            end
        end
    end)
end


