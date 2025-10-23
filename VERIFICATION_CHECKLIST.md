# Post-Merge Verification Checklist

Use this checklist to verify that the template fixes work correctly after merging this PR.

## Step 1: Wait for Deployment

- [ ] PR has been merged to `main` branch
- [ ] GitHub Actions workflow has completed successfully
- [ ] Check workflow status at: https://github.com/kabuumu/godot-platformer/actions

## Step 2: Test the Deployed Game

### Basic Loading Test

1. [ ] Navigate to: https://kabuumu.github.io/godot-platformer/
2. [ ] Page loads without hanging
3. [ ] Loading indicator appears

### Developer Tools Verification

Open Browser Developer Tools (Press F12), then check each tab:

#### Console Tab
- [ ] No error: `$GODOT_THREADS_ENABLED is not defined` ✅
- [ ] No error: `$GODOT_BASENAME is not defined` ✅
- [ ] No other JavaScript errors
- [ ] Service Worker registration message appears (if applicable)

#### Network Tab
- [ ] Reload the page with Network tab open
- [ ] All resources show status 200 (OK)
- [ ] No 404 errors for JavaScript files ✅
- [ ] No 404 errors for favicon.ico ✅
- [ ] `icon.svg` loads successfully (if exported)
- [ ] `coi-serviceworker.min.js` loads successfully
- [ ] Main game JavaScript file loads (e.g., `index.js`)
- [ ] Game data files load (`.pck` or `.wasm` files)

#### Application Tab (Chrome) / Storage Tab (Firefox)
- [ ] Navigate to Service Workers section
- [ ] COI Service Worker is registered and active
- [ ] Status shows "activated"

### Functionality Test

- [ ] Game loading progress bar appears
- [ ] Game fully loads and displays
- [ ] Game is playable (can move character, jump, etc.)
- [ ] No performance issues or crashes

## Step 3: Verify Source Code

View the deployed HTML source:

1. [ ] Right-click on the page and select "View Page Source"
2. [ ] Check that template variables were replaced:
   - [ ] `$GODOT_URL` is replaced with actual JavaScript file path (e.g., `index.js`)
   - [ ] `$GODOT_CONFIG` is replaced with a JavaScript object `{...}`
   - [ ] No `$GODOT_BASENAME` appears in source ✅
   - [ ] No `$GODOT_THREADS_ENABLED` appears in source ✅
3. [ ] Favicon link is present: `<link rel="icon" type="image/svg+xml" href="icon.svg">`

## Step 4: Cross-Browser Testing (Optional)

Test in multiple browsers to ensure compatibility:

- [ ] Chrome/Chromium (latest version)
- [ ] Firefox (latest version)
- [ ] Safari (latest version, if available)
- [ ] Edge (latest version)

## Expected Results

If all checkboxes above are marked, the fix is successful! You should see:

✅ **No JavaScript errors** in console  
✅ **No 404 errors** in network tab  
✅ **Game loads and runs** properly  
✅ **Service Worker activates** correctly  
✅ **Template variables** are properly replaced  

## If Issues Occur

If any checks fail:

1. **Check GitHub Actions logs**: Look for build errors in the workflow
2. **Verify export settings**: Ensure `export_presets.cfg` points to the custom template
3. **Check Service Worker**: It may take a refresh on first visit
4. **Clear browser cache**: Hard refresh with Ctrl+Shift+R (Cmd+Shift+R on Mac)
5. **Report issue**: If problems persist, create a new issue with:
   - Browser name and version
   - Console error messages
   - Network tab screenshot
   - Steps to reproduce

## Rollback Procedure

If critical issues are found:

1. Revert this PR in GitHub
2. GitHub Actions will automatically redeploy the previous version
3. Create a new issue to investigate the problem

---

**Note**: The first time the page loads after deployment, the Service Worker needs to install. This may require one page refresh. This is expected behavior and mentioned in the error messages.
