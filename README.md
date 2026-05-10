# ⚔️ Idle Game

> A post-apocalyptic medieval fantasy idle game built with Godot 4.  
> My first game project — built from scratch.

---

## 🎮 About

The world has collapsed. Civilization is in ruins, overrun by skeletons, zombies, orcs, and demons. You are the last bastion — managing a crumbling stronghold, scavenging for scraps, farming what little food remains, and hiring archers to hold back the ever-growing horde.

Survive. Upgrade. Endure.

---

## ✨ Features

- ⚔️ **Click-to-fight combat** — tap enemies to deal damage
- 🏹 **Archer system** — recruit and upgrade archers that fight automatically
- 🪙 **Resource management** — collect Gold, Scrap, and Food
- 🏚️ **Room unlocks** — unlock the Storeroom and Farm to expand your base
- 📈 **Upgrade tree** — improve scavenging, farming, combat damage, and more
- 💾 **Save system** — auto-saves every 60 seconds and on app close
- 📱 **Android support**

---

## 🛠️ Built With

- [Godot 4](https://godotengine.org/) — game engine
- GDScript — scripting language

---

## 🚀 Getting Started

### Prerequisites

- [Godot 4.x](https://godotengine.org/download) installed

### Run Locally

1. Clone the repository:
   ```bash
   git clone https://github.com/lel1guy/idle-game.git
   ```
2. Open **Godot 4**
3. Click **Import** and select the `project.godot` file
4. Press **F5** or click the ▶️ Play button to run

### Android Build

1. Set up the [Android export template](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html) in Godot
2. Go to **Project → Export → Android**
3. Configure your keystore and click **Export Project**

---

## 📁 Project Structure

```
idle-game/
├── Assets/          # Sprites, animations, audio
├── Scenes/          # Godot scene files (.tscn)
├── Scripts/         # GDScript files
│   ├── GameManager.gd   # Autoload — global state & signals
│   ├── Game.gd          # Main game scene logic
│   ├── Mob.gd           # Base mob class
│   ├── archer.gd        # Archer unit logic
│   ├── arrow.gd         # Projectile logic
│   ├── upgrade_item.gd  # Individual upgrade UI + logic
│   ├── upgrades.gd      # Upgrades container
│   ├── resources.gd     # Resource display UI
│   └── main.gd          # Entry point / scene switcher
├── Save&Load.gd     # Autoload — save/load system (JSON)
└── project.godot    # Godot project config
```

---

## 💾 Save System

The game saves to `user://SaveFile.json`. It triggers on:
- App close / back button
- App losing focus
- Automatically every **60 seconds**

---

## 🗺️ Roadmap

- [ ] More mob types and stages
- [ ] Prestige / reset system
- [ ] Offline progression (idle income while app is closed)
- [ ] Sound effects & background music
- [ ] Animated UI feedback

---

## 👤 Author

**lel1guy** — first game project, made with Godot 4.

---

## 📄 License

This project is currently unlicensed. All rights reserved.
