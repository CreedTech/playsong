import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:playsong/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

import '../../custom_widgets/image_card.dart';
import '../../custom_widgets/on_hover.dart';
import '../../models/image_quality.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    double boxSize =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.height / 2.5;
    if (boxSize > 250) boxSize = 250;
    return ListView(
      children: [
        Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    child: ListTile(
                      // shape: ShapeBorder,
                      leading: Image.asset(
                        'assets/icons/love.png',
                        width: 40,
                      ),
                      title: Text(
                        'Likes',
                        style: GoogleFonts.hind(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      onTap: () {
                        // Get.to(const FinanceHealth());
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 24,
                        color: Color(0xffC5C5C5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    child: ListTile(
                      // shape: ShapeBorder,
                      leading: Image.asset(
                        'assets/icons/download.png',
                        width: 40,
                      ),
                      title: Text(
                        'Downloads',
                        style: GoogleFonts.hind(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      onTap: () {
                        // Get.to(const FinanceHealth());
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 24,
                        color: Color(0xffC5C5C5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    child: ListTile(
                      // shape: ShapeBorder,
                      leading: Image.asset(
                        'assets/icons/purchase.png',
                        width: 40,
                      ),
                      title: Text(
                        'Purchased',
                        style: GoogleFonts.hind(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      onTap: () {
                        // Get.to(const FinanceHealth());
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 24,
                        color: Color(0xffC5C5C5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    child: ListTile(
                      // shape: ShapeBorder,
                      leading: Image.asset(
                        'assets/icons/playlist.png',
                        width: 40,
                      ),
                      title: Text(
                        'Playlists',
                        style: GoogleFonts.hind(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      onTap: () {
                        // Get.to(const FinanceHealth());
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 24,
                        color: Color(0xffC5C5C5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    child: ListTile(
                      // shape: ShapeBorder,
                      leading: Image.asset(
                        'assets/icons/wallet.png',
                        width: 40,
                      ),
                      title: Text(
                        'Wallet',
                        style: GoogleFonts.hind(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      onTap: () {
                        Navigator.pushNamed(context, '/wallet');
                        // Get.to(const FinanceHealth());
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 24,
                        color: Color(0xffC5C5C5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    child: ListTile(
                      // shape: ShapeBorder,
                      leading: Image.asset(
                        'assets/icons/upload.png',
                        width: 40,
                      ),
                      title: Text(
                        'Uploads',
                        style: GoogleFonts.hind(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      onTap: () {
                        // Get.to(const FinanceHealth());
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 24,
                        color: Color(0xffC5C5C5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 21),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff724400),
                      Color(0xffD0A200),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upgrade your Account',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.hind(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Enjoy 1 week free trial',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.hind(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: colorBlack,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Uprade',
                        style: GoogleFonts.hind(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      14,
                      16,
                      16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Plays',
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
                                                    'Vishing',
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
                                                Text(
                                                  'Skuliju',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.hind(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
