import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../constants/country_codes.dart';
import '../../custom_widgets/app_scrolling.dart';
import '../../custom_widgets/custom_physics.dart';
import '../../custom_widgets/gradient_containers.dart';
import '../../custom_widgets/image_card.dart';
import '../../custom_widgets/on_hover.dart';
import '../../models/image_quality.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../theme/app_theme.dart';

List new_release = [
  'Christian & Gospel',
  'Hip-Hop',
  'Energetic',
  'Playful',
  'R&B',
  'Meditate',
  'Country',
  'Rock',
  'Happy',
  'Classical',
  'Reggae',
  'Romantic',
];
List<Map<String, dynamic>> moodData = [
  {'song': 'Christian & Gospel', 'color': const Color(0xff24B500)},
  {'song': 'Hip-Hop', 'color': const Color(0xffAEDA00)},
  {'song': 'Energetic', 'color': const Color(0xffDA2700)},
  {'song': 'Playful', 'color': const Color(0xff6532F6)},
  {'song': 'R&B', 'color': const Color(0xffC800DA)},
  {'song': 'Meditate', 'color': const Color(0xffDAB700)},
  {'song': 'Country', 'color': const Color(0xffAA9CFF)},
  {'song': 'Rock', 'color': const Color(0xff008BDA)},
  {'song': 'Happy', 'color': const Color(0xff0FFFFF)},
  {'song': 'Classical', 'color': const Color(0xff2CD67C)},
  {'song': 'Reggae', 'color': const Color(0xffFF7C04)},
  {'song': 'Romantic', 'color': const Color(0xffFF5BAA)},
];

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  TextEditingController countryController = TextEditingController();
  final countryFormKey = GlobalKey<FormState>();
  String _selectedCountryCode = 'AF';
  String countryName = 'Choose Your Country';
  List<bool> isSelected = [true, false];
  String region =
      Hive.box('settings').get('region', defaultValue: 'Nigeria') as String;

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
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: TextFormField(
                onTap: () {
                  showModalBottomSheet(
                    isDismissible: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      List<String> countryCodes = CountryCodes.countries
                          .map((country) => country['code']!)
                          .toList();
                      List<String> countries = CountryCodes.countries
                          .map((country) => country['name']!)
                          .toList();

                      return BottomGradientContainer(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.fromLTRB(
                            0,
                            10,
                            0,
                            10,
                          ),
                          itemCount: countries.length,
                          itemBuilder: (context, idx) {
                            return ListTileTheme(
                              selectedColor:
                                  Theme.of(context).colorScheme.secondary,
                              child: ListTile(
                                contentPadding: const EdgeInsets.only(
                                  left: 25.0,
                                  right: 25.0,
                                ),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CountryFlag.fromCountryCode(
                                      countryCodes[idx],
                                      width: 18,
                                      height: 18,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Text(
                                        countries[idx],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                leading: Radio<String>(
                                  value: countries[idx],
                                  groupValue: region,
                                  onChanged: (String? value) {
                                    region = value!;
                                    Hive.box('settings').put('region', region);
                                    Navigator.pop(context);
                                    setState(() {
                                      _selectedCountryCode = countryCodes[idx];
                                      countryName = countries[idx];
                                    });
                                    print(_selectedCountryCode);
                                  },
                                ),
                                selected: region == countries[idx],
                                onTap: () {
                                  region = countries[idx];
                                  Hive.box('settings').put(
                                    'region',
                                    region,
                                  );
                                  Navigator.pop(
                                    context,
                                  );

                                  setState(() {});
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                readOnly: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                enableSuggestions: true,
                cursorColor: Theme.of(context).primaryColor,
                style: GoogleFonts.hind(
                  color: Theme.of(context).colorScheme.primary,
                ),

                controller: countryController,
                textAlignVertical: TextAlignVertical.center,
                // textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      color: Color(0xff1E1E1E),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      color: Color(0xff1E1E1E),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      color: Color(0xff1E1E1E),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ), // Change color to yellow
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 0, left: 5),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      // decoration: BoxDecoration(
                      //   color: const Color(0xff242424),
                      //   borderRadius: BorderRadius.circular(30),
                      // ),
                      child: CountryFlag.fromCountryCode(
                        _selectedCountryCode,
                        width: 20,
                        height: 20,
                        borderRadius: 5,
                      ),
                    ),
                  ),
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                  hintText: countryName,
                  labelStyle: GoogleFonts.hind(
                    // fontFamily: 'Milliard',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff4A4A4A),
                  ),
                  filled: true,
                  fillColor: colorButton,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  hintStyle: GoogleFonts.hind(
                    color: const Color(0xff4A4A4A),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                maxLines: 1,
              ),
            ),
            Padding(
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
                        Text(
                          'New Release',
                          style: GoogleFonts.hind(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
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
                    width: double.infinity,
                    height: (boxSize + 20) * 2,
                    child: ScrollConfiguration(
                      behavior: AppScrollBehavior(),
                      child: GridView(
                        scrollDirection: Axis.horizontal,
                        physics: const PageScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 2.0,
                                crossAxisSpacing: 2.0,
                                crossAxisCount: 2,
                                childAspectRatio: 1.25),
                        children: new_release
                            .map((title) => HoverBox(
                                child: imageCard(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4.0),
                                  borderRadius: 2.4,
                                  imageUrl: 'assets/images/mixes.png',
                                  imageQuality: ImageQuality.medium,
                                  placeholderImage: const AssetImage(
                                    'assets/images/mixes.png',
                                  ),
                                ),
                                builder: ({
                                  required BuildContext context,
                                  required bool isHover,
                                  Widget? child,
                                }) {
                                  return Card(
                                    color: isHover ? null : Colors.transparent,
                                    elevation: 0,
                                    margin: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        2.4,
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  margin: const EdgeInsets.all(
                                                    4.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black54,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10.0,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                        color: Colors.black87,
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
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 10,
                                                ),
                                                child: Text(
                                                  'Vishing',
                                                  textAlign: TextAlign.left,
                                                  softWrap: false,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.hind(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Shugar',
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
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
                                }))
                            .toList(),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //     height: (boxSize + 10) * 2,
                  //     child: SingleChildScrollView(
                  //       scrollDirection: Axis.horizontal,
                  //       child: SingleChildScrollView(
                  //         scrollDirection: Axis.vertical,
                  //         child: Column(
                  //           children: List.generate(2, (row) {
                  //             return Row(
                  //               children: List.generate(8, (col) {
                  //                 return GestureDetector(
                  //                   child: SizedBox(
                  //                     width: boxSize - 20,
                  //                     child: HoverBox(
                  //                         child: imageCard(
                  //                           margin: const EdgeInsets.symmetric(
                  //                               horizontal: 4, vertical: 4.0),
                  //                           borderRadius: 2.4,
                  //                           imageUrl: 'assets/images/mixes.png',
                  //                           imageQuality: ImageQuality.medium,
                  //                           placeholderImage: const AssetImage(
                  //                             'assets/images/mixes.png',
                  //                           ),
                  //                         ),
                  //                         builder: ({
                  //                           required BuildContext context,
                  //                           required bool isHover,
                  //                           Widget? child,
                  //                         }) {
                  //                           return Card(
                  //                             color: isHover
                  //                                 ? null
                  //                                 : Colors.transparent,
                  //                             elevation: 0,
                  //                             margin: EdgeInsets.zero,
                  //                             shape: RoundedRectangleBorder(
                  //                               borderRadius:
                  //                                   BorderRadius.circular(
                  //                                 2.4,
                  //                               ),
                  //                             ),
                  //                             clipBehavior: Clip.antiAlias,
                  //                             child: Column(
                  //                               mainAxisAlignment:
                  //                                   MainAxisAlignment.start,
                  //                               crossAxisAlignment:
                  //                                   CrossAxisAlignment.start,
                  //                               children: [
                  //                                 Stack(
                  //                                   children: [
                  //                                     SizedBox.square(
                  //                                       dimension: isHover
                  //                                           ? boxSize - 25
                  //                                           : boxSize - 30,
                  //                                       child: child,
                  //                                     ),
                  //                                     if (isHover)
                  //                                       Positioned.fill(
                  //                                         child: Container(
                  //                                           margin:
                  //                                               const EdgeInsets
                  //                                                   .all(
                  //                                             4.0,
                  //                                           ),
                  //                                           decoration:
                  //                                               BoxDecoration(
                  //                                             color: Colors
                  //                                                 .black54,
                  //                                             borderRadius:
                  //                                                 BorderRadius
                  //                                                     .circular(
                  //                                               10.0,
                  //                                             ),
                  //                                           ),
                  //                                           child: Center(
                  //                                             child:
                  //                                                 DecoratedBox(
                  //                                               decoration:
                  //                                                   BoxDecoration(
                  //                                                 color: Colors
                  //                                                     .black87,
                  //                                                 borderRadius:
                  //                                                     BorderRadius
                  //                                                         .circular(
                  //                                                   1000.0,
                  //                                                 ),
                  //                                               ),
                  //                                               child:
                  //                                                   const Icon(
                  //                                                 Icons
                  //                                                     .play_arrow_rounded,
                  //                                                 size: 50.0,
                  //                                                 color: Colors
                  //                                                     .white,
                  //                                               ),
                  //                                             ),
                  //                                           ),
                  //                                         ),
                  //                                       ),
                  //                                   ],
                  //                                 ),
                  //                                 Padding(
                  //                                   padding: const EdgeInsets
                  //                                       .symmetric(
                  //                                     horizontal: 10.0,
                  //                                   ),
                  //                                   child: Column(
                  //                                     mainAxisAlignment:
                  //                                         MainAxisAlignment
                  //                                             .start,
                  //                                     crossAxisAlignment:
                  //                                         CrossAxisAlignment
                  //                                             .start,
                  //                                     children: [
                  //                                       Padding(
                  //                                         padding:
                  //                                             const EdgeInsets
                  //                                                 .only(
                  //                                           right: 10,
                  //                                         ),
                  //                                         child: Text(
                  //                                           'Vishing',
                  //                                           textAlign:
                  //                                               TextAlign.left,
                  //                                           softWrap: false,
                  //                                           maxLines: 2,
                  //                                           overflow:
                  //                                               TextOverflow
                  //                                                   .ellipsis,
                  //                                           style: GoogleFonts
                  //                                               .hind(
                  //                                             fontWeight:
                  //                                                 FontWeight
                  //                                                     .w500,
                  //                                           ),
                  //                                         ),
                  //                                       ),
                  //                                       Text(
                  //                                         'Shugar',
                  //                                         textAlign:
                  //                                             TextAlign.left,
                  //                                         softWrap: true,
                  //                                         maxLines: 2,
                  //                                         overflow: TextOverflow
                  //                                             .ellipsis,
                  //                                         style:
                  //                                             GoogleFonts.hind(
                  //                                           fontSize: 11,
                  //                                           color: Theme.of(
                  //                                                   context)
                  //                                               .textTheme
                  //                                               .bodySmall!
                  //                                               .color,
                  //                                         ),
                  //                                       ),
                  //                                     ],
                  //                                   ),
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           );
                  //                         }),
                  //                   ),
                  //                 );
                  //               }),
                  //             );
                  //           }),
                  //         ),
                  //       ),
                  //     )),
                ],
              ),
            ),
            Padding(
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
                      Text(
                        'Top Artist Charts',
                        style: GoogleFonts.hind(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: (boxSize + 65),
                  child: ScrollConfiguration(
                    behavior: AppScrollBehavior(),
                    child: GridView(
                      scrollDirection: Axis.horizontal,
                      physics: const PageScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 2.0,
                              crossAxisSpacing: 2.0,
                              crossAxisCount: 4,
                              childAspectRatio: 0.18),
                      children: new_release.asMap().entries.map((entry) {
                        int index = entry.key;
                        // String title = entry.value;
                        return ListTile(
                          dense: false,
                          onTap: () {
                            Navigator.pushNamed(context, '/player');
                          },
                          title: Text(
                            'Burna Boy',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.hind(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '55.2k followers',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.hind(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          leading: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${index + 1}'),
                              SizedBox(
                                width: 13.sp,
                              ),
                              Hero(
                                tag: 'currentArtwork',
                                child: imageCard(
                                  elevation: 8,
                                  boxDimension: 50.0,
                                  localImage: true,
                                  borderRadius: 100,
                                  imageUrl: 'assets/images/customised.png',
                                  imageQuality: ImageQuality.medium,
                                  placeholderImage: const AssetImage(
                                    'assets/images/customised.png',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert_rounded,
                              color: Theme.of(context).iconTheme.color,
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
                                      color: Theme.of(context).iconTheme.color,
                                      size: 26.0,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(
                                        AppLocalizations.of(context)!.playNext),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 1,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.queue_music_rounded,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(AppLocalizations.of(context)!
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
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(AppLocalizations.of(context)!
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
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(AppLocalizations.of(context)!
                                        .viewAlbum),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'artist',
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.person_rounded,
                                        color:
                                            Theme.of(context).iconTheme.color,
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
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(AppLocalizations.of(context)!.share),
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
                      }).toList(),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: (boxSize + 65),
                //   child: ListView.builder(
                //       physics: const BouncingScrollPhysics(),
                //       scrollDirection:
                //           Axis.vertical, // Vertical scroll for the outer list
                //       itemCount: 4,
                //       itemBuilder: (context, rowIndex) {
                //         final startIndex = rowIndex * 6;
                //         final endIndex = (rowIndex + 1) * 6;
                //         final items = [
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //           '',
                //         ].sublist(startIndex, endIndex);
                //         return SizedBox(
                //           height: 62,
                //           child: ListView.builder(
                //               physics: PagingScrollPhysics(
                //                   itemDimension:
                //                       MediaQuery.of(context).size.width * 0.9),
                //               scrollDirection: Axis.horizontal,
                //               itemExtent:
                //                   MediaQuery.of(context).size.width * 0.9,
                //               itemCount: items.length,
                //               itemBuilder: (context, index) {
                //                 // Map item;
                //                 // item = data[lists[1]][index] as Map;
                //                 return ListTile(
                //                   dense: false,
                //                   onTap: () {
                //                     Navigator.pushNamed(context, '/player');
                //                   },
                //                   title: Text(
                //                     'Burna Boy',
                //                     maxLines: 2,
                //                     overflow: TextOverflow.ellipsis,
                //                     style: GoogleFonts.hind(
                //                       fontSize: 12,
                //                       fontWeight: FontWeight.w600,
                //                     ),
                //                   ),
                //                   subtitle: Text(
                //                     '55.2k followers',
                //                     maxLines: 1,
                //                     overflow: TextOverflow.ellipsis,
                //                     style: GoogleFonts.hind(
                //                       fontSize: 12,
                //                       fontWeight: FontWeight.w500,
                //                     ),
                //                   ),
                //                   leading: Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceBetween,
                //                     mainAxisSize: MainAxisSize.min,
                //                     children: [
                //                       Text((rowIndex + 1).toString()),
                //                       SizedBox(
                //                         width: 13.sp,
                //                       ),
                //                       Hero(
                //                         tag: 'currentArtwork',
                //                         child: imageCard(
                //                           elevation: 8,
                //                           boxDimension: 50.0,
                //                           localImage: true,
                //                           borderRadius: 100,
                //                           imageUrl:
                //                               'assets/images/customised.png',
                //                           imageQuality: ImageQuality.medium,
                //                           placeholderImage: const AssetImage(
                //                             'assets/images/customised.png',
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                   trailing: PopupMenuButton(
                //                     icon: Icon(
                //                       Icons.more_vert_rounded,
                //                       color: Theme.of(context).iconTheme.color,
                //                       size: 15,
                //                       weight: 3,
                //                     ),
                //                     shape: const RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.all(
                //                         Radius.circular(15.0),
                //                       ),
                //                     ),
                //                     itemBuilder: (context) => [
                //                       PopupMenuItem(
                //                         value: 6,
                //                         child: Row(
                //                           children: [
                //                             const Icon(
                //                               Icons.delete_rounded,
                //                             ),
                //                             const SizedBox(
                //                               width: 10.0,
                //                             ),
                //                             Text(
                //                               AppLocalizations.of(
                //                                 context,
                //                               )!
                //                                   .remove,
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                       PopupMenuItem(
                //                         value: 2,
                //                         child: Row(
                //                           children: [
                //                             Icon(
                //                               Icons.playlist_play_rounded,
                //                               color: Theme.of(context)
                //                                   .iconTheme
                //                                   .color,
                //                               size: 26.0,
                //                             ),
                //                             const SizedBox(width: 10.0),
                //                             Text(AppLocalizations.of(context)!
                //                                 .playNext),
                //                           ],
                //                         ),
                //                       ),
                //                       PopupMenuItem(
                //                         value: 1,
                //                         child: Row(
                //                           children: [
                //                             Icon(
                //                               Icons.queue_music_rounded,
                //                               color: Theme.of(context)
                //                                   .iconTheme
                //                                   .color,
                //                             ),
                //                             const SizedBox(width: 10.0),
                //                             Text(AppLocalizations.of(context)!
                //                                 .addToQueue),
                //                           ],
                //                         ),
                //                       ),
                //                       PopupMenuItem(
                //                         value: 0,
                //                         child: Row(
                //                           children: [
                //                             Icon(
                //                               Icons.playlist_add_rounded,
                //                               color: Theme.of(context)
                //                                   .iconTheme
                //                                   .color,
                //                             ),
                //                             const SizedBox(width: 10.0),
                //                             Text(AppLocalizations.of(context)!
                //                                 .addToPlaylist),
                //                           ],
                //                         ),
                //                       ),
                //                       PopupMenuItem(
                //                         value: 4,
                //                         child: Row(
                //                           children: [
                //                             Icon(
                //                               Icons.album_rounded,
                //                               color: Theme.of(context)
                //                                   .iconTheme
                //                                   .color,
                //                             ),
                //                             const SizedBox(width: 10.0),
                //                             Text(AppLocalizations.of(context)!
                //                                 .viewAlbum),
                //                           ],
                //                         ),
                //                       ),
                //                       PopupMenuItem(
                //                         value: 'artist',
                //                         child: SingleChildScrollView(
                //                           scrollDirection: Axis.horizontal,
                //                           child: Row(
                //                             children: [
                //                               Icon(
                //                                 Icons.person_rounded,
                //                                 color: Theme.of(context)
                //                                     .iconTheme
                //                                     .color,
                //                               ),
                //                               const SizedBox(width: 10.0),
                //                               Text(
                //                                 '${AppLocalizations.of(context)!.viewArtist} Test',
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                       ),
                //                       PopupMenuItem(
                //                         value: 3,
                //                         child: Row(
                //                           children: [
                //                             Icon(
                //                               Icons.share_rounded,
                //                               color: Theme.of(context)
                //                                   .iconTheme
                //                                   .color,
                //                             ),
                //                             const SizedBox(width: 10.0),
                //                             Text(AppLocalizations.of(context)!
                //                                 .share),
                //                           ],
                //                         ),
                //                       ),
                //                     ],
                //                     onSelected: (value) {
                //                       switch (value) {
                //                         case 3:
                //                           Share.share('');
                //                           break;

                //                         case 4:
                //                           // TODO come back here!!!
                //                           // Navigator.push(
                //                           //   context,
                //                           //   PageRouteBuilder(
                //                           //     opaque: false,
                //                           //     pageBuilder: (_, __, ___) => SongsListPage(
                //                           //       listItem: {
                //                           //         'type': 'album',
                //                           //         'id': mediaItem.extras?['album_id'],
                //                           //         'title': mediaItem.album,
                //                           //         'image': mediaItem.artUri,
                //                           //       },
                //                           //     ),
                //                           //   ),
                //                           // );
                //                           break;
                //                         case 6:
                //                           '';
                //                           break;
                //                         case 0:
                //                           '';
                //                           break;
                //                         case 1:
                //                           '';
                //                           break;
                //                         case 2:
                //                           '';
                //                           break;
                //                         default:
                //                           // TODO come back here!!!
                //                           // Navigator.push(
                //                           //   context,
                //                           //   PageRouteBuilder(
                //                           //     opaque: false,
                //                           //     pageBuilder: (_, __, ___) => AlbumSearchPage(
                //                           //       query: value.toString(),
                //                           //       type: 'Artists',
                //                           //     ),
                //                           //   ),
                //                           // );
                //                           break;
                //                       }
                //                     },
                //                   ),
                //                 );
                //               }),
                //         );
                //       }),
                // ),
              ]),
            ),
            Padding(
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
                            'Trending Songs Charts',
                            style: GoogleFonts.hind(
                              color: Colors.white,
                              fontSize: 16,
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
                      scrollDirection:
                          Axis.vertical, // Vertical scroll for the outer list
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
                                      MediaQuery.of(context).size.width * 0.9),
                              scrollDirection: Axis.horizontal,
                              itemExtent:
                                  MediaQuery.of(context).size.width * 0.9,
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                // Map item;
                                // item = data[lists[1]][index] as Map;
                                return ListTile(
                                  dense: false,
                                  onTap: () {
                                    Navigator.pushNamed(context, '/player');
                                  },
                                  title: Text(
                                    'Assurance',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.hind(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        'Davido',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.hind(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Container(
                                          width: 3,
                                          height: 3,
                                          // padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '5.1M plays',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.hind(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  leading: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text((rowIndex + 1).toString()),
                                      SizedBox(
                                        width: 13.sp,
                                      ),
                                      Hero(
                                        tag: 'currentArtwork',
                                        child: imageCard(
                                          elevation: 8,
                                          boxDimension: 50.0,
                                          localImage: true,
                                          borderRadius: 8,
                                          imageUrl:
                                              'assets/images/customised.png',
                                          imageQuality: ImageQuality.medium,
                                          placeholderImage: const AssetImage(
                                            'assets/images/customised.png',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: PopupMenuButton(
                                    icon: Icon(
                                      Icons.more_vert_rounded,
                                      color: Theme.of(context).iconTheme.color,
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
                                            Text(AppLocalizations.of(context)!
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
                                            Text(AppLocalizations.of(context)!
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
                                            Text(AppLocalizations.of(context)!
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
                                            Text(AppLocalizations.of(context)!
                                                .viewAlbum),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'artist',
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
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
                                            Text(AppLocalizations.of(context)!
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1),
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
                        Text(
                          'Trending Albums Charts',
                          style: GoogleFonts.hind(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
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
                    height: (boxSize + 25),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          // Map item;
                          // item = data[lists[1]][index] as Map;
                          return GestureDetector(
                            child: SizedBox(
                              width: boxSize - 20,
                              child: HoverBox(
                                  child: imageCard(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 4.0),
                                    borderRadius: 2.4,
                                    imageUrl: 'assets/images/upcoming.png',
                                    imageQuality: ImageQuality.medium,
                                    placeholderImage: const AssetImage(
                                      'assets/images/upcoming.png',
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
                                          2.4,
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                        const EdgeInsets.all(
                                                      4.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black54,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10.0,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: DecoratedBox(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black87,
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
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
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
                                                    right: 10,
                                                  ),
                                                  child: Text(
                                                    'Glorious Day',
                                                    textAlign: TextAlign.left,
                                                    softWrap: false,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.hind(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Album',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.hind(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: Container(
                                                        width: 3,
                                                        height: 3,
                                                        // padding: EdgeInsets.all(3),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      'Davido',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.hind(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
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
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1),
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
                        Text(
                          'Moods and Genres',
                          style: GoogleFonts.hind(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
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
                    // width: double.infinity,
                    height: boxSize + 60,
                    child: ScrollConfiguration(
                      behavior: AppScrollBehavior(),
                      child: GridView(
                        scrollDirection: Axis.horizontal,
                        physics: const PageScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 2.0,
                                crossAxisSpacing: 2.0,
                                crossAxisCount: 4,
                                childAspectRatio: 0.39),
                        children: moodData
                            .map((title) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: GestureDetector(
                                    child: SizedBox(
                                      width: boxSize - 50,
                                      height: 60,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, bottom: 8),
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: boxSize - 60,
                                              height: 140,
                                              decoration: BoxDecoration(
                                                color: const Color(0xff2F2E2E),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                child: Center(
                                                  child: Text(
                                                    title['song'],
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.hind(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 20,
                                                    height: 6,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: title['color'],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 1,
                                                  ),
                                                  Container(
                                                    width: 105,
                                                    height: 6,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: title['color'],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 1,
                                                  ),
                                                  Container(
                                                    width: 20,
                                                    height: 6,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: title['color'],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Container(
                                            //   alignment: Alignment.center,
                                            //   color: Colors.redAccent,
                                            //   child: Text(title),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),

                  // SizedBox(
                  //     height: (boxSize + 10),
                  //     child: SingleChildScrollView(
                  //       scrollDirection: Axis.horizontal,
                  //       child: SingleChildScrollView(
                  //         scrollDirection: Axis.vertical,
                  //         child: Column(
                  //           children: List.generate(4, (row) {
                  //             // final rowIndex = mood_lists.length / 2;
                  //             return Row(
                  //               children: List.generate(4,
                  //                   (col) {
                  //                 // int index =
                  //                 //     row * (mood_lists.length ~/ 2) + col;
                  //                 return Padding(
                  //                   padding: const EdgeInsets.only(left: 10),
                  //                   child: GestureDetector(
                  //                     child: SizedBox(
                  //                       width: boxSize - 50,
                  //                       height: 60,
                  //                       child: Padding(
                  //                         padding: const EdgeInsets.only(
                  //                             top: 8, bottom: 8),
                  //                         child: Stack(
                  //                           children: [
                  //                             Container(
                  //                               width: boxSize - 60,
                  //                               height: 140,
                  //                               decoration: const BoxDecoration(
                  //                                 color: Color(0xff2F2E2E),
                  //                               ),
                  //                               child: Center(
                  //                                 child: Text(
                  //                                   (col*row).toString(),
                  //                                   textAlign: TextAlign.center,
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                             Positioned(
                  //                               top: 0,
                  //                               child: Row(
                  //                                 children: [
                  //                                   Container(
                  //                                     width: 20,
                  //                                     height: 6,
                  //                                     decoration:
                  //                                         const BoxDecoration(
                  //                                       color: Colors.green,
                  //                                     ),
                  //                                   ),
                  //                                   const SizedBox(
                  //                                     width: 1,
                  //                                   ),
                  //                                   Container(
                  //                                     width: 105,
                  //                                     height: 6,
                  //                                     decoration:
                  //                                         const BoxDecoration(
                  //                                       color: Colors.green,
                  //                                     ),
                  //                                   ),
                  //                                   const SizedBox(
                  //                                     width: 1,
                  //                                   ),
                  //                                   Container(
                  //                                     width: 20,
                  //                                     height: 6,
                  //                                     decoration:
                  //                                         const BoxDecoration(
                  //                                       color: Colors.green,
                  //                                     ),
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 );
                  //               }),
                  //             );
                  //           }),
                  //         ),
                  //       ),
                  //     )
                  //     // ListView.builder(
                  //     //     physics: const BouncingScrollPhysics(),
                  //     //     scrollDirection: Axis.horizontal,
                  //     //     padding: const EdgeInsets.symmetric(horizontal: 10),
                  //     //     itemCount: 4,
                  //     //     itemBuilder: (context, index) {
                  //     //       // Map item;
                  //     //       // item = data[lists[1]][index] as Map;
                  //     //       return GestureDetector(
                  //     //         child: SizedBox(
                  //     //           width: boxSize - 20,
                  //     //           child: HoverBox(
                  //     //               child: imageCard(
                  //     //                 margin: const EdgeInsets.symmetric(
                  //     //                     horizontal: 4, vertical: 4.0),
                  //     //                 borderRadius: 2.4,
                  //     //                 imageUrl: 'assets/images/upcoming.png',
                  //     //                 imageQuality: ImageQuality.medium,
                  //     //                 placeholderImage: const AssetImage(
                  //     //                   'assets/images/upcoming.png',
                  //     //                 ),
                  //     //               ),
                  //     //               builder: ({
                  //     //                 required BuildContext context,
                  //     //                 required bool isHover,
                  //     //                 Widget? child,
                  //     //               }) {
                  //     //                 return Card(
                  //     //                   color:
                  //     //                       isHover ? null : Colors.transparent,
                  //     //                   elevation: 0,
                  //     //                   margin: EdgeInsets.zero,
                  //     //                   shape: RoundedRectangleBorder(
                  //     //                     borderRadius: BorderRadius.circular(
                  //     //                       2.4,
                  //     //                     ),
                  //     //                   ),
                  //     //                   clipBehavior: Clip.antiAlias,
                  //     //                   child: Column(
                  //     //                     mainAxisAlignment:
                  //     //                         MainAxisAlignment.start,
                  //     //                     crossAxisAlignment:
                  //     //                         CrossAxisAlignment.start,
                  //     //                     children: [
                  //     //                       Stack(
                  //     //                         children: [
                  //     //                           SizedBox.square(
                  //     //                             dimension: isHover
                  //     //                                 ? boxSize - 25
                  //     //                                 : boxSize - 30,
                  //     //                             child: child,
                  //     //                           ),
                  //     //                           if (isHover)
                  //     //                             Positioned.fill(
                  //     //                               child: Container(
                  //     //                                 margin:
                  //     //                                     const EdgeInsets.all(
                  //     //                                   4.0,
                  //     //                                 ),
                  //     //                                 decoration: BoxDecoration(
                  //     //                                   color: Colors.black54,
                  //     //                                   borderRadius:
                  //     //                                       BorderRadius.circular(
                  //     //                                     10.0,
                  //     //                                   ),
                  //     //                                 ),
                  //     //                                 child: Center(
                  //     //                                   child: DecoratedBox(
                  //     //                                     decoration:
                  //     //                                         BoxDecoration(
                  //     //                                       color: Colors.black87,
                  //     //                                       borderRadius:
                  //     //                                           BorderRadius
                  //     //                                               .circular(
                  //     //                                         1000.0,
                  //     //                                       ),
                  //     //                                     ),
                  //     //                                     child: const Icon(
                  //     //                                       Icons
                  //     //                                           .play_arrow_rounded,
                  //     //                                       size: 50.0,
                  //     //                                       color: Colors.white,
                  //     //                                     ),
                  //     //                                   ),
                  //     //                                 ),
                  //     //                               ),
                  //     //                             ),
                  //     //                         ],
                  //     //                       ),
                  //     //                       Padding(
                  //     //                         padding: const EdgeInsets.symmetric(
                  //     //                           horizontal: 10.0,
                  //     //                         ),
                  //     //                         child: Column(
                  //     //                           mainAxisAlignment:
                  //     //                               MainAxisAlignment.start,
                  //     //                           crossAxisAlignment:
                  //     //                               CrossAxisAlignment.start,
                  //     //                           children: [
                  //     //                             Padding(
                  //     //                               padding:
                  //     //                                   const EdgeInsets.only(
                  //     //                                 right: 10,
                  //     //                               ),
                  //     //                               child: Text(
                  //     //                                 'Vishing',
                  //     //                                 textAlign: TextAlign.left,
                  //     //                                 softWrap: false,
                  //     //                                 maxLines: 2,
                  //     //                                 overflow:
                  //     //                                     TextOverflow.ellipsis,
                  //     //                                 style: GoogleFonts.hind(
                  //     //                                   fontWeight:
                  //     //                                       FontWeight.w500,
                  //     //                                 ),
                  //     //                               ),
                  //     //                             ),
                  //     //                             Text(
                  //     //                               'Shugar',
                  //     //                               textAlign: TextAlign.left,
                  //     //                               softWrap: true,
                  //     //                               maxLines: 2,
                  //     //                               overflow:
                  //     //                                   TextOverflow.ellipsis,
                  //     //                               style: GoogleFonts.hind(
                  //     //                                 fontSize: 11,
                  //     //                                 color: Theme.of(context)
                  //     //                                     .textTheme
                  //     //                                     .bodySmall!
                  //     //                                     .color,
                  //     //                               ),
                  //     //                             ),
                  //     //                           ],
                  //     //                         ),
                  //     //                       ),
                  //     //                     ],
                  //     //                   ),
                  //     //                 );
                  //     //               }),
                  //     //         ),
                  //     //       );
                  //     //     }),

                  //     ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
