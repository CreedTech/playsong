
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../auth/get_started.dart';
import '../home/navigation_view.dart';

Widget initialFuntion() {
  // return Hive.box('settings').get('userId') != null ? HomePage() : AuthScreen();
  return Hive.box('settings').get('userId') != null
      ? NavigationView()
      : GetStarted();
}

final Map<String, Widget Function(BuildContext)> namedRoutes = {
  '/': (context) => initialFuntion(),
  '/home': (context) => const NavigationView(),
  // '/pref': (context) => const PrefScreen(),
  // '/setting': (context) => const NewSettingsPage(),
  // '/about': (context) => AboutScreen(),
  // '/playlists': (context) => PlaylistScreen(),
  // '/nowplaying': (context) => NowPlaying(),
  // '/recent': (context) => RecentlyPlayed(),
  // '/downloads': (context) => const Downloads(),
  // '/stats': (context) => const Stats(),
};
