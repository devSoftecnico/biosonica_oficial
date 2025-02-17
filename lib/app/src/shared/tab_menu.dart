import 'package:bot_dashboard/app/export_app.dart';

class TabMenu extends StatelessWidget {
  final ValueNotifier<int> selectedIndex;
  final Color backgroundColor;
  final List<TabItemData> items;

  const TabMenu({
    super.key,
    required this.items,
    required this.selectedIndex,
    this.backgroundColor = const Color(0xFF1F2C34),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      color: backgroundColor,
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Profile Picture
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[600],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                AppConfig().logo,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 50.0),
          // Menu Items
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: selectedIndex,
              builder: (context, currentIndex, _) {
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final isSelected = currentIndex == index;
                    return _MenuItem(
                      icon: item.icon,
                      isSelected: isSelected,
                      onTap: () => selectedIndex.value = index,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            border: isSelected
                ? Border(
                    left: BorderSide(
                      color: Colors.teal[400]!,
                      width: 3,
                    ),
                  )
                : null,
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.teal[400] : Colors.grey[600],
            size: 28,
          ),
        ),
      ),
    );
  }
}

class TabItemData {
  final IconData icon;

  const TabItemData({
    required this.icon,
  });
}
