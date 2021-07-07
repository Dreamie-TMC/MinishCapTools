# MinishCapTools
A series of tools for Minish Cap Speedruns and Practice

## Developers
#### Straylite
- Created the input viewer

#### Dreamie
- Everything else

## Contributors
#### Myth
- Testing, ideas, helping with some of the science behind the tools

#### LeonarthCG, WJG999, PPLToast
- Documented memory addresses and flags for TMC which allows these tools to be possible

#### Testers
- NyanCato
- Aridner
- I'm looking for 1 or 2 more guinea pigs. If anyone wants their name here as a tester please reach out to me from the Minish Cap Discord!

## Current Tools
#### Input Viewer
- Straylite's input viewer for BizHawk, modified for compatability
- All credits for input viewer designs and code go to Straylite

#### Textbox Mash Trainer
- Shows what percentage of text drawing frames you were holding "B" for
- Shows what percentage of text boxes you closed frame perfectly or not
- Shows the total amount of frames lost to perfect textboxes
- Shows the average amount of frames lost per textbox

#### Hotkey Editor
- Allows editing hotkeys for the above tools within the UI
- Allows quick saving of the hotkeys by clicking the save button

## How To Use
#### Input Viewer
- K resets the input viewer to its default position (bottom left corner)
- U unlocks the input viewer allowing you to move it anywhere on screen
- B adds a bold line around the inputs to make them pop
- V uses a custom color (set in colors.txt) for the button presses instead of the defaults
- I hides the input viewer from the display

#### Textbox Mash Trainer
- T hides the output from the trainer
- R resets the counters for the trainer

#### Hotkey Editor
- E loads the hotkey edit menu, allowing you to edit hotkeys from within the UI. Rebinding this is highly recommended. This disables all hotkeys not related to the editor in order to avoid any conflicts.
- Pressing enter with the menu open will prompt for a key press. The next key press will be registered as the assigned hotkey for that action.
- Pressing the right arrow will go to the next hotkey in the list, pressing the left arrow will go back one hotkey.
- Clicking save will save the hotkeys and close the editing UI. This will also re-enable other hotkeys.
- Clicking cancel will discard any changes made to the hotkeys and close the editing UI. It will reload the existing hotkeys and use those instead. This will also re-enable other hotkeys.

#### Shared
- O puts the script into "Speedrun Mode" which locks you out of certain hotkeys. Currently it filters out opening the hotkey edit menu.
- M loads movie mode allowing inputs to be displayed for recordings and shows how well the movie mashes textboxes
- C changes the background of the extension from black to blue or vice-versa

## Future Plans
#### Loading/Editing Keybinds from a configuration file (Done)
#### Disabling certain features from running through keybinds to improve performance (Done)
#### Editing Keybinds directly in the UI (Done)
#### Total Lost Frames doing actions (pulling, shrinking) (Not Started)
#### Frames between rolls counter, also counting the number of frame perfect rolls (Starting)
#### Useful Practice Tools such as Boss HP (Not Started)
#### Integration of Straylite's Pseudo Practice Rom LUA (Maybe?)

## Other Scripts
#### TAS tools
- Auto Masher (Done)
- Auto Roll/Shrink/Grow/Pull (Done)
- Auto Close Maps (Not Started)
- Auto Swim (Not Started)
- Auto Firerod (Not Started)

## Changelog
### Version 1.1
#### Features
- Hotkeys are now stored in "config/Hotkeys.json" and are loaded at launch
- Layout configuration is now saved so when you reload the script it starts off as you left it
- Configuration data is found at "config/Config.json"
- Input display and textbox trainers can be turned off
- Added a counter for "Average Frames Lost Per Textbox"
- Textbox trainer now accounts for textboxes where you need to select an option
- The position of the input display now saves automatically when edited
- The position of the input display can be reset to its default position
- Hotkeys are now editable from the main UI
- Added "Speedrun Mode" which is used to disable certain features. Currently the only feature disabled by this mode is hotkey editing but more will come in the future

#### Bug Fixes
- Fixed an issue where the input display would be extremely desynced from the mouse due to the extra window padding
