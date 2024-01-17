import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:playsong/screens/home/navigation_view.dart';
import 'package:home_widget/home_widget.dart';
import 'constants/constants.dart';
import 'helpers/config.dart';
import 'helpers/country_codes.dart';
import 'helpers/logging.dart';
import 'providers/audio_service_providers.dart';
import 'screens/auth/get_started.dart';
import 'theme/app_theme.dart';
// import 'package:receive_sharing_intent/receive_sharing_intent.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await Hive.initFlutter('PlaySong');
  } else {
    await Hive.initFlutter();
  }
  for (final box in hiveBoxes) {
    await openHiveBox(
      box['name'].toString(),
      limit: box['limit'] as bool? ?? false,
    );
  }
  // await openHiveBox('settings');
  // await openHiveBox('downloads');
  // await openHiveBox('Favorite Songs');
  // await openHiveBox('cache', limit: true);
  if (Platform.isAndroid) {
    setOptimalDisplayMode();
  }
  await startService();
  runApp(MyApp());
}

Future<void> setOptimalDisplayMode() async {
  await FlutterDisplayMode.setHighRefreshRate();
  // final List<DisplayMode> supported = await FlutterDisplayMode.supported;
  // final DisplayMode active = await FlutterDisplayMode.active;

  // final List<DisplayMode> sameResolution = supported
  //     .where(
  //       (DisplayMode m) => m.width == active.width && m.height == active.height,
  //     )
  //     .toList()
  //   ..sort(
  //     (DisplayMode a, DisplayMode b) => b.refreshRate.compareTo(a.refreshRate),
  //   );

  // final DisplayMode mostOptimalMode =
  //     sameResolution.isNotEmpty ? sameResolution.first : active;

  // await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
}

Future<void> startService() async {
  // final AudioPlayerHandler audioHandler = await AudioService.init(
  //   builder: () => AudioPlayerHandlerImpl(),
  //   config: AudioServiceConfig(
  //     androidNotificationChannelId: 'com.example.playsong.channel.audio',
  //     androidNotificationChannelName: 'BlackHole',
  //     androidNotificationOngoing: true,
  //     androidNotificationIcon: 'drawable/ic_stat_music_note',
  //     androidShowNotificationBadge: true,
  //     // androidStopForegroundOnPause: Hive.box('settings')
  //     // .get('stopServiceOnPause', defaultValue: true) as bool,
  //     notificationColor: Colors.grey[900],
  //   ),
  // );
  await initializeLogging();
  MetadataGod.initialize();
  // final audioHandlerHelper = AudioHandlerHelper();
  // final AudioPlayerHandler audioHandler =
  //     await audioHandlerHelper.getAudioHandler();
  // GetIt.I.registerSingleton<AudioPlayerHandler>(audioHandler);
  GetIt.I.registerSingleton<MyTheme>(MyTheme());
}

Future<void> openHiveBox(String boxName, {bool limit = false}) async {
  final box = await Hive.openBox(boxName).onError((error, stackTrace) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String dirPath = dir.path;
    File dbFile = File('$dirPath/$boxName.hive');
    File lockFile = File('$dirPath/$boxName.lock');
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      dbFile = File('$dirPath/PlaySong/$boxName.hive');
      lockFile = File('$dirPath/PlaySong/$boxName.lock');
    }
    await dbFile.delete();
    await lockFile.delete();
    await Hive.openBox(boxName);
    throw 'Failed to open $boxName Box\nError: $error';
  });
  // clear box if it grows large
  if (limit && box.length > 500) {
    box.clear();
  }
}

/// Called when Doing Background Work initiated from Widget
@pragma('vm:entry-point')
Future<void> backgroundCallback(Uri? data) async {
  if (data?.host == 'controls') {
    final audioHandler = await AudioHandlerHelper().getAudioHandler();
    if (data?.path == '/play') {
      audioHandler.play();
    } else if (data?.path == '/pause') {
      audioHandler.pause();
    } else if (data?.path == '/skipNext') {
      audioHandler.skipToNext();
    } else if (data?.path == '/skipPrevious') {
      audioHandler.skipToPrevious();
    }

    // await HomeWidget.saveWidgetData<String>(
    //   'title',
    //   audioHandler?.mediaItem.value?.title,
    // );
    // await HomeWidget.saveWidgetData<String>(
    //   'subtitle',
    //   audioHandler?.mediaItem.value?.displaySubtitle,
    // );
    // await HomeWidget.updateWidget(name: 'BlackHoleMusicWidget');
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', '');
  late StreamSubscription _intentTextStreamSubscription;
  late StreamSubscription _intentDataStreamSubscription;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void dispose() {
    _intentTextStreamSubscription.cancel();
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    HomeWidget.setAppGroupId('com.example.playsong');
    HomeWidget.registerInteractivityCallback(backgroundCallback);
    final String systemLangCode = Platform.localeName.substring(0, 2);
    if (ConstantCodes.languageCodes.values.contains(systemLangCode)) {
      _locale = Locale(systemLangCode);
    } else {
      final String lang =
          Hive.box('settings').get('lang', defaultValue: 'English') as String;
      _locale = Locale(ConstantCodes.languageCodes[lang] ?? 'en');
    }

    AppTheme.currentTheme.addListener(() {
      setState(() {});
    });

    //    if (Platform.isAndroid || Platform.isIOS) {
    //   // For sharing or opening urls/text coming from outside the app while the app is in the memory
    //   _intentTextStreamSubscription =
    //       ReceiveSharingIntent.getTextStream().listen(
    //     (String value) {
    //       Logger.root.info('Received intent on stream: $value');
    //       handleSharedText(value, navigatorKey);
    //     },
    //     onError: (err) {
    //       Logger.root.severe('ERROR in getTextStream', err);
    //     },
    //   );

    //   // For sharing or opening urls/text coming from outside the app while the app is closed
    //   ReceiveSharingIntent.getInitialText().then(
    //     (String? value) {
    //       Logger.root.info('Received Intent initially: $value');
    //       if (value != null) handleSharedText(value, navigatorKey);
    //     },
    //     onError: (err) {
    //       Logger.root.severe('ERROR in getInitialTextStream', err);
    //     },
    //   );

    //   // For sharing files coming from outside the app while the app is in the memory
    //   _intentDataStreamSubscription =
    //       ReceiveSharingIntent.getMediaStream().listen(
    //     (List<SharedMediaFile> value) {
    //       if (value.isNotEmpty) {
    //         for (final file in value) {
    //           if (file.path.endsWith('.json')) {
    //             final List playlistNames = Hive.box('settings')
    //                     .get('playlistNames')
    //                     ?.toList() as List? ??
    //                 ['Favorite Songs'];
    //             importFilePlaylist(
    //               null,
    //               playlistNames,
    //               path: file.path,
    //               pickFile: false,
    //             ).then(
    //               (value) => navigatorKey.currentState?.pushNamed('/playlists'),
    //             );
    //           }
    //         }
    //       }
    //     },
    //     onError: (err) {
    //       Logger.root.severe('ERROR in getDataStream', err);
    //     },
    //   );

    //   // For sharing files coming from outside the app while the app is closed
    //   ReceiveSharingIntent.getInitialMedia()
    //       .then((List<SharedMediaFile> value) {
    //     if (value.isNotEmpty) {
    //       for (final file in value) {
    //         if (file.path.endsWith('.json')) {
    //           final List playlistNames = Hive.box('settings')
    //                   .get('playlistNames')
    //                   ?.toList() as List? ??
    //               ['Favorite Songs'];
    //           importFilePlaylist(
    //             null,
    //             playlistNames,
    //             path: file.path,
    //             pickFile: false,
    //           ).then(
    //             (value) => navigatorKey.currentState?.pushNamed('/playlists'),
    //           );
    //         }
    //       }
    //     }
    //   });

    // }
  }

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  Widget initialFuntion() {
    return Hive.box('settings').get('userId') != null
        ? const NavigationView()
        : const GetStarted();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black38,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: 'PlaySong',
      restorationScopeId: 'playsong',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: AppTheme.darkTheme(
        context: context,
      ),
      darkTheme: AppTheme.darkTheme(
        context: context,
      ),
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: ConstantCodes.languageCodes.entries
          .map((languageCode) => Locale(languageCode.value, ''))
          .toList(),
      routes: {
        '/': (context) => initialFuntion(),
        '/getStarted': (context) => const GetStarted(),
        '/home': (context) => const NavigationView(),
        // '/setting': (context) => const SettingPage(),
        // '/about': (context) => AboutScreen(),
        // '/playlists': (context) => PlaylistScreen(),
        // '/nowplaying': (context) => NowPlaying(),
        // '/recent': (context) => RecentlyPlayed(),
        // '/downloads': (context) => const Downloads(),
      },
      navigatorKey: navigatorKey,
      // onGenerateRoute: (RouteSettings settings) {
      //   if (settings.name == '/player') {
      //     return PageRouteBuilder(
      //       opaque: false,
      //       pageBuilder: (_, __, ___) => const PlayScreen(),
      //     );
      //   }
      //   return HandleRoute.handleRoute(settings.name);
      // },
    );
  }
}
