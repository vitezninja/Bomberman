# Multiplayer Bomberman
## Project Overview
This project is a competitive multiplayer Bomberman-style game, developed with the <b>Godot Game Engine</b>. It draws inspiration from the classic Bomberman games, particularly <i>Dyna Blaster</i>, offering modern mechanics and a multiplayer experience. The game is designed for two or three players, and the objective is to be the last player standing by strategically placing bombs to destroy crates, enemies, and opponents.

## Key Features
- **2D Gameplay**: The game takes place on a grid-based 2D map, with destructible crates and indestructible walls.
- **Multiplayer Support**: Play against other players over a network, with the server running on an Azure VM.
- **Power-ups and Bonuses**: Players can collect various power-ups to gain an edge, including bomb enhancements, speed boosts, and invulnerability.
- **Intelligent Enemies**: Enemies have different movement patterns and AI heuristics, making them unpredictable.
- **Customizable Controls**: Players can remap their keyboard controls and save these configurations for future sessions.
- **Persistence**: The game state can be saved and loaded, allowing players to continue where they left off.
- **Dynamic Map Selection**: The game includes several pre-designed maps to choose from, and each game session is different based on dynamic power-up distribution.
- **Network Multiplayer**: Supports local multiplayer as well as networked multiplayer via an Azure-hosted server. <i>(the server is currently offline, and is set to localhost in the game files)</i>
- **3D and 2.5D Visuals**: The game uses a 2.5D graphical style, giving depth to the classic 2D top-down view.

## Game Mechanics
- **Bombs**: Players place bombs, which explode in four directions (up, down, left, right), destroying crates, enemies, and potentially other players. Chain reactions can occur when bombs detonate each other.
- **Power-ups**: Various power-ups can be found in destroyed crates, including:
  - **Extra Bombs**: Increases the number of bombs a player can place at once.
  - **Bomb Range**: Increases the explosion range of bombs.
  - **Speed Boost**: Increases the player’s movement speed.
  - **Detonator**: Allows manual detonation of bombs.
  - **Ghost**: Enables passing through walls and bombs for a limited time.
  - **Invincibility**: Gives the player a brief invincibility to damage.
  - **Box**: Allows the player to place breakeble boxes that can't spawn power-ups.
- **Enemies**: Different enemy types roam the map with unique behaviors and movement patterns.
- **Three-Player Mode**: An additional player can join, increasing the chaos and competition.

## Game End
The game ends when only one player is left alive. If the last players dies while there are bombs or exlosions still on screen, the game ends in a draw.

## Installation & Setup
1. Clone the Repository:  
```bash
git clone https://github.com/vitezninja/Bomberman
```
2. Run the Game:  
Open the project with Godot Engine.
Set up the Azure server for multiplayer functionality (optional for single-player or local multiplayer).
Choose the game mode and start playing.

# Screenshots
[SCREENSHOT GOES HERE#1]  
[SCREENSHOT GOES HERE#2]  
[SCREENSHOT GOES HERE#3]  

## Documentation

### Design Documents
Design and architectural choices are documented in the [Design Documents Wiki](https://github.com/vitezninja/Bomberman/wiki/Design-Documents).

### Game Information
For details about in-game features such as power-ups, enemy types, map layouts, and keybindings, refer to the [Game Information Wiki](https://github.com/vitezninja/Bomberman/wiki/Game-Information).

## License
This project is licensed under the MIT License. You can view the full license [here](https://github.com/vitezninja/Bomberman/blob/master/LICENSE).

## Contributors
- **Tóth Benedek Vitéz**
- **Fodor Attila**
- **Andirkó Antal**  
All other contributors, including those responsible for in-game assets, are credited within the game.

<hr>
This project was developed as part of the Software Technology course at <b>ELTE Faculty of Informatics (2023/2024 Spring).</b>
