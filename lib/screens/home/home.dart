import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:playsong/screens/Explore/explore_page.dart';
import 'package:playsong/screens/Search/search_page.dart';
import 'package:playsong/screens/home/home_screen.dart';
import 'package:playsong/screens/home/homepage_view.dart';
import 'package:playsong/screens/settings/settings_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../custom_widgets/bottom_nav_bar.dart';
import '../../custom_widgets/mini_player.dart';
import '../../custom_widgets/snackbar.dart';
import '../../helpers/backup_restore.dart';
import '../../helpers/download_checker.dart';
import '../../helpers/github.dart';
import '../../helpers/route_handler.dart';
import '../../helpers/update.dart';
import '../../services/ext_storage_provider.dart';
import '../Common/routes.dart';
import '../Library/library_page.dart';
import '../Player/audioplayer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  String? appVersion;
  String name =
      Hive.box('settings').get('name', defaultValue: 'Guest') as String;
  bool checkUpdate =
      Hive.box('settings').get('checkUpdate', defaultValue: false) as bool;
  bool autoBackup =
      Hive.box('settings').get('autoBackup', defaultValue: false) as bool;
  List sectionsToShow = Hive.box('settings').get(
    'sectionsToShow',
    defaultValue: ['Spotlight', 'Explore', 'Search', 'Library'],
  ) as List;
  DateTime? backButtonPressTime;
  final bool useDense = false;

  void callback() {
    sectionsToShow = Hive.box('settings').get(
      'sectionsToShow',
      defaultValue: ['Home', 'Top Charts', 'YouTube', 'Library'],
    ) as List;
    onItemTapped(0);
    setState(() {});
  }

  void onItemTapped(int index) {
    _selectedIndex.value = index;
    _controller.jumpToTab(
      index,
    );
  }

  void checkVersion() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appVersion = packageInfo.version;

      if (checkUpdate) {
        Logger.root.info('Checking for update');
        GitHub.getLatestVersion().then((String version) async {
          if (compareVersion(
            version,
            appVersion!,
          )) {
            // List? abis =
            //     await Hive.box('settings').get('supportedAbis') as List?;

            // if (abis == null) {
            //   final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
            //   final AndroidDeviceInfo androidDeviceInfo =
            //       await deviceInfo.androidInfo;
            //   abis = androidDeviceInfo.supportedAbis;
            //   await Hive.box('settings').put('supportedAbis', abis);
            // }

            Logger.root.info('Update available');
            ShowSnackBar().showSnackBar(
              context,
              AppLocalizations.of(context)!.updateAvailable,
              duration: const Duration(seconds: 15),
              action: SnackBarAction(
                textColor: Theme.of(context).primaryColor,
                label: AppLocalizations.of(context)!.update,
                onPressed: () {
                  Navigator.pop(context);
                  launchUrl(
                    Uri.parse(''),
                    mode: LaunchMode.externalApplication,
                  );
                },
              ),
            );
          } else {
            Logger.root.info('No update available');
          }
        });
      }
      if (autoBackup) {
        final List<String> checked = [
          AppLocalizations.of(
            context,
          )!
              .settings,
          AppLocalizations.of(
            context,
          )!
              .downs,
          AppLocalizations.of(
            context,
          )!
              .playlists,
        ];
        final List playlistNames = Hive.box('settings').get(
          'playlistNames',
          defaultValue: ['Favorite Songs'],
        ) as List;
        final Map<String, List> boxNames = {
          AppLocalizations.of(
            context,
          )!
              .settings: ['settings'],
          AppLocalizations.of(
            context,
          )!
              .cache: ['cache'],
          AppLocalizations.of(
            context,
          )!
              .downs: ['downloads'],
          AppLocalizations.of(
            context,
          )!
              .playlists: playlistNames,
        };
        final String autoBackPath = Hive.box('settings').get(
          'autoBackPath',
          defaultValue: '',
        ) as String;
        if (autoBackPath == '') {
          ExtStorageProvider.getExtStorage(
            dirName: 'PlaySong/Backups',
            writeAccess: true,
          ).then((value) {
            Hive.box('settings').put('autoBackPath', value);
            createBackup(
              context,
              checked,
              boxNames,
              path: value,
              fileName: 'PlaySong_AutoBackup',
              showDialog: false,
            );
          });
        } else {
          createBackup(
            context,
            checked,
            boxNames,
            path: autoBackPath,
            fileName: 'PlaySong_AutoBackup',
            showDialog: false,
          );
        }
      }
    });
    downloadChecker();
  }

  final PageController _pageController = PageController();
  final PersistentTabController _controller = PersistentTabController();

  @override
  void initState() {
    super.initState();
    checkVersion();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool rotated = MediaQuery.of(context).size.height < screenWidth;
    final miniplayer = MiniPlayer();
    return Scaffold(
      // backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Row(
      //     children: [
      //       Image.asset(
      //         'assets/images/playsong_logo.png',
      //         width: 64,
      //       ),
      //       const SizedBox(
      //         width: 4,
      //       ),
      //        Text(
      //         'PlaySong',
      //         style: GoogleFonts.hind(
      //           fontWeight: FontWeight.w700,
      //           fontSize: 24,
      //         ),
      //       ),
      //     ],
      //   ),
      //   actions: [
      //     Container(),
      //   ],
      // ),
     
      body: Row(
        children: [
          if (rotated)
            SafeArea(
              child: ValueListenableBuilder(
                valueListenable: _selectedIndex,
                builder: (BuildContext context, int indexValue, Widget? child) {
                  return NavigationRail(
                    minWidth: 70.0,
                    groupAlignment: 0.0,
                    backgroundColor:
                        // Colors.transparent,
                        Theme.of(context).cardColor,
                    selectedIndex: indexValue,
                    onDestinationSelected: (int index) {
                      onItemTapped(index);
                    },
                    labelType: screenWidth > 1050
                        ? NavigationRailLabelType.selected
                        : NavigationRailLabelType.none,
                    selectedLabelTextStyle: GoogleFonts.hind(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelTextStyle: GoogleFonts.hind(
                      color: Theme.of(context).iconTheme.color,
                    ),
                    selectedIconTheme: Theme.of(context).iconTheme.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                    unselectedIconTheme: Theme.of(context).iconTheme,
                    useIndicator: screenWidth < 1050,
                    indicatorColor: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.2),
                    // leading: homeDrawer(
                    //   context: context,
                    //   padding: const EdgeInsets.symmetric(vertical: 5.0),
                    // ),
                    destinations: sectionsToShow.map((e) {
                      switch (e) {
                        case 'Spotlight':
                          return NavigationRailDestination(
                            icon: Icon(MdiIcons.lightbulbAlert),
                            label: Text(AppLocalizations.of(context)!.home),
                          );
                        case 'Explore':
                          return NavigationRailDestination(
                            icon: const Icon(Icons.rocket_launch_outlined),
                            label: Text(
                              AppLocalizations.of(context)!.topCharts,
                            ),
                          );
                        case 'Search':
                          return NavigationRailDestination(
                            icon: const Icon(Icons.search),
                            label: Text(AppLocalizations.of(context)!.youTube),
                          );
                        case 'Library':
                          return NavigationRailDestination(
                            icon: const Icon(Icons.my_library_music_rounded),
                            label: Text(AppLocalizations.of(context)!.library),
                          );
                        default:
                          return NavigationRailDestination(
                            icon: const Icon(Icons.settings_rounded),
                            label: Text(
                              AppLocalizations.of(context)!.settings,
                            ),
                          );
                      }
                    }).toList(),
                  );
                },
              ),
            ),
          Expanded(
            child: PersistentTabView.custom(
              context,
              controller: _controller,
              itemCount: sectionsToShow.length,
              navBarHeight: (rotated ? 55 : 55 + 70) + (useDense ? 0 : 15),
              // confineInSafeArea: false,
              onItemTapped: onItemTapped,
              routeAndNavigatorSettings: CustomWidgetRouteAndNavigatorSettings(
                routes: namedRoutes,
                onGenerateRoute: (RouteSettings settings) {
                  if (settings.name == '/player') {
                    return PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (_, __, ___) => const PlayScreen(),
                    );
                  }
                  return HandleRoute.handleRoute(settings.name);
                },
              ),
              customWidget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  miniplayer,
                  if (!rotated)
                    ValueListenableBuilder(
                      valueListenable: _selectedIndex,
                      builder: (
                        BuildContext context,
                        int indexValue,
                        Widget? child,
                      ) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          height: 60,
                          child: CustomBottomNavBar(
                            currentIndex: indexValue,
                            backgroundColor:const Color(0xff0D0D0C),
                            onTap: (index) {
                              onItemTapped(index);
                            },
                            items: _navBarItems(context),
                          ),
                        );
                      },
                    ),
                ],
              ),
              screens: sectionsToShow.map((e) {
                switch (e) {
                  case 'Spotlight':
                    // return const SafeArea(child: HomeScreen());
                    return const SafeArea(child: HomePageView());
                  case 'Explore':
                    return const SafeArea(
                      child: ExplorePage(),
                      // child: TopCharts(
                      //   pageController: _pageController,
                      // ),
                    );
                  case 'Search':
                    return const SafeArea(child: SearchPage());
                  case 'Library':
                    return const LibraryPage();
                  default:
                    return SettingsPage(callback: callback);
                }
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<CustomBottomNavBarItem> _navBarItems(BuildContext context) {
    return sectionsToShow.map((section) {
      switch (section) {
        case 'Spotlight':
          return CustomBottomNavBarItem(
            icon: Image.asset('assets/icons/spotlight.png',width: 20,),
            activeIcon: Image.asset('assets/icons/spotlight_colored.png',width: 20,),
            title: const Text('Spotlight'),
            selectedColor: Theme.of(context).primaryColor,
          );
        case 'Explore':
          return CustomBottomNavBarItem(
            icon: const Icon(Icons.rocket_launch_outlined),
            title: const Text('Explore'),
            selectedColor: Theme.of(context).primaryColor,
          );
        case 'Search':
          return CustomBottomNavBarItem(
            icon: const Icon(Icons.search),
            activeIcon: Image.asset('assets/icons/search_colored.png',width: 20,),
            title: Text(AppLocalizations.of(context)!.search),
            selectedColor: Theme.of(context).primaryColor,
          );
        case 'Library':
          return CustomBottomNavBarItem(
            icon: const Icon(Icons.my_library_music_rounded),
            title: Text(AppLocalizations.of(context)!.library),
            selectedColor: Theme.of(context).primaryColor,
          );
        default:
          return CustomBottomNavBarItem(
            icon: const Icon(Icons.settings_rounded),
            title: Text(AppLocalizations.of(context)!.settings),
            selectedColor: Theme.of(context).primaryColor,
          );
      }
    }).toList();
  }
}
