local shadowBlinkAbility = nil
local isShadowBlinking = false

local is_bind_registered = false
local is_hook1_registered = false
local is_hook2_registered = false

-- Change the offset of the ShadowBlink animation end
function SetShadowBlinkAnimationEnd(offset)
    print('Setting ShadowBlink ending to ' .. offset)
    shadowBlinkAbility:SetPropertyValue("m_EndTime", {
        ["Offset"] = offset
    })
end

-- Initialise the script
function Init()
    -- Set ShadowBlink ability to be almost infinite (default value is 10)
    SetShadowBlinkAnimationEnd(999999)

    -- Prevent the key bind from being initialised multiple times
    if is_bind_registered == false then
        -- Bind left control key
        RegisterKeyBind(Key.C, {}, function()
            print('Pressed STOP key while ShadowBlinking? ' .. tostring(isShadowBlinking))
            if isShadowBlinking then
                print('Stopping shadow blink')
                SetShadowBlinkAnimationEnd(-1)
                return
            end
        end)
        is_bind_registered = true
    end

    -- Prevent the hook from being initialised multiple times
    if is_hook1_registered == false then
        -- On ShadowBlink start, notify
        RegisterHook("/Game/Pawn/Shared/StateTree/BTT_Biped_ShadowBlink_2.BTT_Biped_ShadowBlink_2_C:ReceiveExecute",
            function()
                print('ShadowBlink started')
                isShadowBlinking = true
            end)
        is_hook1_registered = true
    end

    -- Prevent the hook from being initialised multiple times
    if is_hook2_registered == false then
        -- On ShadowBlink start, notify
        RegisterHook("/Game/Pawn/Shared/StateTree/BTT_Biped_ShadowBlink_2.BTT_Biped_ShadowBlink_2_C:ExitTask",
            function()
                isShadowBlinking = false
                print('ShadowBlink ended')
                SetShadowBlinkAnimationEnd(999999)
            end)
        is_hook2_registered = true
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
