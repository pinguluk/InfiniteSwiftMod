# Description
A Hogwarts Legacy mod.
Makes the Dodge's Swift/Roll/Dash/Teleport/ShadowBlink whatever you name it to be *almost* infinite

# Requirements
You need to have the SWIFT talent accuired.
Currently I made it to work only with keyboard.

# How to use (WIP)
Just hold roll to trigger the Swift ability (you don't need to hold the key afterwards) and to stop, press C.

# Additional useful game objects:
**Change BlinkSpeed**  
RootMotionModifierProperties_DodgeRoll /Game/Pawn/Student/Abilities/Locomotion/ABL_ShadowBlink.Default__ABL_ShadowBlink_C:ablRootMotionModifiersTask_1.RootMotionModifierProperties_DodgeRoll_0

**Change ShadowBlinkAnimation**  
BTCustomActionDelegateBinding /Game/Pawn/Shared/StateTree/BTT_Biped_ShadowBlink_2.BTT_Biped_ShadowBlink_2_C:BTCustomActionDelegateBinding_0

**Alternative for */Game/Pawn/Student/Abilities/Locomotion/ABL_ShadowBlink.Default__ABL_ShadowBlink_C:ablRootMotionModifiersTask_1***
Function /Game/Pawn/Student/Abilities/Locomotion/ABL_DodgeRoll_ShadowBlink_Gate.ABL_DodgeRoll_ShadowBlink_Gate_C:OnAbilityStart

# Additional info
This is my first Unreal Engine mod ever.  
If you find this mod is useful, consider [to make a donation](https://paypal.me/pinguluk).
