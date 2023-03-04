# Description
A Hogwarts Legacy mod.  
Makes the Dodge's Swift/Roll/Dash/Teleport/ShadowBlink whatever you name it to be infinite.


https://user-images.githubusercontent.com/16257821/222929900-7cd7cca7-376e-4651-a8db-6a982f4f838d.mp4


# Requirements
This mod requires [RE-UE4SS](https://github.com/UE4SS-RE/RE-UE4SS).
1. Download the latest standard [RE-UE4SS XInput](https://github.com/UE4SS-RE/RE-UE4SS/releases) release.
3. Extract the contents of RE-UE4SS into: *\HogwartsLegacy\Phoenix\Binaries\Win64
![Screenshot_543](https://user-images.githubusercontent.com/16257821/222930894-0d43f3f8-8f16-4828-9506-1d851cc0fb34.png)

5. Move the **InfiniteSwiftMod** folder into the **Mods** folder from RE-UE4SS: *\HogwartsLegacy\Phoenix\Binaries\Win64\Mods
![Screenshot_542](https://user-images.githubusercontent.com/16257821/222930898-0c2b4761-3693-45d6-923c-3b54e9723f26.png)

(Optional) Disable any preincluded mods that you don't want, by modifying the **mods.txt** (from *\HogwartsLegacy\Phoenix\Binaries\Win64\Mods) and setting their value to 0 (some of these may cause issues like crashes or performance issues) or by removing them from the Mods folder.


Example Before
```
CheatManagerEnablerMod : 1
ActorDumperMod : 0
ConsoleCommandsMod : 1
ConsoleEnablerMod : 1
SplitScreenMod : 0
LineTraceMod : 0
```
After 
```
CheatManagerEnablerMod : 0
ActorDumperMod : 0
ConsoleCommandsMod : 0
ConsoleEnablerMod : 0
SplitScreenMod : 0
LineTraceMod : 0
```

# How to use
You need to have the SWIFT talent accuired.  
Currently I made it to work only with keyboard.  
Just hold roll to trigger the Swift ability (you don't need to hold the key afterwards) and to stop, press C.

# Change the default key and blink speed
Edit the **main.lua** from **InfiniteSwiftMod\Scripts**  
For the default stop key change the **stopShadowBlinkKey** variable  
and for the blink speed change the **shadowBlinkSpeed** variable  
![image](https://user-images.githubusercontent.com/16257821/222931515-63ebc117-02cd-478b-b322-dc8949a93383.png)  
To apply the changes without reloading the game, just press **CTRL + R** in-game and open up the map and close it, for the changes to be reapplied.

# Additional useful game objects for modding:  
**Change BlinkSpeed**  
_RootMotionModifierProperties_DodgeRoll_ /Game/Pawn/Student/Abilities/Locomotion/ABL_ShadowBlink.Default__ABL_ShadowBlink_C:ablRootMotionModifiersTask_1.RootMotionModifierProperties_DodgeRoll_0

**Change ShadowBlinkAnimation**  
_BTCustomActionDelegateBinding_ /Game/Pawn/Shared/StateTree/BTT_Biped_ShadowBlink_2.BTT_Biped_ShadowBlink_2_C:BTCustomActionDelegateBinding_0

# Known/Possible bugs:
- When traveling some distances (the chunks are recompiled or something like that), the STOP key stops working, until the data is recompiled
- The ShadowBlink animation is kinda wonky and the effects will stop being correctly aligned/oriented

**Alternative for */Game/Pawn/Student/Abilities/Locomotion/ABL_ShadowBlink.Default__ABL_ShadowBlink_C:ablRootMotionModifiersTask_1***  
_Function_ /Game/Pawn/Student/Abilities/Locomotion/ABL_DodgeRoll_ShadowBlink_Gate.ABL_DodgeRoll_ShadowBlink_Gate_C:OnAbilityStart

# Additional info
This is my first Unreal Engine mod ever.  
If you find this mod is useful, consider [to make a donation](https://paypal.me/pinguluk).
