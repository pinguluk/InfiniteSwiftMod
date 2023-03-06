local stopShadowBlinkKey = Key.C -- CHANGE THE KEY HERE
local shadowBlinkSpeed = 3000 -- CHANGE THE BLINK SPEED HERE (3000 is the default value)

local shadowBlinkAbility = nil
local isShadowBlinking = false

local is_bind_registered = false
local is_shadowblink_start_hook_registered = false
local is_shadowblink_end_hook_registered = false

-- Change the speed of the ShadowBlink function
function SetShadowBlinkSpeed()
    local shadowBlinkAbilityRootMotion = StaticFindObject(
        "/Game/Pawn/Student/Abilities/Locomotion/ABL_ShadowBlink.Default__ABL_ShadowBlink_C:ablRootMotionModifiersTask_1.RootMotionModifierProperties_DodgeRoll_0")
    if shadowBlinkAbilityRootMotion:IsValid() then
        print('Setting ShadowBlink speed to ' .. shadowBlinkSpeed)
        shadowBlinkAbilityRootMotion:SetPropertyValue("BlinkSpeed", shadowBlinkSpeed)
    end
end

-- Change the offset of the ShadowBlink animation end function
function SetShadowBlinkAnimationEnd(offset)
    print('Setting ShadowBlinkAnimationEnd to ' .. offset)
    shadowBlinkAbility:SetPropertyValue("m_EndTime", {
        ["Offset"] = offset
    })
end

-- Initialise the script function
function Init()
    print('is_bind_registered: ' .. tostring(is_bind_registered))
    print('is_shadowblink_start_hook_registered: ' .. tostring(is_shadowblink_start_hook_registered))
    print('is_shadowblink_end_hook_registered: ' .. tostring(is_shadowblink_end_hook_registered))

    -- Set ShadowBlink speed to the specified one (default value is 3000)
    SetShadowBlinkSpeed()

    -- Set ShadowBlink ability to be almost infinite (default value is 10)
    SetShadowBlinkAnimationEnd(999999999)

    -- Prevent the key bind from being initialised multiple times
    if is_bind_registered == false then
        print('Registering STOP key hook')
        -- Register the STOP key bind to stop the ShadowBlink
        RegisterKeyBind(stopShadowBlinkKey, {}, function()
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
        print('Registering ShadowBlink start hook')
        -- On ShadowBlink start
        RegisterHook("/Game/Pawn/Shared/StateTree/BTT_Biped_ShadowBlink_2.BTT_Biped_ShadowBlink_2_C:ReceiveExecute",
            function()
                print('ShadowBlink started')
                isShadowBlinking = true
                -- Reset the limit back
                SetShadowBlinkAnimationEnd(999999999)
            end)
        is_shadowblink_start_hook_registered = true
    end

    -- Prevent the hook from being initialised multiple times
    if is_shadowblink_end_hook_registered == false then
        print('Registering ShadowBlink end hook')
        -- On ShadowBlink end
        RegisterHook("/Game/Pawn/Shared/StateTree/BTT_Biped_ShadowBlink_2.BTT_Biped_ShadowBlink_2_C:ExitTask",
            function()
                print('ShadowBlink ended')
                isShadowBlinking = false
                -- Reset the limit back
                SetShadowBlinkAnimationEnd(999999999)
            end)
        is_shadowblink_end_hook_registered = true
    end
end

-- This will be used to prevent the mod's script from being initialised earlier than it should
-- as the ShadowBlink start & end animations hooks are not registered correctly when launching the game
local shouldInitTheMod = false

NotifyOnNewObject("/Script/Phoenix.Loadingcreen", function(self)
    shouldInitTheMod = true
end)

-- Hook on load / reload
RegisterHook("/Script/Engine.PlayerController:ClientRestart", function(Context)
    print("Hooked on load / reload succesfully")

    -- Find the ability
    shadowBlinkAbility = StaticFindObject(
        "/Game/Pawn/Student/Abilities/Locomotion/ABL_ShadowBlink.Default__ABL_ShadowBlink_C:ablRootMotionModifiersTask_1")

    -- If the ability is valid/exists and shouldInitTheMod is true, initialise the mod's scripts
    if shadowBlinkAbility:IsValid() and shouldInitTheMod then
        shouldInitTheMod = false
        print('Initialising InfiniteSwift mod')
        Init()
        print('Finished initialising InfiniteSwift mod')
    end
end)
