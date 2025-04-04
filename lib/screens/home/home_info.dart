import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playsong/apis/api.dart';
import 'package:playsong/custom_widgets/horizontal_albumlist.dart';
import 'package:playsong/helpers/extensions.dart';
import 'package:playsong/theme/app_theme.dart';

import '../../custom_widgets/collage.dart';
import '../../custom_widgets/horizontal_album_list_separated.dart';
import '../../custom_widgets/image_card.dart';
import '../../custom_widgets/like_button.dart';
import '../../custom_widgets/on_hover.dart';
import '../../custom_widgets/snackbar.dart';
import '../../custom_widgets/song_tile_trailing_menu.dart';
import '../../helpers/format.dart';
import '../../models/image_quality.dart';
import '../../services/player_service.dart';

bool fetched = false;
List preferredLanguage = Hive.box('settings')
    .get('preferredLanguage', defaultValue: ['English']) as List;
List likedRadio =
    Hive.box('settings').get('likedRadio', defaultValue: []) as List;
Map data = Hive.box('cache').get('homepage', defaultValue: {}) as Map;
List lists = ['recent', 'playlist', ...?data['collections'] as List?];

class HomeInfo extends StatefulWidget {
  const HomeInfo({super.key});

  @override
  State<HomeInfo> createState() => _HomeInfoState();
}

class _HomeInfoState extends State<HomeInfo>
    with AutomaticKeepAliveClientMixin<HomeInfo> {
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

  Future<void> getHomePageData() async {
    Map recievedData = await PlaySongAPI().fetchHomePageData();
    if (recievedData.isNotEmpty) {
      Hive.box('cache').put('homepage', recievedData);
      data = recievedData;
      lists = ['recent', 'playlist', ...?data['collections'] as List?];
      lists.insert((lists.length / 2).round(), 'likedArtists');
    }
    setState(() {});
    recievedData = await FormatResponse.formatPromoLists(data);
    if (recievedData.isNotEmpty) {
      Hive.box('cache').put('homepage', recievedData);
      data = recievedData;
      lists = ['recent', 'playlist', ...?data['collections'] as List?];
      lists.insert((lists.length / 2).round(), 'likedArtists');
    }
    setState(() {});
  }

  String getSubTitle(Map item) {
    final type = item['type'];
    switch (type) {
      case 'charts':
        return '';
      case 'radio_station':
        return 'Radio • ${(item['subtitle']?.toString() ?? '').isEmpty ? 'JioSaavn' : item['subtitle']?.toString().unescape()}';
      case 'playlist':
        return 'Playlist • ${(item['subtitle']?.toString() ?? '').isEmpty ? 'JioSaavn' : item['subtitle'].toString().unescape()}';
      case 'song':
        return 'Single • ${item['artist']?.toString().unescape()}';
      case 'mix':
        return 'Mix • ${(item['subtitle']?.toString() ?? '').isEmpty ? 'JioSaavn' : item['subtitle'].toString().unescape()}';
      case 'show':
        return 'Podcast • ${(item['subtitle']?.toString() ?? '').isEmpty ? 'JioSaavn' : item['subtitle'].toString().unescape()}';
      case 'album':
        final artists = item['more_info']?['artistMap']?['artists']
            .map((artist) => artist['name'])
            .toList();
        if (artists != null) {
          return 'Album • ${artists?.join(', ')?.toString().unescape()}';
        } else if (item['subtitle'] != null && item['subtitle'] != '') {
          return 'Album • ${item['subtitle']?.toString().unescape()}';
        }
        return 'Album';
      default:
        final artists = item['more_info']?['artistMap']?['artists']
            .map((artist) => artist['name'])
            .toList();
        return artists?.join(', ')?.toString().unescape() ?? '';
    }
  }

  int likedCount() {
    return Hive.box('Favorite Songs').length;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!fetched) {
      getHomePageData();
      fetched = true;
    }
    double boxSize =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.height / 2.5;
    if (boxSize > 250) boxSize = 250;
    if (playlistNames.length >= 3) {
      recentIndex = 0;
      playlistIndex = 1;
    } else {
      recentIndex = 1;
      playlistIndex = 0;
    }

    return (data.isEmpty && recentList.isEmpty)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            itemCount: data.isEmpty ? 2 : lists.length,
            itemBuilder: (context, idx) {
              if (idx == recentIndex) {
                return ValueListenableBuilder(
                  valueListenable: Hive.box('settings').listenable(),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
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
                        onTap: () {
                          Navigator.pushNamed(context, '/recent');
                        },
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
                    return (recentList.isEmpty ||
                            !(box.get('showRecent', defaultValue: true)
                                as bool))
                        ? const SizedBox()
                        : child!;
                  },
                );
              }
              if (idx == playlistIndex) {
                return ValueListenableBuilder(
                  valueListenable: Hive.box('settings').listenable(),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                              child: Text(
                                AppLocalizations.of(context)!.yourPlaylists,
                                style: GoogleFonts.hind(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/playlists');
                        },
                      ),
                      SizedBox(
                        height: boxSize + 15,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: playlistNames.length,
                          itemBuilder: (context, index) {
                            final String name = playlistNames[index].toString();
                            final String showName = playlistDetails
                                    .containsKey(name)
                                ? playlistDetails[name]['name']?.toString() ??
                                    name
                                : name;
                            final String? subtitle = playlistDetails[name] ==
                                        null ||
                                    playlistDetails[name]['count'] == null ||
                                    playlistDetails[name]['count'] == 0
                                ? null
                                : '${playlistDetails[name]['count']} ${AppLocalizations.of(context)!.songs}';
                            if (playlistDetails[name] == null ||
                                playlistDetails[name]['count'] == null ||
                                playlistDetails[name]['count'] == 0) {
                              return const SizedBox();
                            }
                            return GestureDetector(
                              child: SizedBox(
                                width: boxSize - 20,
                                child: HoverBox(
                                  child: Collage(
                                    borderRadius: 10.0,
                                    imageList: playlistDetails[name]
                                        ['imagesList'] as List,
                                    showGrid: true,
                                    placeholderImage: 'assets/cover.jpg',
                                  ),
                                  builder: ({
                                    required BuildContext context,
                                    required bool isHover,
                                    Widget? child,
                                  }) {
                                    return Card(
                                      color:
                                          isHover ? null : Colors.transparent,
                                      elevation: 0,
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Column(
                                        children: [
                                          SizedBox.square(
                                            dimension: isHover
                                                ? boxSize - 25
                                                : boxSize - 30,
                                            child: child,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  showName,
                                                  textAlign: TextAlign.center,
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.hind(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                if (subtitle != null &&
                                                    subtitle.isNotEmpty)
                                                  Text(
                                                    subtitle,
                                                    textAlign: TextAlign.center,
                                                    softWrap: false,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.hind(
                                                      fontSize: 11,
                                                      color: Theme.of(context)
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
                                  },
                                ),
                              ),
                              onTap: () async {
                                // await Hive.openBox(name);
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => LikedSongs(
                                //       playlistName: name,
                                //       showName:
                                //           playlistDetails.containsKey(name)
                                //               ? playlistDetails[name]['name']
                                //                       ?.toString() ??
                                //                   name
                                //               : name,
                                //     ),
                                //   ),
                                // );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  builder: (BuildContext context, Box box, Widget? child) {
                    return (playlistNames.isEmpty ||
                            !(box.get('showPlaylist', defaultValue: true)
                                as bool) ||
                            (playlistNames.length == 1 &&
                                playlistNames.first == 'Favorite Songs' &&
                                likedCount() == 0))
                        ? const SizedBox()
                        : child!;
                  },
                );
              }
              if (lists[idx] == 'likedArtists') {
                final List likedArtistsList = likedArtists.values.toList();
                return likedArtists.isEmpty
                    ? const SizedBox()
                    : Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 0, 5),
                                child: Text(
                                  'Liked Artists',
                                  style: GoogleFonts.hind(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          HorizontalAlbumsList(
                            songsList: likedArtistsList,
                            onTap: (int idx) {
                              // Navigator.push(
                              //   context,
                              //   PageRouteBuilder(
                              //     opaque: false,
                              //     pageBuilder: (_, __, ___) => ArtistSearchPage(
                              //       data: likedArtistsList[idx] as Map,
                              //     ),
                              //   ),
                              // );
                            },
                          ),
                        ],
                      );
              }
              return (data[lists[idx]] == null ||
                      blacklistedHomeSections.contains(
                        data['modules'][lists[idx]]?['title']
                            ?.toString()
                            .toLowerCase(),
                      ))
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    data['modules'][lists[idx]]?['title']
                                            ?.toString()
                                            .unescape() ??
                                        '',
                                    style: GoogleFonts.hind(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.block_rounded,
                                      color: Theme.of(context).disabledColor,
                                      size: 18,
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            title: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!
                                                  .blacklistedHomeSections,
                                            ),
                                            content: const Text(
                                              'Are you sure you want to blacklist this section? Once blacklisted, it won\'t be shown on home screen',
                                            ),
                                            actions: [
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  foregroundColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!
                                                      .no,
                                                ),
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                ),
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  blacklistedHomeSections.add(
                                                    data['modules'][lists[idx]]
                                                            ?['title']
                                                        ?.toString()
                                                        .toLowerCase(),
                                                  );
                                                  Hive.box('settings').put(
                                                    'blacklistedHomeSections',
                                                    blacklistedHomeSections,
                                                  );
                                                  setState(() {});
                                                },
                                                child: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!
                                                      .yes,
                                                  style: GoogleFonts.hind(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 2.0,
                                  vertical: 1.0,
                                ),
                                color: colorButton,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7),
                                  child: Text(
                                    'SEE ALL',
                                    style: GoogleFonts.hind(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: boxSize + 15,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            itemCount: data['modules'][lists[idx]]?['title']
                                        ?.toString() ==
                                    'Radio Stations'
                                ? (data[lists[idx]] as List).length +
                                    likedRadio.length
                                : (data[lists[idx]] as List).length,
                            itemBuilder: (context, index) {
                              Map item;
                              if (data['modules'][lists[idx]]?['title']
                                      ?.toString() ==
                                  'Radio Stations') {
                                index < likedRadio.length
                                    ? item = likedRadio[index] as Map
                                    : item = data[lists[idx]]
                                        [index - likedRadio.length] as Map;
                              } else {
                                item = data[lists[idx]][index] as Map;
                              }
                              final currentSongList = data[lists[idx]]
                                  .where((e) => e['type'] == 'song')
                                  .toList();
                              final subTitle = getSubTitle(item);
                              item['subTitle'] = subTitle;
                              if (item.isEmpty) return const SizedBox();
                              return GestureDetector(
                                onLongPress: () {
                                  Feedback.forLongPress(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return InteractiveViewer(
                                        child: Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                            ),
                                            AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                              contentPadding: EdgeInsets.zero,
                                              content: imageCard(
                                                borderRadius: item['type'] ==
                                                        'radio_station'
                                                    ? 1000.0
                                                    : 15.0,
                                                imageUrl:
                                                    item['image'].toString(),
                                                imageQuality: ImageQuality.high,
                                                boxDimension:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.8,
                                                placeholderImage: (item[
                                                                'type'] ==
                                                            'playlist' ||
                                                        item['type'] == 'album')
                                                    ? const AssetImage(
                                                        'assets/album.png',
                                                      )
                                                    : item['type'] == 'artist'
                                                        ? const AssetImage(
                                                            'assets/artist.png',
                                                          )
                                                        : const AssetImage(
                                                            'assets/cover.jpg',
                                                          ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                onTap: () {
                                  if (item['type'] == 'radio_station') {
                                    ShowSnackBar().showSnackBar(
                                      context,
                                      AppLocalizations.of(context)!
                                          .connectingRadio,
                                      duration: const Duration(seconds: 2),
                                    );
                                    PlaySongAPI()
                                        .createRadio(
                                      names: item['more_info']
                                                      ['featured_station_type']
                                                  .toString() ==
                                              'artist'
                                          ? [
                                              item['more_info']['query']
                                                  .toString(),
                                            ]
                                          : [item['id'].toString()],
                                      language: item['more_info']['language']
                                              ?.toString() ??
                                          'english',
                                      stationType: item['more_info']
                                              ['featured_station_type']
                                          .toString(),
                                    )
                                        .then((value) {
                                      if (value != null) {
                                        PlaySongAPI()
                                            .getRadioSongs(stationId: value)
                                            .then((value) {
                                          PlayerInvoke.init(
                                            songsList: value,
                                            index: 0,
                                            isOffline: false,
                                            shuffle: true,
                                          );
                                        });
                                      }
                                    });
                                  } else {
                                    if (item['type'] == 'song') {
                                      PlayerInvoke.init(
                                        songsList: currentSongList as List,
                                        index: currentSongList.indexWhere(
                                          (e) => e['id'] == item['id'],
                                        ),
                                        isOffline: false,
                                      );
                                    } else {
                                      // Navigator.push(
                                      //   context,
                                      //   PageRouteBuilder(
                                      //     opaque: false,
                                      //     pageBuilder: (_, __, ___) =>
                                      //         SongsListPage(
                                      //       listItem: item,
                                      //     ),
                                      //   ),
                                      // );
                                    }
                                  }
                                },
                                child: SizedBox(
                                  width: boxSize - 30,
                                  child: HoverBox(
                                    child: imageCard(
                                      margin: const EdgeInsets.all(4.0),
                                      borderRadius:
                                          item['type'] == 'radio_station'
                                              ? 1000.0
                                              : 10.0,
                                      imageUrl: item['image'].toString(),
                                      imageQuality: ImageQuality.medium,
                                      placeholderImage:
                                          (item['type'] == 'playlist' ||
                                                  item['type'] == 'album')
                                              ? const AssetImage(
                                                  'assets/album.png',
                                                )
                                              : item['type'] == 'artist'
                                                  ? const AssetImage(
                                                      'assets/artist.png',
                                                    )
                                                  : const AssetImage(
                                                      'assets/cover.jpg',
                                                    ),
                                    ),
                                    builder: ({
                                      required BuildContext context,
                                      required bool isHover,
                                      Widget? child,
                                    }) {
                                      return Card(
                                        color:
                                            isHover ? null : Colors.transparent,
                                        elevation: 0,
                                        margin: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10.0,
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
                                                if (isHover &&
                                                    (item['type'] == 'song' ||
                                                        item['type'] ==
                                                            'radio_station'))
                                                  Positioned.fill(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                        4.0,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black54,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          item['type'] ==
                                                                  'radio_station'
                                                              ? 1000.0
                                                              : 10.0,
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: DecoratedBox(
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Colors.black87,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              1000.0,
                                                            ),
                                                          ),
                                                          child: const Icon(
                                                            Icons
                                                                .play_arrow_rounded,
                                                            size: 50.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                if (item['type'] ==
                                                        'radio_station' &&
                                                    (Platform.isAndroid ||
                                                        Platform.isIOS ||
                                                        isHover))
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Card(
                                                      margin: EdgeInsets.zero,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          1000.0,
                                                        ),
                                                      ),
                                                      color: Colors.black54,
                                                      child: IconButton(
                                                        icon: likedRadio
                                                                .contains(item)
                                                            ? const Icon(
                                                                Icons
                                                                    .favorite_rounded,
                                                                color:
                                                                    Colors.red,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .favorite_border_rounded,
                                                              ),
                                                        tooltip: likedRadio
                                                                .contains(item)
                                                            ? AppLocalizations
                                                                    .of(
                                                                context,
                                                              )!
                                                                .unlike
                                                            : AppLocalizations
                                                                    .of(
                                                                context,
                                                              )!
                                                                .like,
                                                        onPressed: () {
                                                          likedRadio.contains(
                                                            item,
                                                          )
                                                              ? likedRadio
                                                                  .remove(item)
                                                              : likedRadio
                                                                  .add(item);
                                                          Hive.box('settings')
                                                              .put(
                                                            'likedRadio',
                                                            likedRadio,
                                                          );
                                                          setState(() {});
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                if (item['type'] == 'song' ||
                                                    item['duration'] != null)
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        if (isHover)
                                                          LikeButton(
                                                            mediaItem: null,
                                                            data: item,
                                                          ),
                                                        SongTileTrailingMenu(
                                                          data: item,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                              ],
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
                                                  Text(
                                                    item['title']
                                                            ?.toString()
                                                            .unescape() ??
                                                        '',
                                                    textAlign: TextAlign.left,
                                                    softWrap: false,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.hind(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  if (subTitle != '')
                                                    Text(
                                                      subTitle,
                                                      textAlign: TextAlign.left,
                                                      softWrap: false,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.hind(
                                                        fontSize: 11,
                                                        color: Theme.of(context)
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
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
            },
          );
  }
}
