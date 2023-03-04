local shadowBlinkAbility = nil
local isShadowBlinking = false

local is_bind_registered = false
local is_shadowblink_start_hook_registered = false
local is_shadowblink_end_hook_registered = false

-- Change the offset of the ShadowBlink animation end
function SetShadowBlinkAnimationEnd(offset)
    print('Setting ShadowBlink ending to ' .. offset)
    shadowBlinkAbility:SetPropertyValue("m_EndTime", {
        ["Offset"] = offset
    })
end

-- Initialise the script
function Init()
    print('is_bind_registered: ' .. tostring(is_bind_registered))
    print('is_shadowblink_start_hook_registered: ' .. tostring(is_shadowblink_start_hook_registered))
    print('is_shadowblink_end_hook_registered: ' .. tostring(is_shadowblink_end_hook_registered))

    -- Set ShadowBlink ability to be almost infinite (default value is 10)
    SetShadowBlinkAnimationEnd(999999999)

    -- Prevent the key bind from being initialised multiple times
    if is_bind_registered == false then
        -- Bind left control key
        RegisterKeyBind(Key.C, {}, function()
            print('Pressed STOP key while ShadowBlinking? ' .. tostring(isShadowBlinking))
            print('Stopping shadow blink')
            -- Workaround to stop the animation immediately 
            SetShadowBlinkAnimationEnd(-1)
            return
        end)
        is_bind_registered = true
    end

    -- Prevent the hook from being initialised multiple times
    if is_shadowblink_start_hook_registered == false then
        -- On ShadowBlink start
        RegisterHook("/Game/Pawn/Shared/StateTree/BTT_Biped_ShadowBlink_2.BTT_Biped_ShadowBlink_2_C:ReceiveExecute",
            function()
                print('ShadowBlink started')
                SetShadowBlinkAnimationEnd(999999)
                isShadowBlinking = true
            end)
        is_shadowblink_start_hook_registered = true
    end

    -- Prevent the hook from being initialised multiple times
    if is_shadowblink_end_hook_registered == false then
        -- On ShadowBlink end
        RegisterHook("/Game/Pawn/Shared/StateTree/BTT_Biped_ShadowBlink_2.BTT_Biped_ShadowBlink_2_C:ExitTask",
            function()
                isShadowBlinking = false
                print('ShadowBlink ended')
                SetShadowBlinkAnimationEnd(999999)
            end)
        is_shadowblink_end_hook_registered = true
    end
end

-- Hook on load / reload
RegisterHook("/Script/Engine.PlayerController:ClientRestart", function(Context)
    print("Hooked on load / reload succesfully")

    -- Find the ability
    shadowBlinkAbility = StaticFindObject(
        "/Game/Pawn/Student/Abilities/Locomotion/ABL_ShadowBlink.Default__ABL_ShadowBlink_C:ablRootMotionModifiersTask_1")

    -- If the ability is found, initialise the script
    if shadowBlinkAbility:IsValid() then
        print('Initialising')
        Init()
        print('Finished initialising')
    end
end)
