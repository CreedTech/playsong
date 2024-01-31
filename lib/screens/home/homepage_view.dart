import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playsong/custom_widgets/collage.dart';
import 'package:playsong/custom_widgets/image_card.dart';
import 'package:playsong/custom_widgets/on_hover.dart';
import 'package:playsong/helpers/extensions.dart';
import 'package:playsong/theme/app_theme.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../custom_widgets/custom_physics.dart';
import '../../custom_widgets/horizontal_album_list_separated.dart';
import '../../custom_widgets/like_button.dart';
import '../../custom_widgets/song_tile_trailing_menu.dart';
import '../../models/image_quality.dart';
import '../../services/player_service.dart';

bool fetched = false;
List preferredLanguage = Hive.box('settings')
    .get('preferredLanguage', defaultValue: ['English']) as List;
List likedRadio =
    Hive.box('settings').get('likedRadio', defaultValue: []) as List;
Map data = Hive.box('cache').get('homepage', defaultValue: {}) as Map;
List lists = [
  'recent',
  'Play Mixes for you',
  'Upcoming Artists Shots',
  'Top 10/100 Songs'
];

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  static List<Tab> tabs = <Tab>[
    Tab(
      child: SizedBox(
        width: 60,
        height: 29,
        child: Center(
          child: Text(
            "All",
            textAlign: TextAlign.center,
            style: GoogleFonts.hind(
              // color: colorBlack,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
    Tab(
      child: SizedBox(
        width: 60,
        height: 29,
        child: Center(
          child: Text(
            "Gospel",
            textAlign: TextAlign.center,
            style: GoogleFonts.hind(
              // color: colorWhite,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
    Tab(
      child: SizedBox(
        width: 60,
        height: 29,
        child: Center(
          child: Text(
            "Hip-Hop",
            textAlign: TextAlign.center,
            style: GoogleFonts.hind(
              // color: colorWhite,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
    Tab(
      child: SizedBox(
        width: 60,
        height: 29,
        child: Center(
          child: Text(
            "Caribbean",
            textAlign: TextAlign.center,
            style: GoogleFonts.hind(
              // color: colorWhite,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
    Tab(
      child: SizedBox(
        width: 60,
        height: 29,
        child: Center(
          child: Text(
            "Latin",
            textAlign: TextAlign.center,
            style: GoogleFonts.hind(
              // color: colorWhite,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image.asset(
                'assets/images/playsong_logo.png',
                width: 64,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                'PlaySong',
                style: GoogleFonts.hind(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    1000.0,
                  ),
                ),
                color: Colors.black54,
                child: Image.asset(
                  'assets/images/lady_image.png',
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                indicatorPadding: const EdgeInsets.symmetric(vertical: 3),

                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0), // Border radius
                  color: colorPrimary,
                ),
                padding: EdgeInsets.zero,
                labelStyle: GoogleFonts.hind(
                  color: colorBlack,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                labelPadding: EdgeInsets.zero,
                unselectedLabelColor: Colors.white,
                unselectedLabelStyle: GoogleFonts.hind(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                // labelColor: colorPrimary,
                tabs: tabs,
                // isScrollable: true,
              ),
              const Expanded(
                child: TabBarView(children: [
                  HomeTabs(),
                  HomeTabs(),
                  HomeTabs(),
                  HomeTabs(),
                  HomeTabs(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeTabs extends StatefulWidget {
  const HomeTabs({super.key});

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs>
    with AutomaticKeepAliveClientMixin<HomeTabs> {
  List recentList =
      Hive.box('cache').get('recentSongs', defaultValue: []) as List;
  Map likedArtists =
      Hive.box('settings').get('likedArtists', defaultValue: {}) as Map;
  List blacklistedHomeSections = Hive.box('settings')
      .get('blacklistedHomeSections', defaultValue: []) as List;
  List playlistNames =
      Hive.box('settings').get('playlistNames')?.toList() as List? ??
          ['Favorite Songs'];
  Map playlistDetails =
      Hive.box('settings').get('playlistDetails', defaultValue: {}) as Map;

  int recentIndex = 0;
  int playlistIndex = 1;
  int isSelected = 1;

  int likedCount() {
    return Hive.box('Favorite Songs').length;
  }

  @override
  void initState() {
    super.initState();
    lists.insert((lists.length / 3).round(), 'customisedPicks');
  }

  // final sectionList = [
  //   'Play Mixes for you',
  //   'Upcoming Artists Shots',
  //   'Top 10/100 Songs'
  // ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    double sessionboxSize =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.height / 2.5;
    if (sessionboxSize > 250) sessionboxSize = 250;
    double boxSize =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.height / 2.5;
    if (boxSize > 250) boxSize = 250;
    recentIndex = 0;
    isSelected = 1;
    //   if (playlistNames.length >= 3) {
    //   recentIndex = 0;
    //   isSelected = 1;
    // } else {
    //   recentIndex = 1;
    //   playlistIndex = 0;
    // }

    return (lists.isEmpty && recentList.isEmpty)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 0),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              itemCount: lists.length,
              itemBuilder: (context, idx) {
                if (idx == recentIndex) {
                  return ValueListenableBuilder(
                    valueListenable: Hive.box('settings').listenable(),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/recent');
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 0, 5),
                                child: Text(
                                  AppLocalizations.of(context)!.lastSession,
                                  style: GoogleFonts.hind(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis
                                  .vertical, // Vertical scroll for the outer list
                              itemCount: 2,
                              itemBuilder: (context, rowIndex) {
                                final startIndex = rowIndex * 6;
                                final endIndex = (rowIndex + 1) * 6;
                                final items = [
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                ].sublist(startIndex, endIndex);
                                return SizedBox(
                                  height: 170,
                                  child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      itemCount: items.length,
                                      itemBuilder: (context, index) {
                                        // Map item;
                                        // item = data[lists[1]][index] as Map;
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              child: SizedBox(
                                                width: 120,
                                                height: 115,
                                                child: imageCard(
                                                  margin: const EdgeInsets.only(
                                                      right: 8),
                                                  borderRadius: 2.4,
                                                  imageUrl:
                                                      'assets/images/music_wall.png',
                                                  imageQuality:
                                                      ImageQuality.medium,
                                                  placeholderImage:
                                                      const AssetImage(
                                                    'assets/images/music_wall.png',
                                                  ),
                                                ),
                                                // HoverBox(
                                                //     child: imageCard(
                                                //       margin:
                                                //           const EdgeInsets.all(4.0),
                                                //       borderRadius: 2.4,
                                                //       imageUrl:
                                                //           'assets/images/music_wall.png',
                                                //       imageQuality:
                                                //           ImageQuality.medium,
                                                //       placeholderImage:
                                                //           const AssetImage(
                                                //         'assets/images/music_wall.png',
                                                //       ),
                                                //     ),
                                                //     builder: ({
                                                //       required BuildContext context,
                                                //       required bool isHover,
                                                //       Widget? child,
                                                //     }) {
                                                //       return Card(
                                                //         color: isHover
                                                //             ? null
                                                //             : Colors.transparent,
                                                //         elevation: 0,
                                                //         margin: EdgeInsets.zero,
                                                //         shape:
                                                //             RoundedRectangleBorder(
                                                //           borderRadius:
                                                //               BorderRadius.circular(
                                                //             2.4,
                                                //           ),
                                                //         ),
                                                //         clipBehavior:
                                                //             Clip.antiAlias,
                                                //         child: Column(
                                                //           children: [
                                                //             Stack(
                                                //               children: [
                                                //                 SizedBox.square(
                                                //                   dimension: isHover
                                                //                       ? boxSize - 25
                                                //                       : 100,
                                                //                   child: child,
                                                //                 ),
                                                //                 if (isHover)
                                                //                   Positioned.fill(
                                                //                     child:
                                                //                         Container(
                                                //                       margin:
                                                //                           const EdgeInsets
                                                //                               .all(
                                                //                         4.0,
                                                //                       ),
                                                //                       decoration:
                                                //                           BoxDecoration(
                                                //                         color: Colors
                                                //                             .black54,
                                                //                         borderRadius:
                                                //                             BorderRadius
                                                //                                 .circular(
                                                //                           10.0,
                                                //                         ),
                                                //                       ),
                                                //                       child: Center(
                                                //                         child:
                                                //                             DecoratedBox(
                                                //                           decoration:
                                                //                               BoxDecoration(
                                                //                             color: Colors
                                                //                                 .black87,
                                                //                             borderRadius:
                                                //                                 BorderRadius.circular(
                                                //                               1000.0,
                                                //                             ),
                                                //                           ),
                                                //                           child:
                                                //                               const Icon(
                                                //                             Icons
                                                //                                 .play_arrow_rounded,
                                                //                             size:
                                                //                                 50.0,
                                                //                             color: Colors
                                                //                                 .white,
                                                //                           ),
                                                //                         ),
                                                //                       ),
                                                //                     ),
                                                //                   ),

                                                //               ],
                                                //             ),
                                                //             Padding(
                                                //               padding:
                                                //                   const EdgeInsets
                                                //                       .symmetric(
                                                //                 horizontal: 10.0,
                                                //               ),
                                                //               child: Column(
                                                //                 mainAxisAlignment:
                                                //                     MainAxisAlignment
                                                //                         .start,
                                                //                 crossAxisAlignment:
                                                //                     CrossAxisAlignment
                                                //                         .start,
                                                //                 children: [
                                                //                   Padding(
                                                //                     padding:
                                                //                         const EdgeInsets
                                                //                             .only(
                                                //                             right:
                                                //                                 10),
                                                //                     child: Text(
                                                //                       'Girlfriend (feat Chris & Toks)',
                                                //                       textAlign:
                                                //                           TextAlign
                                                //                               .left,
                                                //                       softWrap:
                                                //                           false,
                                                //                       maxLines: 2,
                                                //                       overflow:
                                                //                           TextOverflow
                                                //                               .ellipsis,
                                                //                       style:
                                                //                           GoogleFonts
                                                //                               .hind(
                                                //                         fontWeight:
                                                //                             FontWeight
                                                //                                 .w500,
                                                //                       ),
                                                //                     ),
                                                //                   ),
                                                //                 ],
                                                //               ),
                                                //             ),
                                                //           ],
                                                //         ),
                                                //       );
                                                //     }),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 0.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: SizedBox(
                                                      width: 100,
                                                      child: Text(
                                                        'Girlfriend (feat Chris & Toks)',
                                                        textAlign:
                                                            TextAlign.left,
                                                        softWrap: false,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: GoogleFonts.hind(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                );
                              }),
                        ),
                        HorizontalAlbumsListSeparated(
                          songsList: recentList,
                          onTap: (int idx) {
                            PlayerInvoke.init(
                              songsList: [recentList[idx]],
                              index: 0,
                              isOffline: false,
                            );
                          },
                        ),
                      ],
                    ),
                    builder: (BuildContext context, Box box, Widget? child) {
                      return (recentList.isNotEmpty ||
                              !(box.get('showRecent', defaultValue: true)
                                  as bool))
                          ? const SizedBox()
                          : child!;
                    },
                  );
                }
                if (lists[idx] == 'customisedPicks') {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          15,
                          10,
                          15,
                          5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Customised Picks',
                                  style: GoogleFonts.hind(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                            Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 3.0,
                                vertical: 3.0,
                              ),
                              color: colorButton,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 4),
                                child: Text(
                                  'SEE ALL',
                                  style: GoogleFonts.hind(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: (boxSize + 65),
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis
                                .vertical, // Vertical scroll for the outer list
                            itemCount: 4,
                            itemBuilder: (context, rowIndex) {
                              final startIndex = rowIndex * 6;
                              final endIndex = (rowIndex + 1) * 6;
                              final items = [
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                              ].sublist(startIndex, endIndex);
                              return SizedBox(
                                height: 62,
                                child: ListView.builder(
                                    physics: PagingScrollPhysics(
                                        itemDimension:
                                            MediaQuery.of(context).size.width *
                                                0.875),
                                    scrollDirection: Axis.horizontal,
                                    itemExtent:
                                        MediaQuery.of(context).size.width *
                                            0.875,
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      // Map item;
                                      // item = data[lists[1]][index] as Map;
                                      return ListTile(
                                        dense: false,
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/player');
                                        },
                                        title: Text(
                                          'Girlfriend (feat Chris & Toks)',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.hind(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        subtitle: Text(
                                          'Jam Record',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.hind(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        leading: Hero(
                                          tag: 'currentArtwork',
                                          child: imageCard(
                                            elevation: 8,
                                            boxDimension: 50.0,
                                            localImage: true,
                                            imageUrl:
                                                'assets/images/customised.png',
                                            imageQuality: ImageQuality.medium,
                                            placeholderImage: const AssetImage(
                                              'assets/images/customised.png',
                                            ),
                                          ),
                                        ),
                                        trailing: PopupMenuButton(
                                          icon: Icon(
                                            Icons.more_vert_rounded,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            size: 15,
                                            weight: 3,
                                          ),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                          ),
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: 6,
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.delete_rounded,
                                                  ),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!
                                                        .remove,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 2,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.playlist_play_rounded,
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color,
                                                    size: 26.0,
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                  Text(AppLocalizations.of(
                                                          context)!
                                                      .playNext),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 1,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.queue_music_rounded,
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color,
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                  Text(AppLocalizations.of(
                                                          context)!
                                                      .addToQueue),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 0,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.playlist_add_rounded,
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color,
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                  Text(AppLocalizations.of(
                                                          context)!
                                                      .addToPlaylist),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 4,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.album_rounded,
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color,
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                  Text(AppLocalizations.of(
                                                          context)!
                                                      .viewAlbum),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 'artist',
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.person_rounded,
                                                      color: Theme.of(context)
                                                          .iconTheme
                                                          .color,
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                    Text(
                                                      '${AppLocalizations.of(context)!.viewArtist} Test',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 3,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.share_rounded,
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color,
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                  Text(AppLocalizations.of(
                                                          context)!
                                                      .share),
                                                ],
                                              ),
                                            ),
                                          ],
                                          onSelected: (value) {
                                            switch (value) {
                                              case 3:
                                                Share.share('');
                                                break;

                                              case 4:
                                                // TODO come back here!!!
                                                // Navigator.push(
                                                //   context,
                                                //   PageRouteBuilder(
                                                //     opaque: false,
                                                //     pageBuilder: (_, __, ___) => SongsListPage(
                                                //       listItem: {
                                                //         'type': 'album',
                                                //         'id': mediaItem.extras?['album_id'],
                                                //         'title': mediaItem.album,
                                                //         'image': mediaItem.artUri,
                                                //       },
                                                //     ),
                                                //   ),
                                                // );
                                                break;
                                              case 6:
                                                '';
                                                break;
                                              case 0:
                                                '';
                                                break;
                                              case 1:
                                                '';
                                                break;
                                              case 2:
                                                '';
                                                break;
                                              default:
                                                // TODO come back here!!!
                                                // Navigator.push(
                                                //   context,
                                                //   PageRouteBuilder(
                                                //     opaque: false,
                                                //     pageBuilder: (_, __, ___) => AlbumSearchPage(
                                                //       query: value.toString(),
                                                //       type: 'Artists',
                                                //     ),
                                                //   ),
                                                // );
                                                break;
                                            }
                                          },
                                        ),
                                      );
                                    }),
                              );
                            }),
                      ),
                    ]),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          15,
                          10,
                          15,
                          5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  lists[idx],
                                  style: GoogleFonts.hind(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                            Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 3.0,
                                vertical: 3.0,
                              ),
                              color: colorButton,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 4),
                                child: Text(
                                  'SEE ALL',
                                  style: GoogleFonts.hind(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: (boxSize + 15) * 2,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis
                                .vertical, // Vertical scroll for the outer list
                            itemCount: 2,
                            itemBuilder: (context, rowIndex) {
                              final startIndex = rowIndex * 6;
                              final endIndex = (rowIndex + 1) * 6;
                              final items = [
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                              ].sublist(startIndex, endIndex);
                              return SizedBox(
                                height: boxSize + 40,
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      // Map item;
                                      // item = data[lists[1]][index] as Map;
                                      return GestureDetector(
                                        child: SizedBox(
                                          width: boxSize - 20,
                                          child: HoverBox(
                                              child: (lists[idx] ==
                                                      'Top 10/100 Songs')
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        // color: isHover
                                                        //     ? null
                                                        //     : Colors
                                                        //         .transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2.4),
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Positioned.fill(
                                                            child: imageCard(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          4,
                                                                      vertical:
                                                                          4.0),
                                                              borderRadius: 2.4,
                                                              imageUrl:
                                                                  'assets/images/mixes.png',
                                                              imageQuality:
                                                                  ImageQuality
                                                                      .medium,
                                                              placeholderImage:
                                                                  const AssetImage(
                                                                'assets/images/top_song.png',
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              vertical: 13,
                                                              horizontal: 10,
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Top 100 ',
                                                                      style: GoogleFonts.hind(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                    const Image(
                                                                      image: AssetImage(
                                                                          'assets/icons/staggered_menu.png'),
                                                                      width: 14,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      '2024',
                                                                      style: GoogleFonts.hind(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                    Text(
                                                                      'GLOBAL',
                                                                      style: GoogleFonts.hind(
                                                                          fontSize:
                                                                              28,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : imageCard(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4,
                                                          vertical: 4.0),
                                                      borderRadius: 2.4,
                                                      imageUrl:
                                                          'assets/images/mixes.png',
                                                      imageQuality:
                                                          ImageQuality.medium,
                                                      placeholderImage: (lists[
                                                                  idx] ==
                                                              'Play Mixes for you')
                                                          ? const AssetImage(
                                                              'assets/images/mixes.png',
                                                            )
                                                          : lists[idx] ==
                                                                  'Upcoming Artists Shots'
                                                              ? const AssetImage(
                                                                  'assets/images/upcoming.png',
                                                                )
                                                              : lists[idx] ==
                                                                      'Top 10/100 Songs'
                                                                  ? const AssetImage(
                                                                      'assets/artist.png',
                                                                    )
                                                                  : const AssetImage(
                                                                      'assets/artist.png',
                                                                    ),
                                                    ),
                                              builder: ({
                                                required BuildContext context,
                                                required bool isHover,
                                                Widget? child,
                                              }) {
                                                return Card(
                                                  color: isHover
                                                      ? null
                                                      : Colors.transparent,
                                                  elevation: 0,
                                                  margin: EdgeInsets.zero,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      2.4,
                                                    ),
                                                  ),
                                                  clipBehavior: Clip.antiAlias,
                                                  child: Column(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          SizedBox.square(
                                                            dimension: isHover
                                                                ? boxSize - 25
                                                                : boxSize - 30,
                                                            child: child,
                                                          ),
                                                          if (isHover)
                                                            Positioned.fill(
                                                              child: Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(
                                                                  4.0,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .black54,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    10.0,
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                  child:
                                                                      DecoratedBox(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .black87,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        1000.0,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .play_arrow_rounded,
                                                                      size:
                                                                          50.0,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 0.0,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                right: 10,
                                                              ),
                                                              child: Text(
                                                                'Spirit Room Mix',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                softWrap: false,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    GoogleFonts
                                                                        .hind(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Skuliju, Adebayo, Manley Stanley, Steph Greatins',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              softWrap: true,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts
                                                                  .hind(
                                                                fontSize: 11,
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .color,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      );
                                    }),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
