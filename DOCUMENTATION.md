# Project Documentation

## Overview
This is a NES-style platformer game inspired by Mega Man, built with Godot Engine 4.2. The game features classic platforming mechanics including jumping, wall sliding, and shooting projectiles.

## Game Features

### Player Mechanics
- **Movement**: WASD or Arrow Keys for 8-directional movement
- **Jumping**: Space or W key with precise jump control
- **Wall Sliding**: Automatic when touching walls while falling
- **Wall Jumping**: Jump while wall sliding to propel in the opposite direction
- **Shooting**: X or Enter key to fire energy projectiles
- **Shoot Cooldown**: 0.3 seconds between shots to prevent spam

### Enemy AI
- Simple patrol behavior with edge and wall detection
- Takes damage from player projectiles
- Dies after taking 3 hits
- Automatically turns around at platform edges and walls

### Level Design
- NES-style 256x224 resolution (scaled 4x for modern displays)
- Pixel-perfect rendering for authentic retro feel
- Platform-based level design
- Multiple elevation levels for vertical gameplay

### Visual Style
- 16x16 pixel sprites and tiles
- NES-inspired color palette
- Retro aesthetic with modern Godot rendering

## Technical Architecture

### Project Structure
```
godot-platformer/
├── assets/
│   ├── sprites/          # Character and entity sprites
│   │   ├── player.svg
│   │   ├── enemy.svg
│   │   └── bullet.svg
│   └── tiles/            # Level tileset
│       └── platform.svg
├── scenes/               # Godot scene files
│   ├── main.tscn        # Main game level
│   ├── player.tscn      # Player character
│   ├── enemy.tscn       # Enemy entity
│   └── bullet.tscn      # Projectile
├── scripts/              # GDScript game logic
│   ├── player.gd        # Player controller
│   ├── enemy.gd         # Enemy AI
│   ├── bullet.gd        # Projectile behavior
│   └── hud.gd           # UI controller
└── ui/                   # User interface
    └── hud.tscn         # Heads-up display
```

### Key Systems

#### Physics Layers
1. Layer 1: Player
2. Layer 2: Enemies
3. Layer 3: World (platforms, walls)
4. Layer 4: Projectiles

#### Input Mapping
- `move_left`: A, Left Arrow
- `move_right`: D, Right Arrow
- `jump`: W, Space
- `shoot`: X, Enter

#### Game Constants
- Player speed: 100 units/second
- Jump velocity: -300 units/second
- Gravity: 800 units/second²
- Wall slide speed: 50 units/second
- Bullet speed: 200 units/second

## Web Deployment

### Continuous Deployment
The game uses GitHub Actions to automatically build and deploy to GitHub Pages:

1. **On Push to Main**: Automatically triggers build
2. **Export Process**: 
   - Uses Godot 4.2.2 headless export
   - Exports to HTML5/WebAssembly format
3. **Deployment**: 
   - Uploads to GitHub Pages
   - Available at: https://kabuumu.github.io/godot-platformer/

### Build Process
The `.github/workflows/build-deploy.yml` workflow:
- Checks out the repository
- Downloads Godot 4.2.2 export templates
- Exports the game for Web platform
- Prepares the build artifacts
- Deploys to GitHub Pages

## Development Guide

### Prerequisites
- Godot Engine 4.2 or later
- Git for version control
- (Optional) Aseprite or similar for sprite editing

### Running Locally
1. Clone the repository
2. Open `project.godot` in Godot Engine
3. Press F5 to run the game
4. Use F6 to run a specific scene

### Making Changes

#### Adding New Levels
1. Create a new scene extending Node2D
2. Add TileMap node with the platform tileset
3. Place Player and Enemy instances
4. Update `project.godot` to set new main scene

#### Creating New Enemies
1. Duplicate `scenes/enemy.tscn`
2. Modify sprite and collision shape
3. Update `scripts/enemy.gd` for new behavior
4. Add to level scene

#### Adding Audio
1. Place audio files in `assets/audio/`
2. Create AudioStreamPlayer nodes
3. Connect to game events in scripts

### Testing
- Run the game with F5
- Test all player mechanics (jump, wall jump, shoot)
- Verify enemy AI behavior
- Check collision detection
- Test on web export locally

## Future Enhancements

### Potential Features
- Multiple levels with progression
- Boss battles with unique mechanics
- Power-ups and weapon upgrades
- Health pickups and energy refills
- Checkpoint system
- Background music and sound effects
- Particle effects for hits and deaths
- More enemy types with varied AI
- Mobile touch controls for web version
- Gamepad support

### Code Improvements
- Animation system for player states
- State machine for complex behaviors
- Object pooling for bullets
- Save system for progress
- Settings menu (volume, controls)
- Level transition system

## Performance

### Target Metrics
- 60 FPS on modern browsers
- < 5MB total download size
- < 2 second load time
- Responsive controls (< 16ms input lag)

### Optimization
- SVG assets are lightweight
- Minimal texture compression for pixel art
- Efficient collision detection
- No complex shaders or effects

## License
Open source - free to use, modify, and learn from.

## Credits
- Built with Godot Engine 4.2
- Inspired by Mega Man (Capcom)
- Created for educational purposes
