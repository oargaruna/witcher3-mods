# witcher3-mods

## Auto Ignite Lights

Lights candles, torches and every other light source Geralt could
light with Igni, as soon as he comes within 10 meters of it. Lights stay lit
after he walks away.

### Requirements

- The Witcher 3: Wild Hunt, next-gen / remastered edition, game version
  **4.04a or newer**. The mod uses script annotations, which older versions
  do not understand.

### Installing

1. Copy the `modAutoIgniteLights` folder into the game's `Mods` folder, so
   you end up with
   `<game folder>/Mods/modAutoIgniteLights/content/scripts/local/autoIgniteLights.ws`.
   Create the `Mods` folder if it does not exist.
2. Start the game. Scripts recompile on launch.

### Other script mods

The mod adds one new script file and does not edit any vanilla script, so
there is nothing for Script Merger to merge. If you already use Script
Merger, you can still run it; it will not list this mod.

### Behavior

- The surroundings are scanned once a second, within a 10 meter radius.
  To change either value, edit `AIL_Radius()` or `AIL_Interval()` at the top
  of `autoIgniteLights.ws`.
- Each light is lit with the same call Igni uses, so lights a quest has
  locked against Igni stay as the quest set them, and lighting them does not
  count as the player lighting them for quest objectives.
- Skipped on purpose: street lamps that follow the day/night cycle, lights
  that rain puts out while it is raining, and anything during dialogues and
  cutscenes.

### Uninstalling

Delete `Mods/modAutoIgniteLights`. Saves are not affected.
