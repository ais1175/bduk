## Key
```diff
- Removed
! Modified
+ Added
# Notes
```

## v0.2.0
```diff
- main.lua: Split into new files and put into scripts/ folder.
- scripts/builder.lua: removed ui_active flag isnt used anymore.
+ scripts/dui_sprite.lua: New script to handle DUI locations for the new dui element.
+ components/dui_sprite.js: New element to create DUI's in the game world refer to discord for previews docs coming asap.
+ css/dui_sprite.css: Style for dui, uses same default root theme palette.
! builder.js: Added close() function and moved remove nui post out of destroy() into close.
! builder.lua: Changed nui focus to fixed values instead of relying on IsNuiFocused() native.
# and some other stuff i forgot.. hence for the full replace.
```

## v0.1.4
```diff
! buttons/footer/tooltip.js: Unified `on_click` and `on_keypress` to one handle now use `on_action` instead for both.
! buttons.js: Modified global btn handler now returns the merged dataset from modals on click.
! tooltip.js: Fixed to call correct action, was calling old method.
! builder.js: Now removes modals properly when destroy() is called, stops modals from getting stuck on screen.
! test.lua: Removed action = "close_modal" from example code, isnt needed anymore any modal button without an action or on_action section will close modal.
! modal.js: Modified get_input_html() now merges additional dataset if provided.
! modal.css: Select options are now hidden by default as they should have been.
! buttons.css: Changed btn class to align items correctly if including icons.
! themes/default.css: Added slight opacity to default bg colours, makes the UI a little less dominant.
```

## v0.1.3
```diff
- Removed duplicated readme from github causing errors
```

## v0.1.2
```diff
! init.lua: Changed use of BDUL to BDTK on debug carry over functions.
! init.lua: call_registered_function now actually passes ui data through.
! main.lua: nui:handler now passes ui data through for call function.
! builder.js: destroy() now hides tooltip before destroying ui, stops the tooltip getting stuck on screen.
```

## v0.1.1

```diff
! footer.js: Modified keydowns for footers to no longer be clickable and to send correct data.
- footer.js: Removed two dead methods and updated to new methods used throughout.
- fxmanifest: Removed server_script import for oxmysql script doesnt cover any server side interaction internally anymore.
- modal.js: Removed some deprecated params.
```