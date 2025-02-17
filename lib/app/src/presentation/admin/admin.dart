import 'package:bot_dashboard/app/export_app.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});
  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  final PageController _pageController = PageController();
  bool _isAdmin = false;

  List<TabItemData> _menuItems = const [
    TabItemData(icon: Icons.apps),
    TabItemData(icon: Icons.store),
    TabItemData(icon: Icons.subscriptions),
    TabItemData(icon: Icons.account_box_outlined),
    TabItemData(icon: Icons.messenger_outline_outlined),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex.addListener(() {
      _pageController.jumpToPage(_selectedIndex.value);
    });
    _checkUserRole();
  }

  Future<void> _checkUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData = await UserService().getUserData(user.email!);
      if (userData != null && userData.role == 'Administrador') {
        setState(() {
          _isAdmin = true;
          _menuItems = [
            ..._menuItems,
            TabItemData(icon: Icons.settings),
          ];
        });
      }
    }
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    _selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Row(
            children: [
              // Vertical menu
              TabMenu(
                items: _menuItems,
                selectedIndex: _selectedIndex,
                backgroundColor: Colors.transparent,
              ),
              // Add a Spacer here if you want space between the menu and content
              const SizedBox(width: 20), // Example of adding space
              // Content section with PageView
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  children: [
                    AdminView(),
                    StoreView(),
                    SuscriptionView(),
                    AccountView(),
                    ChatView(),
                    if (_isAdmin) SettingView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        PlayerContent(),
      ],
    );
  }
}
