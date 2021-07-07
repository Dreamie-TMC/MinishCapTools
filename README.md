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

## Current Tools
#### Input Viewer
- Straylite's input viewer for BizHawk, modified for compatability
- All credits for input viewer designs and code go to Straylite

#### Textbox Mash Trainer
- Shows what percentage of text drawing frames you were holding "B" for
- Shows what percentage of text boxes you closed frame perfectly or not
- Shows the total amount of frames lost to perfect textboxes
- Shows the average amount of frames lost per textbox

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

#### Shared
- E loads the hotkey edit menu, allowing you to edit hotkeys from within the UI. Rebinding this is highly recommended.
- M loads movie mode allowing inputs to be displayed for recordings and shows how well the movie mashes textboxes
- C changes the background of the extension from black to blue or vice-versa

## Future Plans
#### Loading/Editing Keybinds from a configuration file (Done)
#### Disabling certain features from running through keybinds to improve performance (Done)
#### Editing Keybinds directly in the UI (Done)
#### Total Lost Frames doing actions (pulling, shrinking) (Not Started)
#### Frames between rolls counter, also counting the number of frame perfect rolls (Not Started)
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

#### Bug Fixes
- Fixed an issue where the input display would be extremely desynced from the mouse due to the extra window padding
