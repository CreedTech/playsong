import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../screens/Player/audioplayer.dart';
import 'download_button.dart';
import 'gradient_containers.dart';
import 'image_card.dart';

class MiniPlayer extends StatefulWidget {
  static const MiniPlayer _instance = MiniPlayer._internal();

  factory MiniPlayer() {
    return _instance;
  }

  const MiniPlayer._internal();

  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  final AudioPlayerHandler audioHandler = GetIt.I<AudioPlayerHandler>();

  @override
  Widget build(BuildContext context) {
    // final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenHeight = MediaQuery.of(context).size.height;
    // final bool rotated = screenHeight < screenWidth;
    return SafeArea(
      top: false,
      child: StreamBuilder<MediaItem?>(
        stream: audioHandler.mediaItem,
        builder: (context, snapshot) {
          // if (snapshot.connectionState != ConnectionState.active) {
          //   return const SizedBox();
          // }
          final MediaItem? mediaItem = snapshot.data;
          // if (mediaItem == null) return const SizedBox();

          final List preferredMiniButtons = Hive.box('settings').get(
            'preferredMiniButtons',
            defaultValue: ['Like', 'Play/Pause', 'Next'],
          )?.toList() as List;

          final bool isLocal =
              mediaItem?.artUri?.toString().startsWith('file:') ?? false;

          return Dismissible(
            key: const Key('miniplayer'),
            direction: DismissDirection.vertical,
            confirmDismiss: (DismissDirection direction) {
              if (mediaItem != null) {
                if (direction == DismissDirection.down) {
                  audioHandler.stop();
                } else {
                  Navigator.pushNamed(context, '/player');
                }
              }
              return Future.value(false);
            },
            child: Dismissible(
              key: Key(mediaItem?.id ?? 'nothingPlaying'),
              confirmDismiss: (DismissDirection direction) {
                if (mediaItem != null) {
                  if (direction == DismissDirection.startToEnd) {
                    audioHandler.skipToPrevious();
                  } else {
                    audioHandler.skipToNext();
                  }
                }
                return Future.value(false);
              },
              child: Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 2.0,
                  vertical: 1.0,
                ),
                color: const Color(0xff141413),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                elevation: 0,
                child: SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      positionSlider(
                        mediaItem?.duration?.inSeconds.toDouble(),
                      ),
                      miniplayerTile(
                        context: context,
                        preferredMiniButtons: preferredMiniButtons,
                        // useDense: true,
                        title: mediaItem?.title ?? '',
                        subtitle: mediaItem?.artist ?? '',
                        imagePath: (isLocal
                                ? mediaItem?.artUri?.toFilePath()
                                : mediaItem?.artUri?.toString()) ??
                            '',
                        isLocalImage: isLocal,
                        isDummy: mediaItem == null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  ListTile miniplayerTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String imagePath,
    required List preferredMiniButtons,
    bool useDense = false,
    bool isLocalImage = false,
    bool isDummy = false,
  }) {
    return ListTile(
      dense: useDense,
      onTap: isDummy
          ? null
          : () {
              Navigator.pushNamed(context, '/player');
            },
      title: Text(
        isDummy ? 'Desire' : title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        isDummy ? 'TJM Moslaw' : subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: Hero(
        tag: 'currentArtwork',
        child: imageCard(
          elevation: 8,
          boxDimension: useDense ? 40.0 : 50.0,
          localImage: isLocalImage,
          imageUrl: isLocalImage ? imagePath : imagePath,
          placeholderImage: const AssetImage(
            'assets/images/music_wall.png',
          ),
        ),
      ),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: ['Like', 'Play/Pause', 'Next'].map((e) {
          switch (e) {
            case 'Like':
              return const SizedBox();
            // // !online ?
            //     // const SizedBox()
            //     // :
            //     LikeButton(
            //         mediaItem: mediaItem,
            //         size: 22.0,
            //       );
            case 'Previous':
              return StreamBuilder<QueueState>(
                stream: audioHandler.queueState,
                builder: (context, snapshot) {
                  final queueState = snapshot.data;
                  return IconButton(
                    icon: const Icon(
                      Icons.skip_previous_rounded,
                      color: Colors.white,
                    ),
                    iconSize: 30.0,
                    tooltip: AppLocalizations.of(context)!.skipPrevious,
                    color: Theme.of(context).primaryColor,
                    onPressed: queueState?.hasPrevious ?? true
                        ? audioHandler.skipToPrevious
                        : null,
                  );
                },
              );
            case 'Play/Pause':
              return SizedBox(
                height: 65.0,
                width: 65.0,
                child: StreamBuilder<PlaybackState>(
                  stream: audioHandler.playbackState,
                  builder: (context, snapshot) {
                    final playbackState = snapshot.data;
                    final processingState = playbackState?.processingState;
                    final playing = playbackState?.playing ?? true;
                    return Stack(
                      children: [
                        if (processingState == AudioProcessingState.loading ||
                            processingState == AudioProcessingState.buffering)
                          Center(
                            child: SizedBox(
                              height: 45.0,
                              width: 45.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        // if (miniplayer)
                        Center(
                          child: playing
                              ? Center(
                                  child: IconButton(
                                    // tooltip:
                                    //     AppLocalizations.of(context)!.pause,
                                    onPressed: audioHandler.pause,
                                    icon: const Icon(
                                      Icons.pause_circle_outline,
                                      size: 25,
                                    ),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              : Center(
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    tooltip: AppLocalizations.of(context)!.play,
                                    onPressed: audioHandler.play,
                                    icon: const Icon(
                                      Icons.play_circle_outline_outlined,
                                      size: 25,
                                    ),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                        )
                        // else
                        // Center(
                        //   child: SizedBox(
                        //     height: 59,
                        //     width: 59,
                        //     child: Center(
                        //       child: playing
                        //           ? FloatingActionButton(
                        //               elevation: 10,
                        //               tooltip:
                        //                   AppLocalizations.of(context)!.pause,
                        //               backgroundColor: Colors.white,
                        //               onPressed: audioHandler.pause,
                        //               child: const Icon(
                        //                 Icons.pause_rounded,
                        //                 size: 40.0,
                        //                 color: Colors.black,
                        //               ),
                        //             )
                        //           : FloatingActionButton(
                        //               elevation: 10,
                        //               tooltip:
                        //                   AppLocalizations.of(context)!.play,
                        //               backgroundColor: Colors.white,
                        //               onPressed: audioHandler.play,
                        //               child: const Icon(
                        //                 Icons.play_arrow_rounded,
                        //                 size: 40.0,
                        //                 color: Colors.black,
                        //               ),
                        //             ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    );
                  },
                ),
              );
            case 'Next':
              return StreamBuilder<QueueState>(
                stream: audioHandler.queueState,
                builder: (context, snapshot) {
                  final queueState = snapshot.data;
                  return IconButton(
                    icon: const Icon(
                      Icons.skip_next_rounded,
                      color: Colors.white,
                    ),
                    iconSize: 30.0,
                    tooltip: AppLocalizations.of(context)!.skipNext,
                    color: Theme.of(context).primaryColor,
                    onPressed: queueState?.hasNext ?? true
                        ? audioHandler.skipToNext
                        : null,
                  );
                },
              );
            case 'Download':
              return
                  // !online
                  // ?
                  const SizedBox();
            // : DownloadButton(
            //     size: 20.0,
            //     icon: 'download',
            //     data: MediaItemConverter.mediaItemToMap(mediaItem),
            //   );
            default:
              break;
          }
          return const SizedBox();
        }).toList(),
      ),
      // trailing: isDummy
      //     ? null
      //     : ControlButtons(
      //         audioHandler,
      //         miniplayer: true,
      //         buttons: isLocalImage
      //             ? ['Like', 'Play/Pause', 'Next']
      //             : preferredMiniButtons,
      //       ),
    );
  }

  StreamBuilder<Duration> positionSlider(double? maxDuration) {
    return StreamBuilder<Duration>(
      stream: AudioService.position,
      builder: (context, snapshot) {
        final position = snapshot.data;
        return ((position?.inSeconds.toDouble() ?? 0) < 0.0 ||
                ((position?.inSeconds.toDouble() ?? 0) >
                    (maxDuration ?? 180.0)))
            ? const SizedBox()
            : SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Theme.of(context).primaryColor,
                  inactiveTrackColor: Colors.transparent,
                  trackHeight: 0.5,
                  thumbColor: Theme.of(context).primaryColor,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 1.0,
                  ),
                  overlayColor: Colors.transparent,
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 2.0,
                  ),
                ),
                child: Center(
                  child: Slider(
                    inactiveColor: Colors.transparent,
                    // activeColor: Colors.white,
                    // value: position?.inSeconds.toDouble() ?? 70,
                    value: position?.inSeconds.toDouble() ?? 70,
                    max: maxDuration ?? 180.0,
                    onChanged: (newPosition) {
                      audioHandler.seek(
                        Duration(
                          seconds: newPosition.round(),
                        ),
                      );
                    },
                  ),
                ),
              );
      },
    );
  }
}
