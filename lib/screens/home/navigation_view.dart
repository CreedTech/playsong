import 'package:flutter/material.dart';
import 'package:playsong/screens/home/home.dart';

import '../../theme/app_theme.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  int _selectedIndex = 0;

  String _homeIcon = ('assets/icons/spotlight_colored.png');

  String _exploreIcon = ('assets/icons/explore_colored.png');
  String _searchIcon = ('assets/icons/search_colored.png');
  String _libraryIcon = ('assets/icons/library_colored.png');

  final String _defaultHomeIcon = ('assets/icons/spotlight.png');

  final String _defaultExploreIcon = ('assets/icons/explore.png');

  final String _defaultSearchIcon = ('assets/icons/search.png');
  final String _defaultLibraryIcon = ('assets/icons/library.png');
  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        _homeIcon = _homeIcon;
        _exploreIcon = _defaultExploreIcon;
        _searchIcon = _defaultSearchIcon;
        _libraryIcon = _defaultLibraryIcon;
      } else if (index == 1) {
        _exploreIcon = _exploreIcon;
        _libraryIcon = _defaultLibraryIcon;
        _searchIcon = _defaultSearchIcon;
        _homeIcon = _defaultHomeIcon;
      } else if (index == 2) {
        _searchIcon = _searchIcon;
        _exploreIcon = _defaultExploreIcon;
        _libraryIcon = _defaultLibraryIcon;
        _homeIcon = _defaultHomeIcon;
      } else if (index == 3) {
        _libraryIcon = _libraryIcon;
        _searchIcon = _defaultSearchIcon;
        _exploreIcon = _defaultExploreIcon;
        _homeIcon = _defaultHomeIcon;
      }

      // Update the selected index
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _buildPage(_selectedIndex),
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            selectedIconTheme: const IconThemeData(color: colorPrimary),
            selectedLabelStyle:
                const TextStyle(color: colorPrimary, fontWeight: FontWeight.w700),
            backgroundColor: Colors.white,
            showUnselectedLabels: true,
            unselectedIconTheme: const IconThemeData(
              color: Colors.white,
            ),
            unselectedItemColor: Colors.white,
            unselectedLabelStyle: const TextStyle(color: Colors.white),
            selectedItemColor: colorPrimary,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset(
                  _selectedIndex == 0 ? _homeIcon : _defaultHomeIcon,
                  width: 20,
                  color: _selectedIndex == 0 ? colorPrimary : Colors.white,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  _exploreIcon,
                  width: 20,
                  color: _selectedIndex == 1 ? colorPrimary : Colors.white,
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  _searchIcon,
                  width: 20,
                  color: _selectedIndex == 2 ? colorPrimary : Colors.white,
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  _libraryIcon,
                  width: 20,
                  color: _selectedIndex == 3 ? colorPrimary : Colors.white,
                ),
                label: 'Library',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ));
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const HomePage();
      case 2:
        return const HomePage();

      case 3:
        return const HomePage();
      default:
        return const HomePage();
    }
  }
}
