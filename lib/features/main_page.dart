import '../core/core.dart';

class MainPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(CupertinoIcons.uiwindow_split_2x1, size: kSizeXL),
            label: 'Buat pesanan',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(CupertinoIcons.paperplane, size: kSizeXL)),
            label: 'Pesanan saya',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.profile_circled, size: kSizeL),
            label: 'Profil',
          ),
        ],
        onDestinationSelected: (value) {
          navigationShell.goBranch(value);
        },
        selectedIndex: navigationShell.currentIndex,
      ),
      body: navigationShell,
    );
  }
}
