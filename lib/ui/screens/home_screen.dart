import 'package:flutter/material.dart';
import 'package:test_skill/ui/screens/search_screen.dart';
import '../../data/models/ui_models.dart';
import 'explore_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  final _sections = const [
    HomeSectionItem(
      label: 'Course Section',
      backgroundColor: Color(0xFF8FEDDD),
      borderColor: Color(0xFF4FC7B5),
      icon: Icons.smartphone_rounded,
      iconColor: Color(0xFF2E7D6E),
      sectionType: SectionType.course,
    ),
    HomeSectionItem(
      label: 'Exam Section',
      backgroundColor: Color(0xFFDDF0A0),
      borderColor: Color(0xFFB8D95E),
      icon: Icons.edit_note_rounded,
      iconColor: Color(0xFF6B8A2A),
      sectionType: SectionType.exam,
    ),
    HomeSectionItem(
      label: 'e-Book Section',
      backgroundColor: Color(0xFFFADFA0),
      borderColor: Color(0xFFE8B85E),
      icon: Icons.menu_book_rounded,
      iconColor: Color(0xFF9A6A1E),
      sectionType: SectionType.ebook,
    ),
    HomeSectionItem(
      label: 'Video Section',
      backgroundColor: Color(0xFFA8D4F5),
      borderColor: Color(0xFF6FADE0),
      icon: Icons.ondemand_video_rounded,
      iconColor: Color(0xFF2D6294),
      sectionType: SectionType.video,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              sliver: SliverToBoxAdapter(child: _buildSectionGrid()),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 20),
              sliver: SliverToBoxAdapter(child: _buildPhotoCarousel()),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              sliver: SliverToBoxAdapter(
                child: _CtaBanner(
                  title: 'Are you looking\nfor new job?',
                  buttonLabel: 'Search Job',
                  buttonColor: const Color(0xFF3D5CFF),
                  backgroundColor: const Color(0xFFFBD9E6),
                  icon: Icons.work_outline_rounded,
                  onTap: () {},
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
              sliver: SliverToBoxAdapter(
                child: _CtaBanner(
                  title: 'Want to learn new topic\nabout subject?',
                  buttonLabel: 'Join Community',
                  buttonColor: const Color(0xFF9B3DFF),
                  backgroundColor: const Color(0xFFCDF2C6),
                  icon: Icons.groups_rounded,
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: [
          IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFF1B1D28)),
              onPressed: () {}),
          Expanded(
            child: Text('Edu Care',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1B1D28))),
          ),
          IconButton(
            icon: const Icon(Icons.history_rounded, color: Color(0xFF1B1D28)),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const HistoryScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF1B1D28)),
            onPressed: () => _openSearch(),
          ),
        ],
      ),
    );
  }

  void _openSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SearchScreen()),
    );
  }

  Widget _buildSectionGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _sections.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, index) {
        final section = _sections[index];
        return _SectionCard(
          item: section,
          onTap: () => _openExplore(section),
        );
      },
    );
  }

  void _openExplore(HomeSectionItem section) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExploreScreen(
          title: section.label,
          sectionType: section.sectionType,
        ),
      ),
    );
  }

  Widget _buildPhotoCarousel() {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return Container(
            width: 260,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.grey.shade300,
              image: DecorationImage(
                image: NetworkImage(
                  'https://picsum.photos/seed/edu$index/400/300',
                ),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _navIndex,
      onTap: (i) => setState(() => _navIndex = i),
      selectedItemColor: const Color(0xFF3D5CFF),
      unselectedItemColor: const Color(0xFF9A9DAE),
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded), label: 'Notice'),
        BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline_rounded), label: 'Video'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded), label: 'About'),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final HomeSectionItem item;
  final VoidCallback onTap;
  const _SectionCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: item.backgroundColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: item.borderColor, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Icon(item.icon, size: 56, color: item.iconColor),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item.label,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1B1D28),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CtaBanner extends StatelessWidget {
  final String title;
  final String buttonLabel;
  final Color buttonColor;
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onTap;

  const _CtaBanner({
    required this.title,
    required this.buttonLabel,
    required this.buttonColor,
    required this.backgroundColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1B1D28),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    buttonLabel,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Icon(icon, size: 64, color: buttonColor.withOpacity(0.4)),
        ],
      ),
    );
  }
}
