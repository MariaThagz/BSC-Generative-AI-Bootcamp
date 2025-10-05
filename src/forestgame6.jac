"""🌲 Forest Adventure Game - Step 6 (Abilities with byllm + Gemini AI)"""
import random;
import os;
import from byllm.llm { Model }

glob llm = Model(
    model_name="gemini/gemini-2.5-flash",
    verbose=False
);

"""Generate atmospheric description for location"""
def generate_atmosphere(location_name: str, description: str) -> str by llm();

"""Generate strategic hint for player"""
def generate_hint(moves: int, items: str, location: str) -> str by llm();

"""Analyze player's performance"""
def analyze_performance(won: bool, moves: int, items: str, score: int) -> str by llm();

"""Generate item discovery message"""
def generate_item_message(item_name: str) -> str by llm();

walker ForestExplorer {
    has player_choice: str = "";
    has moves_taken: int = 0;
    has items_collected: list = [];
    has path_history: list = [];
    has game_over: bool = False;
    has won: bool = False;
    has visited_locations: list = [];
    
    can start with `root entry;
    can explore_location with location entry;
    can show_final_results with `root entry;
}

node location {
    has name: str = "Forest Entrance";
    has description: str = "You stand at the entrance.";
    has is_goal: bool = False;
    has is_danger: bool = False;
    has item: str = "";
    has danger_level: int = 0;
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
    
    entrance = root ++> location(
        name="🌲 Enchanted Forest Entrance",
        description="Magical energy tingles in the air. Two paths lie ahead.",
        is_goal=False,
        is_danger=False,
        item="",
        danger_level=0
    );
    
    visit entrance;
}

impl ForestExplorer.explore_location {
    print("\n" + "="*60);
    print(f"📍 {here.name}");
    print("-"*60);
    
    print("✨ Observing the environment...");
    ai_atmosphere = generate_atmosphere(here.name, here.description);
    print(f"\n🌟 {ai_atmosphere}");
    
    if here.danger_level > 0 {
        print(f"\n⚠️  Danger: {'🔥' * here.danger_level}");
    }
    
    print(f"\n⏱️  Moves: {self.moves_taken}/15");
    print("="*60);
    
    if here.item and here.item not in self.items_collected {
        print(f"\n✨ DISCOVERY! You found: {here.item}!");
        self.items_collected.append(here.item);
        
        print("🔍 Examining the item...");
        item_msg = generate_item_message(here.item);
        print(f"💬 {item_msg}");
    }
    
    if len(self.items_collected) > 0 {
        print(f"\n🎒 Your Items: {' | '.join(self.items_collected)}");
    }
    
    if here.is_danger {
        print("\n" + "💀"*20);
        print("⚠️  DANGER DETECTED! ⚠️");
        
        can_escape = False;
        used_item = "";
        
        if "Fairy Blessing" in self.items_collected {
            print("✨ Your Fairy Blessing protects you!");
            can_escape = True;
            used_item = "Fairy Blessing";
        } elif "Magic Amulet" in self.items_collected {
            print("🔮 The Magic Amulet shields you!");
            can_escape = True;
            used_item = "Magic Amulet";
        } elif "Crystal Water" in self.items_collected {
            print("💧 The Crystal Water heals you!");
            can_escape = True;
            used_item = "Crystal Water";
        } elif "Echo Stone" in self.items_collected {
            print("🦇 The Echo Stone confuses your enemies!");
            can_escape = True;
            used_item = "Echo Stone";
        } elif "Butterfly Wing" in self.items_collected {
            print("🦋 The Butterfly Wing lets you fly away!");
            can_escape = True;
            used_item = "Butterfly Wing";
        }
        
        if can_escape {
            print("🎉 You narrowly escaped!");
            self.items_collected.remove(used_item);
            print(f"💔 You used: {used_item}");
        } else {
            print("💀 The danger is too great. Game over!");
            self.game_over = True;
        }
        
        print("💀"*20 + "\n");
    }
    
    if here.is_goal and not self.game_over {
        print("\n" + "🎉"*20);
        print("🏆 VICTORY! 🏆");
        print(f"You discovered: {here.name}!");
        self.won = True;
        self.game_over = True;
        print("🎉"*20 + "\n");
    }
    
    if self.game_over {
        visit [-->](`?root);
    }
    
    if self.moves_taken >= 15 {
        print("\n⏰ TIME'S UP! You ran out of moves.");
        self.game_over = True;
        visit [-->](`?root);
    }
    
    print("\n" + "-"*60);
    print("🤔 Choose your path:");
    print("   👈 [L/LEFT/1] Go LEFT");
    print("   👉 [R/RIGHT/2] Go RIGHT");
    print("   💡 [H/HINT/?] Get AI Hint");
    print("   🚪 [Q/QUIT] Quit");
    print("-"*60);
    
    player_choice = input("\n➤ Your choice: ");
    self.player_choice = player_choice.strip().upper();
    
    if self.player_choice in ["Q", "QUIT", "EXIT", "END"] {
        print("\n👋 Thanks for exploring!");
        self.game_over = True;
        visit [-->](`?root);
    } elif self.player_choice in ["H", "HINT", "HELP", "?"] {
        print("\n🔮 Consulting the AI Guide...\n");
        items_str = ', '.join(self.items_collected) if len(self.items_collected) > 0 else "none";
        hint = generate_hint(self.moves_taken, items_str, here.name);
        print(f"\n💡 AI GUIDE: {hint}\n");
        
        visit here;
    } elif self.player_choice in ["L", "LEFT", "<", "1"] {
        self.moves_taken += 1;
        self.path_history.append("LEFT");
        left_locs = [
            ("🌑 Shadow Grove", "Dark trees loom. Whispers echo.", False, False, 1, ""),
            ("🕷️ Spider's Lair", "Giant webs block your path!", False, True, 3, ""),
            ("🍄 Fairy Ring", "Glowing mushrooms dance!", False, False, 0, "Fairy Blessing"),
            ("💎 Dragon's Hoard", "Mountains of treasure!", True, False, 0, "Dragon Treasure"),
            ("🔮 Mystic Altar", "An altar pulses with power.", False, False, 0, "Magic Amulet"),
            ("🦇 Bat Cave", "Hundreds of bats swirl around you!", False, False, 2, "Echo Stone"),
            ("🌙 Moonlit Path", "Silver light guides your way.", False, False, 0, "Moon Crystal"),
            ("⚔️ Ancient Ruins", "Crumbling stone structures remain.", False, True, 2, "")
        ];
        
        available_locs = [loc for loc in left_locs if loc[0] not in self.visited_locations];
        if len(available_locs) == 0 {
            available_locs = left_locs;
            self.visited_locations = [];
        }
        
        chosen = random.choice(available_locs);
        self.visited_locations.append(chosen[0]);
        next_loc = here ++> location(name=chosen[0], description=chosen[1], is_goal=chosen[2], is_danger=chosen[3], danger_level=chosen[4], item=chosen[5]);
        visit next_loc;
    } elif self.player_choice in ["R", "RIGHT", ">", "2"] {
        self.moves_taken += 1;
        self.path_history.append("RIGHT");
        right_locs = [
            ("☀️ Luminous Meadow", "Sunlight streams through.", False, False, 0, ""),
            ("💧 Crystal Springs", "Magical water bubbles up.", False, False, 0, "Crystal Water"),
            ("🐻 Bear Territory", "A massive bear roars!", False, True, 3, ""),
            ("🌊 Rainbow Waterfall", "A magnificent waterfall!", True, False, 0, "Rainbow Pearl"),
            ("🧚 Fairy Court", "The Fairy Queen greets you!", True, False, 0, "Royal Blessing"),
            ("🦋 Butterfly Garden", "Thousands of colorful butterflies!", False, False, 0, "Butterfly Wing"),
            ("🌺 Enchanted Garden", "Flowers sing in harmony.", False, False, 0, "Petal Charm"),
            ("🐉 Dragon's Peak", "A mighty dragon guards the summit!", False, True, 4, "")
        ];
        
        available_locs = [loc for loc in right_locs if loc[0] not in self.visited_locations];
        if len(available_locs) == 0 {
            available_locs = right_locs;
            self.visited_locations = [];
        }
        
        chosen = random.choice(available_locs);
        self.visited_locations.append(chosen[0]);
        next_loc = here ++> location(name=chosen[0], description=chosen[1], is_goal=chosen[2], is_danger=chosen[3], danger_level=chosen[4], item=chosen[5]);
        visit next_loc;
    } else {
        print("❌ Invalid choice!");
        visit here;
    }
}

impl ForestExplorer.show_final_results {
    score = (15 - self.moves_taken) * 10 + len(self.items_collected) * 25;
    if self.won {
        score += 150;
    }
    
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
    
    print("\n🤖 Generating final analysis...\n");
    
    items_str = ', '.join(self.items_collected) if len(self.items_collected) > 0 else "none";
    
    analysis = analyze_performance(self.won, self.moves_taken, items_str, score);
    print(f"📝 AI ANALYSIS:\n{analysis}\n");
    
    print("="*60);
}