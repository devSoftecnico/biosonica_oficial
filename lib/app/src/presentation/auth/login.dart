import 'package:bot_dashboard/app/export_app.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  final PageController _pageController = PageController();

  final List<TabItemData> _menuItems = const [
    TabItemData(icon: Icons.login),
    TabItemData(icon: Icons.store),
    TabItemData(icon: Icons.policy),
    TabItemData(icon: Icons.local_police),
    TabItemData(icon: Icons.text_snippet),
    TabItemData(icon: Icons.help),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex.addListener(() {
      _pageController.jumpToPage(_selectedIndex.value);
    });
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
                  children: const [
                    LoginView(),
                    StoreView(),
                    PoliticaPrivacidadView(),
                    PoliticaDevolucionView(),
                    TerminosUsoView(),
                    HelperView(),
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
