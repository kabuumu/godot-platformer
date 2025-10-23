# Cross-Origin Isolation Fix for Godot Web Exports

## Problem

Godot 4.2+ web exports require Cross-Origin Isolation to enable SharedArrayBuffer for threading support. When deployed to GitHub Pages, you may see this error:

```
Error
The following features required to run Godot projects on the Web are missing:
Cross Origin Isolation - Check web server configuration (send correct headers)
SharedArrayBuffer - Check web server configuration (send correct headers)
```

## Solution

This repository uses a COI (Cross-Origin Isolation) Service Worker to enable the required headers on GitHub Pages, which doesn't normally allow custom HTTP headers.

### Components

1. **Custom HTML Shell** (`web_template/index.html`)
   - Modified Godot HTML template that loads the COI Service Worker
   - Includes user-friendly error messages for missing features
   - Properly handles the Godot engine initialization

2. **COI Service Worker** (`web_template/coi-serviceworker.min.js`)
   - Intercepts fetch requests and adds required headers:
     - `Cross-Origin-Embedder-Policy: credentialless` (or `require-corp`)
     - `Cross-Origin-Opener-Policy: same-origin`
     - `Cross-Origin-Resource-Policy: cross-origin`
   - Enables SharedArrayBuffer support on GitHub Pages
   - Based on the [coi-serviceworker](https://github.com/gzuidhof/coi-serviceworker) library

3. **Export Configuration** (`export_presets.cfg`)
   - Updated to use the custom HTML shell
   - Configured for Godot 4.2+ web export

4. **GitHub Actions Workflow** (`.github/workflows/build-deploy.yml`)
   - Automatically copies the COI Service Worker to the deployment directory
   - Ensures all required files are included in the GitHub Pages deployment

## How It Works

1. When a user visits the game page, the custom HTML shell loads
2. The COI Service Worker registers itself
3. On the first visit, the page reloads to activate the Service Worker
4. The Service Worker intercepts all network requests
5. Required Cross-Origin headers are added to responses
6. Godot can now use SharedArrayBuffer and threading features

## First-Time Loading

**Important:** On the first visit, users may need to refresh the page once after the Service Worker installs. This is normal behavior and only happens once per browser.

## Browser Compatibility

The solution requires:
- Modern browser with Service Worker support
- Secure context (HTTPS) - automatically provided by GitHub Pages
- SharedArrayBuffer support (all modern browsers)

## Testing Locally

To test locally with the same setup:

1. Use a local web server that serves over HTTPS, or
2. Use the COI Service Worker (it works on localhost even without HTTPS)
3. Open the game in your browser
4. Check the browser console for Service Worker registration messages

## References

- [Godot Web Export Documentation](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_web.html)
- [COI Service Worker Library](https://github.com/gzuidhof/coi-serviceworker)
- [Cross-Origin Isolation Guide](https://web.dev/coop-coep/)
