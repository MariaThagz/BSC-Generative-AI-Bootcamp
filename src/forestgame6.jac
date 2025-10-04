"""🌲 Forest Adventure Game - Step 6 (Abilities with byllm + Gemini AI)"""
import random;
import from byllm.llm { Model }

glob llm = Model(
    model_name="gemini/gemini-pro",
    verbose=False
);

"""Generate atmospheric description for location"""
def generate_atmosphere(location_name: str, description: str) -> str by llm();

"""Generate strategic hint for player"""
def generate_hint(moves: int, items: str, location: str, path: str) -> str by llm();

"""Analyze player's performance"""
def analyze_performance(won: bool, moves: int, items: str, path: str, score: int) -> str by llm();

"""Generate item discovery message"""
def generate_item_message(item_name: str) -> str by llm();

walker ForestExplorer {
    has player_choice: str = "";
    has moves_taken: int = 0;
    has items_collected: list = [];
    has path_history: list = [];
    has game_over: bool = False;
    has won: bool = False;
    
    can start with `root entry;
    can explore_location with location entry;
}

node location {
    has name: str = "Forest Entrance";
    has description: str = "You stand at the entrance.";
    has is_goal: bool = False;
    has is_danger: bool = False;
    has item: str = "";
    has danger_level: int = 0;
    
    can describe_atmosphere with ForestExplorer entry;
    can handle_item with ForestExplorer entry;
    can check_danger with ForestExplorer entry;
}

with entry:__main__ {
    root spawn ForestExplorer();
}

impl ForestExplorer.start {
    print("\n" + "="*60);
    print("🌲 FOREST ADVENTURE - AI ENHANCED 🌲".center(60));
    print("="*60);
    print("\n🎮 STEP 6 VERSION - Abilities with byllm + Gemini!");
    print("\n📖 Explore the enchanted forest.");
    print("   Choose LEFT or RIGHT at each location.");
    print("   Collect items to protect yourself!");
    print(f"   You have 15 moves.\n");
    print("="*60);
    
    input("\n➤ Press ENTER to begin...");
    
    if not [root --> (`?location)] {
        entrance = root ++> location(
            name="🌲 Enchanted Forest Entrance",
            description="Magical energy tingles in the air. Two paths lie ahead."
        );
    } else {
        entrance = [root --> (`?location)];
    }
    
    visit entrance;
}

impl ForestExplorer.explore_location {
    self.moves_taken += 1;
    
    if self.game_over {
        self.show_final_results();
        disengage;
    }
    
    if self.moves_taken >= 15 {
        print("\n⏰ TIME'S UP! You ran out of moves.");
        self.game_over = True;
        self.show_final_results();
        disengage;
    }
    
    print("\n" + "-"*60);
    print("🤔 Choose your path:");
    print("   👈 [L] Go LEFT");
    print("   👉 [R] Go RIGHT");
    print("   💡 [H] Get AI Hint");
    print("   🚪 [Q] Quit");
    print("-"*60);
    
    player_choice = input("\n➤ Your choice: ");
    self.player_choice = player_choice.strip().upper();
    
    if self.player_choice in ["Q", "QUIT"] {
        print("\n👋 Thanks for exploring!");
        self.game_over = True;
        self.show_final_results();
        disengage;
    } elif self.player_choice in ["H", "HINT"] {
        self.get_ai_hint();
        self.moves_taken -= 1;
        visit here;
    } elif self.player_choice in ["L", "LEFT"] {
        self.path_history.append("LEFT");
        left_locs = [
            ("🌑 Shadow Grove", "Dark trees loom. Whispers echo in the darkness.", False, False, 1, ""),
            ("🕷️ Spider's Lair", "Giant webs block your path. A massive spider approaches!", False, True, 3, ""),
            ("🍄 Fairy Ring", "Glowing mushrooms form a perfect circle. Fairies dance!", False, False, 0, "Fairy Blessing"),
            ("💎 Dragon's Hoard", "Mountains of treasure! The dragon is sleeping...", True, False, 0, "Dragon Treasure"),
            ("🔮 Mystic Altar", "An ancient altar pulses with magical energy.", False, False, 0, "Magic Amulet")
        ];
        chosen = random.choice(left_locs);
        next_loc = root ++> location(name=chosen[0], description=chosen[1], is_goal=chosen[2], is_danger=chosen[3], danger_level=chosen[4], item=chosen[5]);
        visit next_loc;
    } elif self.player_choice in ["R", "RIGHT"] {
        self.path_history.append("RIGHT");
        right_locs = [
            ("☀️ Luminous Meadow", "Sunlight streams through. Flowers glow with inner light.", False, False, 0, ""),
            ("💧 Crystal Springs", "Magical water bubbles from the earth. You feel rejuvenated.", False, False, 0, "Crystal Water"),
            ("🐻 Bear Territory", "A massive grizzly roars! There's no escape!", False, True, 3, ""),
            ("🌊 Rainbow Waterfall", "A magnificent waterfall creates permanent rainbows!", True, False, 0, "Rainbow Pearl"),
            ("🧚 Fairy Court", "The Fairy Queen greets you! What an honor!", True, False, 0, "Royal Blessing")
        ];
        chosen = random.choice(right_locs);
        next_loc = root ++> location(name=chosen[0], description=chosen[1], is_goal=chosen[2], is_danger=chosen[3], danger_level=chosen[4], item=chosen[5]);
        visit next_loc;
    } else {
        print("❌ Invalid choice!");
        self.moves_taken -= 1;
        visit here;
    }
}

impl ForestExplorer.get_ai_hint {
    items_str = ', '.join(self.items_collected) if len(self.items_collected) > 0 else "none";
    path_str = ' -> '.join(self.path_history[-5:]) if len(self.path_history) > 0 else "just started";
    
    hint = generate_hint(self.moves_taken, items_str, here.name, path_str);
    print(f"\n🤖 AI GUIDE: {hint}\n");
}

impl ForestExplorer.show_final_results {
    score = self.calculate_score();
    
    print("\n" + "="*60);
    print("📊 ADVENTURE SUMMARY");
    print("="*60);
    print(f"🏆 Final Score: {score} points");
    print(f"⏱️  Moves Taken: {self.moves_taken}");
    print(f"🎒 Items: {len(self.items_collected)}");
    if len(self.items_collected) > 0 {
        print(f"   └─ {', '.join(self.items_collected)}");
    }
    print(f"🗺️  Path: {' → '.join(self.path_history)}");
    
    if self.won {
        print("\n🌟 Status: VICTORIOUS!");
    } elif score > 100 {
        print("\n⭐ Status: Great Explorer!");
    } else {
        print("\n✨ Status: Brave Adventurer!");
    }
    
    items_str = ', '.join(self.items_collected) if len(self.items_collected) > 0 else "none";
    path_str = ' -> '.join(self.path_history) if len(self.path_history) > 0 else "none";
    
    analysis = analyze_performance(self.won, self.moves_taken, items_str, path_str, score);
    print(f"\n🤖 AI ANALYSIS:\n{analysis}\n");
    
    print("="*60);
}

impl ForestExplorer.calculate_score -> int {
    score = 0;
    score += (15 - self.moves_taken) * 10;
    score += len(self.items_collected) * 25;
    if self.won {
        score += 150;
    }
    return score;
}

impl location.describe_atmosphere {
    print("\n" + "="*60);
    print(f"📍 {here.name}");
    print("-"*60);
    
    ai_atmosphere = generate_atmosphere(here.name, here.description);
    print(f"🌟 {ai_atmosphere}");
    
    if here.danger_level > 0 {
        print(f"\n⚠️  Danger: {'🔥' * here.danger_level}");
    }
    
    print(f"\n⏱️  Moves: {visitor.moves_taken}/15");
    print("="*60);
}

impl location.handle_item {
    if here.item and here.item not in visitor.items_collected {
        print(f"\n✨ DISCOVERY! You found: {here.item}!");
        visitor.items_collected.append(here.item);
        
        item_msg = generate_item_message(here.item);
        print(f"🤖 {item_msg}");
    }
    
    if len(visitor.items_collected) > 0 {
        print(f"\n🎒 Your Items: {' | '.join(visitor.items_collected)}");
    }
}

impl location.check_danger {
    if here.is_danger {
        print("\n" + "💀"*20);
        print("⚠️  DANGER DETECTED! ⚠️");
        
        can_escape = False;
        used_item = "";
        
        if "Fairy Blessing" in visitor.items_collected {
            print("✨ Your Fairy Blessing protects you!");
            can_escape = True;
            used_item = "Fairy Blessing";
        } elif "Magic Amulet" in visitor.items_collected {
            print("🔮 The Magic Amulet shields you!");
            can_escape = True;
            used_item = "Magic Amulet";
        } elif "Crystal Water" in visitor.items_collected {
            print("💧 The Crystal Water heals you!");
            can_escape = True;
            used_item = "Crystal Water";
        }
        
        if can_escape {
            print("🎉 You narrowly escaped!");
            visitor.items_collected.remove(used_item);
            print(f"💔 You used: {used_item}");
        } else {
            print("💀 The danger is too great. Game over!");
            visitor.game_over = True;
        }
        
        print("💀"*20 + "\n");
    }
    
    if here.is_goal and not visitor.game_over {
        print("\n" + "🎉"*20);
        print("🏆 VICTORY! 🏆");
        print(f"You discovered: {here.name}!");
        visitor.won = True;
        visitor.game_over = True;
        print("🎉"*20 + "\n");
    }
}
