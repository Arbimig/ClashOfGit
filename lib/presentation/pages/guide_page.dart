import 'package:flutter/material.dart';
import 'package:clashofclans/internal/app_strings.dart';

import '../../internal/apps_page.dart';

// --- Data Models ---

class Guide {
  final String title;
  final String shortDescription;
  final String fullContent;
  final GuideCategory category;
  final int? townHallLevel; // only for Army guides

  const Guide({
    required this.title,
    required this.shortDescription,
    required this.fullContent,
    required this.category,
    this.townHallLevel,
  });
}

enum GuideCategory { army, war, farming }

// --- Hardcoded Guide Data ---

final List<Guide> allGuides = [
  // Army guides
  Guide(
    title: 'TH4 Giant Healer',
    shortDescription: 'Simple and effective attack strategy for Town Hall 4',
    fullContent:
        '**Giant Healer Strategy for TH4**\n\n'
        'This is one of the most reliable strategies at TH4. Giants tank damage while the Healer keeps them alive.\n\n'
        '**Army Composition:**\n'
        '- 12 Giants\n'
        '- 2 Healers\n'
        '- 8 Wall Breakers\n'
        '- 8 Archers\n\n'
        '**How to execute:**\n'
        '1. Deploy Giants in a line near the defenses\n'
        '2. Drop Healers behind the Giants\n'
        '3. Use Wall Breakers to open compartments\n'
        '4. Clean up with remaining troops\n\n'
        'Guide content coming soon with more details...',
    category: GuideCategory.army,
    townHallLevel: 4,
  ),
  Guide(
    title: 'TH7 DragLoon',
    shortDescription: 'Classic Dragon and Balloon attack for Town Hall 7',
    fullContent:
        '**DragLoon Strategy for TH7**\n\n'
        'DragLoon is a powerful air strategy that dominates at TH7.\n\n'
        '**Army Composition:**\n'
        '- 10 Dragons\n'
        '- 20 Balloons\n'
        '- 3 Rage Spells\n'
        '- 1 Poison Spell\n\n'
        '**How to execute:**\n'
        '1. Deploy Dragons on one side to create a funnel\n'
        '2. Send Balloons behind Dragons to target defenses\n'
        '3. Use Rage Spells on Balloons when they reach core\n'
        '4. Drop Poison on enemy Clan Castle troops\n\n'
        'Guide content coming soon with more details...',
    category: GuideCategory.army,
    townHallLevel: 7,
  ),
  Guide(
    title: 'TH9 GoWiPe',
    shortDescription: 'Golems, Wizards, and P.E.K.K.As for Town Hall 9',
    fullContent:
        '**GoWiPe Strategy for TH9**\n\n'
        'A classic ground attack that works well for 2-star attacks at TH9.\n\n'
        '**Army Composition:**\n'
        '- 2 Golems\n'
        '- 18 Wizards\n'
        '- 3 P.E.K.K.As\n'
        '- 4 Wall Breakers\n'
        '- 5 Archers\n'
        '- 2 Rage, 1 Heal, 1 Jump, 1 Poison\n\n'
        '**How to execute:**\n'
        '1. Deploy Golems to tank\n'
        '2. Send Wizards behind to clear trash buildings\n'
        '3. Use Wall Breakers and Jump Spell to get into core\n'
        '4. Deploy P.E.K.K.As and Heroes into the core\n'
        '5. Use Rage and Heal spells to sustain the push\n\n'
        'Guide content coming soon with more details...',
    category: GuideCategory.army,
    townHallLevel: 9,
  ),
  Guide(
    title: 'TH10 Queen Charge LaLoon',
    shortDescription: 'Queen Charge into LavaLoon for Town Hall 10',
    fullContent:
        '**Queen Charge LaLoon for TH10**\n\n'
        'A versatile strategy combining Queen Charge with LavaLoon.\n\n'
        '**Army Composition:**\n'
        '- 4 Healers (for Queen Charge)\n'
        '- 2 Lava Hounds\n'
        '- 16 Balloons\n'
        '- 1 Rage, 5 Haste, 1 Freeze, 1 Poison\n\n'
        '**How to execute:**\n'
        '1. Start Queen Charge on a key defense\n'
        '2. Deploy Lava Hounds to tank air defenses\n'
        '3. Send Balloons behind Hounds\n'
        '4. Use Haste to speed up Balloons\n'
        '5. Freeze Inferno Towers when targeted\n\n'
        'Guide content coming soon with more details...',
    category: GuideCategory.army,
    townHallLevel: 10,
  ),
  Guide(
    title: 'TH11 Hybrid (Hogs + Miners)',
    shortDescription: 'Hybrid attack using Hog Riders and Miners',
    fullContent:
        '**Hybrid Strategy for TH11**\n\n'
        'Hybrid attacks combine Hog Riders and Miners for a powerful ground assault.\n\n'
        '**Army Composition:**\n'
        '- 18 Hog Riders\n'
        '- 18 Miners\n'
        '- 5 Healers\n'
        '- 3 Rage, 3 Heal, 1 Freeze, 1 Poison\n\n'
        '**How to execute:**\n'
        '1. Queen Charge to take out key defenses\n'
        '2. Deploy Hogs and Miners in a wide spread\n'
        '3. Use Heal spells on Hogs over Giant Bombs\n'
        '4. Rage when troops reach the core\n'
        '5. Freeze Eagle Artillery when activated\n\n'
        'Guide content coming soon with more details...',
    category: GuideCategory.army,
    townHallLevel: 11,
  ),
  Guide(
    title: 'TH12 Yeti Smash',
    shortDescription: 'Yeti-based attack for Town Hall 12',
    fullContent:
        '**Yeti Smash Strategy for TH12**\n\n'
        'Yetis with Witches create a powerful smashing force at TH12.\n\n'
        '**Army Composition:**\n'
        '- 12 Yetis\n'
        '- 8 Witches\n'
        '- 2 Golems\n'
        '- 3 Rage, 2 Freeze, 1 Poison\n\n'
        '**How to execute:**\n'
        '1. Deploy Golems to tank initial defenses\n'
        '2. Send Yetis and Witches behind\n'
        '3. Use Rage in the core for maximum damage\n'
        '4. Freeze Scattershots when they target your Yetis\n'
        '5. Heroes clean up the corners\n\n'
        'Guide content coming soon with more details...',
    category: GuideCategory.army,
    townHallLevel: 12,
  ),
  Guide(
    title: 'TH13 Super Archer Blimp',
    shortDescription: 'Super Archers in a Blimp for Town Hall 13',
    fullContent:
        '**Super Archer Blimp for TH13**\n\n'
        'A surgical strategy using Super Archers delivered by Blimp.\n\n'
        '**Army Composition:**\n'
        '- 20 Super Archers\n'
        '- 1 Blimp\n'
        '- 5 Healers\n'
        '- 4 Invisibility, 2 Freeze, 1 Rage\n\n'
        '**How to execute:**\n'
        '1. Send Blimp with Super Archers to the core\n'
        '2. Use Invisibility when defenses target the Blimp\n'
        '3. Deploy Super Archers in the core\n'
        '4. Chain Invisibility spells for sustained damage\n'
        '5. Queen Charge from the opposite side\n\n'
        'Guide content coming soon with more details...',
    category: GuideCategory.army,
    townHallLevel: 13,
  ),

  // War guides
  Guide(
    title: 'War Attack Planning',
    shortDescription: 'How to plan your attacks during Clan War',
    fullContent:
        '**War Attack Planning Guide**\n\n'
        'Proper planning is key to winning Clan Wars.\n\n'
        '**Steps:**\n'
        '1. Scout the enemy base thoroughly\n'
        '2. Identify weak points and trap locations\n'
        '3. Choose the right army composition\n'
        '4. Plan your funnel carefully\n'
        '5. Time your spell drops perfectly\n\n'
        'Guide content coming soon with more details...',
    category: GuideCategory.war,
  ),
  Guide(
    title: 'Anti 3-Star Base Design',
    shortDescription: 'Design bases that prevent 3-star attacks',
    fullContent:
        '**Anti 3-Star Base Design Guide**\n\n'
        'Learn how to design bases that frustrate attackers.\n\n'
        '**Key Principles:**\n'
        '1. Spread out air defenses\n'
        '2. Protect the Town Hall without making it obvious\n'
        '3. Use compartments to slow ground troops\n'
        '4. Place traps in unexpected locations\n'
        '5. Keep high-value defenses separated\n\n'
        'Guide content coming soon with more details...',
    category: GuideCategory.war,
  ),
  Guide(
    title: 'Clan Castle Defense',
    shortDescription: 'Best Clan Castle troop compositions for defense',
    fullContent:
        '**Clan Castle Defense Guide**\n\n'
        'The right Clan Castle troops can ruin an attack.\n\n'
        '**Best Defensive Compositions:**\n'
        '- 1 Lava Hound + 2 Witches\n'
        '- 1 Dragon + 1 Baby Dragon\n'
        '- 2 Ice Golems + 1 Witch\n'
        '- 1 Electro Dragon + 1 Wizard\n\n'
        'Guide content coming soon with more details...',
    category: GuideCategory.war,
  ),

  // Farming guides
  Guide(
    title: 'Barch Basics',
    shortDescription: 'Barbarian and Archer farming — the simplest strategy',
    fullContent:
        '**Barch Farming Guide**\n\n'
        'Barch (Barbarians + Archers) is the most cost-effective farming strategy.\n\n'
        '**Army Composition:**\n'
        '- 120 Barbarians\n'
        '- 80 Archers\n'
        '- 20 Goblins (optional)\n\n'
        '**How to execute:**\n'
        '1. Find a base with exposed collectors\n'
        '2. Deploy Barbarians on collectors\n'
        '3. Deploy Archers behind to support\n'
        '4. Use Goblins to snipe resources\n'
        '5. Don\'t worry about stars, just get resources\n\n'
        'Guide content coming soon with more details...',
    category: GuideCategory.farming,
  ),
  Guide(
    title: 'Goblin Knife',
    shortDescription: 'Advanced Goblin-based farming strategy',
    fullContent:
        '**Goblin Knife Farming Guide**\n\n'
        'Goblin Knife is an advanced farming technique for maximum resource gain.\n\n'
        '**Army Composition:**\n'
        '- 100+ Goblins\n'
        '- 5-8 Jump Spells\n'
        '- 1 Rage Spell\n\n'
        '**How to execute:**\n'
        '1. Identify bases with full storages\n'
        '2. Use Jump Spell to reach the core\n'
        '3. Deploy Goblins on storages\n'
        '4. Use Rage to speed up looting\n'
        '5. Goblins prioritize resource buildings\n\n'
        'Guide content coming soon with more details...',
    category: GuideCategory.farming,
  ),
  Guide(
    title: 'Dead Base Hunting',
    shortDescription: 'How to find and attack dead bases for easy loot',
    fullContent:
        '**Dead Base Hunting Guide**\n\n'
        'Dead bases (inactive players) are the best farming targets.\n\n'
        '**Signs of a Dead Base:**\n'
        '- Full collectors overflowing with resources\n'
        '- Builder huts empty\n'
        '- No Clan Castle troops\n'
        '- Low-level defenses\n\n'
        '**Strategy:**\n'
        '1. Use "Next" button to search for dead bases\n'
        '2. Look for full gold/elixir collectors\n'
        '3. Use cheap Barch army\n'
        '4. Collect resources and move on\n\n'
        'Guide content coming soon with more details...',
    category: GuideCategory.farming,
  ),
];

// --- Guide Page ---

class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Guide> _filterGuides(GuideCategory category) {
    final categoryGuides =
        allGuides.where((g) => g.category == category).toList();
    if (_searchQuery.isEmpty) return categoryGuides;
    final query = _searchQuery.toLowerCase();
    return categoryGuides
        .where((g) =>
            g.title.toLowerCase().contains(query) ||
            g.shortDescription.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search guides...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).textTheme.bodyMedium?.color,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(text: 'Army'),
              Tab(text: 'War'),
              Tab(text: 'Farming'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildGuideList(GuideCategory.army),
                _buildGuideList(GuideCategory.war),
                _buildGuideList(GuideCategory.farming),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuideList(GuideCategory category) {
    final guides = _filterGuides(category);
    if (guides.isEmpty) {
      return Center(
        child: Text(
          'No guides found',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: guides.length,
      itemBuilder: (context, index) {
        final guide = guides[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              guide.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                guide.shortDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            trailing: guide.townHallLevel != null
                ? Chip(
                    label: Text(
                      'TH${guide.townHallLevel}',
                      style: TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  )
                : Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GuideDetailPage(guide: guide),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// --- Guide Detail Page ---

class GuideDetailPage extends StatelessWidget {
  final Guide guide;

  const GuideDetailPage({Key? key, required this.guide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(guide.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (guide.townHallLevel != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Chip(
                  label: Text('Town Hall ${guide.townHallLevel}'),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
            Text(
              guide.shortDescription,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            const SizedBox(height: 16),
            Divider(),
            const SizedBox(height: 16),
            Text(
              guide.fullContent,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

// --- App Bar ---

class GuidePageAppBar extends StatelessWidget with PrefAppBar {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      title: Text('Guides'),
    );
  }
}
