-- Author: pinguluk
-- Mod Nexus Page: https://www.nexusmods.com/hogwartslegacy/mods/913 
-- Mod GitHub Repo: https://github.com/pinguluk/InfiniteSwiftMod
-- Version 1.1.0
-- Note: please mention me if you use this code in your mod, thanks :)
local shadowBlinkSpeed = 3000 -- CHANGE THE BLINK SPEED HERE (3000 is the default value)

local shadowBlinkAbility = nil
local shadowBlinkAbilityRootMotion = nil

local VERY_BIG_NUMBER = 999999999999999

-- Change the speed of the ShadowBlink function
function SetShadowBlinkSpeed()
    print('Setting ShadowBlink BlinkSpeed to ' .. shadowBlinkSpeed)
    shadowBlinkAbilityRootMotion:SetPropertyValue("BlinkSpeed", shadowBlinkSpeed)

    print('Setting ShadowBlink TurnToFaceInterpTime to ' .. VERY_BIG_NUMBER)
    -- Set the TurnToFaceInterpTime to a very high number to make sure the character (animation) direction doesn't change and keep the normal direction (default is 0.5)
    shadowBlinkAbilityRootMotion:SetPropertyValue("TurnToFaceInterpTime", VERY_BIG_NUMBER)
end

-- Change the offset of the ShadowBlink animation end function (default is 10)
function SetShadowBlinkAnimationEnd(offset)
    print('Setting ShadowBlinkAnimationEnd to ' .. offset)
    shadowBlinkAbility:SetPropertyValue("m_EndTime", {
        ["Offset"] = offset
    })
end

-- Register the hooks to detect the input press + release for Dodge (ShadowBlink)
function SetShadowBlinkInputHooks()
    print('Registering ShadowBlink input hooks')
    -- Detect DodgeAndBlink input down
    RegisterHook(
        "/Game/Pawn/Shared/StateTree/BTS_Biped_TopLevel.BTS_Biped_TopLevel_C:InpActEvt_DodgeAndBlinkButton_K2Node_CustomInputActionEvent_26",
        function()
            print('DodgeAndBlink input down')
            -- Set the ShadowBlink animation end to a very high number to make sure it doesn't stop the animation
            SetShadowBlinkAnimationEnd(VERY_BIG_NUMBER)
        end)

    -- Detect DodgeAndBlink input down
    RegisterHook(
        "/Game/Pawn/Shared/StateTree/BTS_Biped_TopLevel.BTS_Biped_TopLevel_C:InpActEvt_DodgeAndBlinkButton_K2Node_CustomInputActionEvent_25",
        function()
            print('DodgeAndBlink input up')
            -- Set the ShadowBlink animation end to a very low value to make sure it stops the animation
            SetShadowBlinkAnimationEnd(-1)
        end)
end

-- Whenever the character is loaded, find the ShadowBlink ability & root motion and set the blink speed and register the hooks to detect the input press + release for Dodge (ShadowBlink)
RegisterHook("/Script/Phoenix.Biped_Player:OnCharacterLoadComplete", function(self)
    print("(Re)initalising InfiniteSwift Mod...")

    shadowBlinkAbility = StaticFindObject(
        "/Game/Pawn/Student/Abilities/Locomotion/ABL_ShadowBlink.Default__ABL_ShadowBlink_C:ablRootMotionModifiersTask_1")

    shadowBlinkAbilityRootMotion = StaticFindObject(
        "/Game/Pawn/Student/Abilities/Locomotion/ABL_ShadowBlink.Default__ABL_ShadowBlink_C:ablRootMotionModifiersTask_1.RootMotionModifierProperties_DodgeRoll_0")

    SetShadowBlinkSpeed()
    SetShadowBlinkInputHooks()

    print("InfiniteSwift Mod has been (re)initialised")
end)
