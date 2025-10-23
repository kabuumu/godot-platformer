# Template Variable Fixes for Godot Web Export

## Issues Fixed

This document describes the fixes applied to resolve the following errors that occurred when loading the game on GitHub Pages:

1. **404 Error**: Failed to load resource: the server responded with a status of 404 (Not Found)
2. **JavaScript Error**: `Uncaught ReferenceError: $GODOT_THREADS_ENABLED is not defined`
3. **Favicon 404**: Failed to load favicon.ico

## Changes Made

### 1. Fixed Godot Template Variables in `web_template/index.html`

#### Changed `$GODOT_BASENAME` to `$GODOT_URL`
- **Line 141**: Changed `<script src="$GODOT_BASENAME.js"></script>` to `<script src="$GODOT_URL"></script>`
- **Reason**: `$GODOT_BASENAME` is not a valid Godot 4.2 template variable. The correct variable is `$GODOT_URL`, which includes the full path to the JavaScript file.

#### Removed Invalid `$GODOT_THREADS_ENABLED` Variable
- **Line 143**: Removed `const GODOT_THREADS_ENABLED = $GODOT_THREADS_ENABLED;`
- **Reason**: `$GODOT_THREADS_ENABLED` is not a valid Godot template variable and was causing a JavaScript error.

#### Updated Thread Detection Logic
- **Line 195**: Changed `if (GODOT_THREADS_ENABLED && missing.indexOf('SharedArrayBuffer') !== -1)` to `if (missing.indexOf('SharedArrayBuffer') !== -1)`
- **Reason**: Removed dependency on the non-existent `$GODOT_THREADS_ENABLED` variable. The check now directly tests if SharedArrayBuffer is in the missing features list.

#### Removed Unused Variable Reference
- **Line 190**: Removed `initializing = false;` from `displayFailureNotice` function
- **Reason**: The `initializing` variable was referenced but never declared. Since the custom template's `setStatusMode` doesn't check this variable, it's safe to remove.

### 2. Added Favicon Reference

- **Line 14**: Added `<link rel="icon" type="image/svg+xml" href="icon.svg">`
- **Reason**: Prevents the browser from requesting `favicon.ico`, which doesn't exist, causing a 404 error.
- **Note**: Godot already exports the icon.svg file when `html/export_icon=true` is set in export_presets.cfg.

## Valid Godot 4.2 Template Variables

The template now only uses valid Godot 4.2 template variables:

- `$GODOT_URL` - Full path to the main JavaScript file
- `$GODOT_CONFIG` - Configuration object for the Godot engine
- `$GODOT_HEAD_INCLUDE` - Optional custom HTML to include in the head (not used in this template)
- `$GODOT_PROJECT_NAME` - Project name (not used in this template)

## Testing

### How to Verify the Fix

1. **Build the game**: The GitHub Actions workflow will use the updated template to build the web export
2. **Check the generated HTML**: After deployment, inspect the generated `index.html` on GitHub Pages
3. **Verify variables are replaced**: 
   - `$GODOT_URL` should be replaced with the actual JavaScript file path (e.g., `index.js`)
   - `$GODOT_CONFIG` should be replaced with a JavaScript object
4. **Test in browser**:
   - Navigate to the GitHub Pages URL
   - Open browser developer tools (F12)
   - Check the Console tab - there should be no JavaScript errors
   - Check the Network tab - all resources should load successfully (no 404 errors)

### Expected Behavior

- ✅ Game loads without JavaScript errors
- ✅ No 404 errors for missing resources
- ✅ Service Worker installs correctly
- ✅ SharedArrayBuffer support is detected properly
- ✅ Favicon loads correctly

## References

- [Godot Web Export Documentation](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_web.html)
- [Godot 4.2 Default HTML Template](https://github.com/godotengine/godot/blob/4.2.2-stable/misc/dist/html/full-size.html)
- [COI Service Worker for GitHub Pages](https://github.com/gzuidhof/coi-serviceworker)
