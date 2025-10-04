"""🌲 Forest Adventure Game - Step 5 (Walkers)"""
import random;

walker ForestExplorer {
    has player_choice: str = "";
    has moves_taken: int = 0;
    has items_collected: list = [];
    has game_over: bool = False;
    has won: bool = False;
    
    can start with `root entry;
    can explore_location with location entry;
}

node location {
    has name: str = "Forest Entrance";
    has description: str = "You stand at the entrance of a mysterious forest.";
    has is_goal: bool = False;
    has is_danger: bool = False;
    has item: str = "";
}

with entry:__main__ {
    root spawn ForestExplorer();
}

impl ForestExplorer.start {
    print("\n" + "="*60);
    print("🌲 FOREST ADVENTURE GAME 🌲".center(60));
    print("="*60);
    print("\n📖 Choose LEFT or RIGHT at each location.");
    print("   Find treasure and avoid danger!");
    print(f"   You have 10 moves to explore.\n");
    print("="*60);
    
    if not [root --> (`?location)] {
        entrance = root ++> location(
            name="🌳 Forest Entrance",
            description="Two paths diverge: a dark path left, a sunny path right."
        );
    } else {
        entrance = [root --> (`?location)];
    }
    
    visit entrance;
}

impl ForestExplorer.explore_location {
    print("\n" + "="*60);
    print(f"📍 {here.name}");
    print(f"   {here.description}");
    print(f"   Moves: {self.moves_taken}/10");
    
    if here.item and here.item not in self.items_collected {
        print(f"   ✨ Found: {here.item}!");
        self.items_collected.append(here.item);
    }
    
    if len(self.items_collected) > 0 {
        print(f"   🎒 Items: {', '.join(self.items_collected)}");
    }
    
    print("="*60);
    
    if here.is_goal {
        print("\n🎉 CONGRATULATIONS! You found a treasure!");
        print(f"Final Score: {(10 - self.moves_taken) * 10 + len(self.items_collected) * 20}");
        self.won = True;
        self.game_over = True;
        disengage;
    }
    
    if here.is_danger {
        print("\n💀 GAME OVER! You encountered danger!");
        print(f"Final Score: {len(self.items_collected) * 10}");
        self.game_over = True;
        disengage;
    }
    
    if self.moves_taken >= 10 {
        print("\n⏰ TIME'S UP! You ran out of moves.");
        print(f"Final Score: {len(self.items_collected) * 10}");
        self.game_over = True;
        disengage;
    }
    
    print("\n🤔 Choose your path:");
    print("   👈 Type 'LEFT' or 'L'");
    print("   👉 Type 'RIGHT' or 'R'");
    print("   🚪 Type 'QUIT' or 'Q'");
    
    player_choice = input("\n➤ Your choice: ");
    self.player_choice = player_choice.strip().upper();
    
    if self.player_choice in ["QUIT", "Q"] {
        print("\n👋 Thanks for playing!");
        self.game_over = True;
        disengage;
    } elif self.player_choice in ["LEFT", "L"] {
        self.moves_taken += 1;
        # Create random left location
        left_locs = [
            ("🌑 Dark Grove", "Ancient trees block sunlight. Strange noises echo.", False, False, ""),
            ("🕷️ Spider's Den", "Giant webs everywhere! Danger ahead!", False, True, ""),
            ("🍄 Mushroom Circle", "Glowing mushrooms form a magic circle!", False, False, "Magic Mushroom"),
            ("💎 Treasure Cave", "A cave full of ancient treasures!", True, False, "Golden Crown")
        ];
        chosen = random.choice(left_locs);
        next_loc = root ++> location(name=chosen[0], description=chosen[1], is_goal=chosen[2], is_danger=chosen[3], item=chosen[4]);
        visit next_loc;
    } elif self.player_choice in ["RIGHT", "R"] {
        self.moves_taken += 1;
        # Create random right location
        right_locs = [
            ("☀️ Sunny Clearing", "A bright meadow with colorful flowers.", False, False, ""),
            ("💧 Crystal Stream", "Beautiful stream with crystal-clear water.", False, False, "Fresh Water"),
            ("🐻 Bear Territory", "A massive bear blocks your path!", False, True, ""),
            ("🌊 Hidden Waterfall", "You discovered a magnificent waterfall!", True, False, "Waterfall Pearl")
        ];
        chosen = random.choice(right_locs);
        next_loc = root ++> location(name=chosen[0], description=chosen[1], is_goal=chosen[2], is_danger=chosen[3], item=chosen[4]);
        visit next_loc;
    } else {
        print("❌ Invalid choice! Try again.");
        visit here;
    }
}
