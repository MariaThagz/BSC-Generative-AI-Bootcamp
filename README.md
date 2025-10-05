# 🌲 Forest Adventure Game

**BSC Bootcamp Project** - Learning Jac Language through game development

A text-based adventure game demonstrating Jac walkers, nodes, and AI integration.

---

## 🎮 Game Versions

### forestgame5.jac - Basic Version
- Walker/Node navigation
- Random location generation  
- Item collection system
- 10 moves to explore

### forestgame6.jac - AI Enhanced Version
- AI-powered descriptions (Gemini)
- Smart hint system
- Performance analysis
- 15 moves to explore

---

## 🚀 Quick Start

```bash
# Install Jac
pip install jaclang

# For Step 5 (Basic)
jac run src/forestgame5.jac

# For Step 6 (AI Enhanced - requires setup)
jac run src/forestgame6.jac
```

---

## 🤖 AI Setup (Step 6 Only)

```bash
# Install dependencies
pip install byllm

# Create .env file with your API key
GEMINI_API_KEY=your_key_here
```

Get Gemini API key: https://aistudio.google.com/app/apikey

---

## 🎯 How to Play

**Controls:**
- `L` / `LEFT` / `1` - Go left
- `R` / `RIGHT` / `2` - Go right  
- `H` / `HINT` - Get AI hint (Step 6 only)
- `Q` / `QUIT` - Exit game

**Goal:** Find treasure before running out of moves!

---

## 🌟 Features

### Locations
**LEFT Path:**
- 🌑 Dark Grove, 🕷️ Spider's Den (danger!), 🍄 Mushroom Circle, 💎 Treasure Cave (win!)

**RIGHT Path:**  
- ☀️ Sunny Clearing, 💧 Crystal Stream, 🐻 Bear Territory (danger!), 🌊 Hidden Waterfall (win!)

### Items
Collect protective items: ✨ Magic items, 💧 Crystal Water, 🦋 Butterfly Wing, etc.

### AI Features (Step 6)
- Dynamic location descriptions
- Strategic hints based on game state
- Final performance analysis

---

## 📊 Scoring

```
Score = (Moves Remaining × 10) + (Items × 25) + Victory Bonus (150)
```

---

## 🛠️ Tech Stack

- **Jac Language** - Graph-based programming
- **byllm** - LLM integration (Step 6)
- **Gemini 2.5 Flash** - Google AI (Step 6)

---

## 📝 Example Gameplay

```
============================================================
             🌲 FOREST ADVENTURE GAME 🌲             
============================================================
📖 Choose LEFT or RIGHT at each location.
   Find treasure and avoid danger!
   You have 10 moves to explore.
============================================================

📍 🌳 Forest Entrance
   Two paths diverge: a dark path left, a sunny path right.
   Moves: 0/10
============================================================

🤔 Choose your path:
   👈 Type 'LEFT' or 'L'
   👉 Type 'RIGHT' or 'R'
   🚪 Type 'QUIT' or 'Q'

➤ Your choice: R

============================================================
📍 💧 Crystal Stream
   Beautiful stream with crystal-clear water.
   Moves: 1/10
   ✨ Found: Fresh Water!
   🎒 Items: Fresh Water
============================================================

🤔 Choose your path:
   👈 Type 'LEFT' or 'L'
   👉 Type 'RIGHT' or 'R'
   🚪 Type 'QUIT' or 'Q'

➤ Your choice: R

============================================================
📍 🌊 Hidden Waterfall
   You discovered a magnificent waterfall!
   Moves: 2/10
   ✨ Found: Waterfall Pearl!
   🎒 Items: Fresh Water, Waterfall Pearl
============================================================

🎉 CONGRATULATIONS! You found a treasure!
Final Score: 120
```

---

## 🐛 Troubleshooting

**Step 5 issues:**
- Make sure Jac is installed: `pip install jaclang`
- Run from project root directory

**Step 6 issues:**
- Install byllm: `pip install byllm`
- Check `.env` file has `GEMINI_API_KEY`
- Get API key from Google AI Studio

---

## 📚 Learning Outcomes

This project demonstrates:
- Jac walker pattern for game logic
- Node-based graph navigation
- State management across nodes
- AI integration with byllm (Step 6)
- Interactive terminal UI

---

## 🎓 BSC Bootcamp

Part of the **BSC Blockchain Solutions Company Bootcamp** learning Jac Language fundamentals through practical game development.

---

**Built with ❤️ using Jac Language**
