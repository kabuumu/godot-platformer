# Mega Man Style Platformer

A NES-style platformer game inspired by Mega Man, built with Godot 4.2.

## Play Online

The game is automatically deployed to GitHub Pages after each build. Play it here:
**[Play Game](https://kabuumu.github.io/godot-platformer/)**

## Features

- **Mega Man-style gameplay mechanics:**
  - Run and jump platforming
  - Wall sliding and wall jumping
  - Shooting projectiles
  - Enemy AI with patrol behavior
  
- **NES-style graphics:**
  - 256x224 resolution (scaled up for modern displays)
  - Pixel-perfect rendering
  - Retro color palette

- **Web deployment:**
  - Automatically builds and deploys to GitHub Pages
  - Playable directly in your browser

## Controls

- **Arrow Keys / A, D**: Move left and right
- **Space / W**: Jump (press again while on wall to wall jump)
- **X / Enter**: Shoot

## Development

### Prerequisites

- [Godot 4.2+](https://godotengine.org/download)

### Running Locally

1. Clone the repository:
   ```bash
   git clone https://github.com/kabuumu/godot-platformer.git
   cd godot-platformer
   ```

2. Open the project in Godot:
   - Launch Godot
   - Click "Import"
   - Navigate to the project folder and select `project.godot`
   - Click "Import & Edit"

3. Press F5 to run the game

### Building for Web

The game automatically builds for web on every push to `main` branch via GitHub Actions.

To build manually:
1. Open the project in Godot
2. Go to Project → Export
3. Select "Web" preset
4. Click "Export Project"

## Project Structure

```
godot-platformer/
├── assets/
│   ├── sprites/      # Character and object sprites
│   └── tiles/        # Tileset graphics
├── scenes/           # Game scenes (player, enemies, levels)
├── scripts/          # GDScript game logic
├── ui/               # User interface elements
└── project.godot     # Main project configuration
```

## Contributing

Contributions are welcome! Feel free to:
- Add new levels
- Create new enemy types
- Improve graphics and animations
- Add sound effects and music
- Fix bugs

## License

This project is open source and available for learning and modification.