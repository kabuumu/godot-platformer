# Pixel Perfect Implementation

## Overview
This document explains the implementation of pixel-perfect rendering for the Mega Man style platformer game.

## Problem
Movement and scaling of sprites were not pixel perfect, causing:
- Blurry or jittery sprite rendering during movement
- Sprites appearing between pixel boundaries
- Loss of the crisp NES-style aesthetic

## Solution
To achieve pixel-perfect rendering, we implemented position snapping for all moving entities and enabled Godot's 2D pixel snap features.

## Implementation Details

### 1. Position Snapping in Scripts

#### Player (scripts/player.gd)
```gdscript
move_and_slide()

# Snap to pixel-perfect grid for crisp rendering
position = position.round()
```
After physics calculations and movement, the player's position is rounded to the nearest pixel coordinate.

#### Enemy (scripts/enemy.gd)
```gdscript
move_and_slide()

# Snap to pixel-perfect grid for crisp rendering
position = position.round()
```
Same approach for enemies to ensure they also render on pixel boundaries.

#### Bullet (scripts/bullet.gd)
```gdscript
position.x += direction * SPEED * delta

# Snap to pixel-perfect grid for crisp rendering
position = position.round()
```
Bullets also snap to pixel coordinates after position updates.

### 2. Camera Snapping (Already Implemented)
The camera in scripts/camera.gd was already snapping to pixels:
```gdscript
# Smoothly move camera towards target position
global_position = global_position.lerp(target_position, follow_speed * delta)

# Snap to nearest pixel for pixel-perfect rendering
global_position = global_position.round()
```

### 3. Project Settings (project.godot)

Added two critical settings under the `[rendering]` section:

```ini
[rendering]
textures/canvas_textures/default_texture_filter=0
2d/snap/snap_2d_transforms_to_pixel=true
2d/snap/snap_2d_vertices_to_pixel=true
```

- **default_texture_filter=0**: Uses nearest-neighbor filtering (no smoothing) for pixel art
- **snap_2d_transforms_to_pixel=true**: Ensures all 2D transforms are aligned to pixel boundaries
- **snap_2d_vertices_to_pixel=true**: Snaps vertices to pixel boundaries for perfect alignment

### 4. Display Configuration (Already Configured)

The viewport and window settings ensure proper scaling:
```ini
[display]
window/size/viewport_width=256
window/size/viewport_height=224
window/size/window_width_override=1024
window/size/window_height_override=896
window/stretch/mode="canvas_items"
window/stretch/aspect="keep"
```

This creates a 256x224 NES-style viewport that scales 4x to 1024x896 window size.

## How It Works

1. **Rendering Pipeline**:
   - Game logic runs at fractional positions for smooth physics
   - Before rendering, positions are rounded to nearest pixel
   - Godot's 2D snap settings ensure transforms align to pixels
   - Viewport is scaled up cleanly with nearest-neighbor filtering

2. **Benefits**:
   - Crisp, pixel-perfect sprite rendering
   - No sub-pixel blurriness
   - Authentic NES-style aesthetic
   - Smooth movement while maintaining pixel alignment

3. **Trade-offs**:
   - Very slight "pixel popping" at slow speeds (normal for pixel-perfect games)
   - This is the same behavior seen in classic NES games like Mega Man

## Testing

To verify pixel-perfect rendering:
1. Run the game in Godot or web build
2. Observe sprite edges during movement - they should remain crisp
3. Check that sprites don't appear blurry or between pixels
4. Verify the retro aesthetic is maintained

## References
- Godot 2D Pixel Snap Documentation: https://docs.godotengine.org/en/stable/classes/class_projectsettings.html#class-projectsettings-property-rendering-2d-snap-snap-2d-transforms-to-pixel
- Classic NES Resolution: 256x224 pixels
- Mega Man games used similar pixel-perfect rendering techniques
