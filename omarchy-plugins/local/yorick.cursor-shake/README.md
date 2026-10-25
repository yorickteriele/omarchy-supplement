# Cursor Shake

Enlarges the cursor when you shake the mouse, like macOS's shake-to-locate.

`bin/cursor-shake` polls `hyprctl cursorpos` and tracks a "shake energy":
every direction reversal and every bit of raw speed adds to it, and it
decays every tick. Cursor size continuously tracks that energy (in a few
discrete steps, via `hyprctl setcursor`) — so it grows the more you shake
and shrinks itself back the instant you stop, instead of snapping between
two fixed sizes on a threshold.

Tune it without editing the script by dropping overrides in
`~/.config/omarchy/cursor-shake.conf`, e.g.:

```
GROW_FACTOR=4
REVERSAL_GAIN=80
```

See the top of `bin/cursor-shake` for every tunable — `REVERSAL_GAIN` and
`DECAY` are the ones worth touching first: raise `REVERSAL_GAIN` (or lower
`DECAY`, i.e. slower decay) if small wiggles aren't growing the cursor
enough; lower `REVERSAL_GAIN` if it's too eager.
