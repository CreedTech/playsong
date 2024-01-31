import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:playsong/screens/auth/artist_selection.dart';
import 'package:playsong/screens/auth/country_selection_screen.dart';
import 'package:playsong/screens/auth/username_screen.dart';
import 'package:playsong/screens/auth/welcome.dart';
import 'package:playsong/screens/home/home.dart';
import 'package:playsong/screens/settings/settings_page.dart';

import '../auth/get_started.dart';

Widget initialFuntion() {
  // return Hive.box('settings').get('userId') != null ? HomePage() : AuthScreen();
  return Hive.box('settings').get('userId') != null ? HomePage() : GetStarted();
}

final Map<String, Widget Function(BuildContext)> namedRoutes = {
  '/': (context) => initialFuntion(),
  // '/home': (context) => const HomePage(),
  '/home': (context) => const HomePage(),
  '/welcome': (context) => const WelcomeScreen(),
  '/username': (context) => const UsernamePage(),
  '/country': (context) => const CountrySelectionPage(),
  '/select_artist': (context) => const ArtistSelectionPage(),
  // '/pref': (context) => const PrefScreen(),
  '/setting': (context) => const SettingsPage(),
  // '/about': (context) => AboutScreen(),
  // '/playlists': (context) => PlaylistScreen(),
  // '/nowplaying': (context) => NowPlaying(),
  // '/recent': (context) => RecentlyPlayed(),
  // '/downloads': (context) => const Downloads(),
  // '/stats': (context) => const Stats(),
};
