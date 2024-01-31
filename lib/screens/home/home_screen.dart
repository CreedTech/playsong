import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:playsong/screens/home/home_info.dart';

bool fetched = false;
List preferredLanguage = Hive.box('settings')
    .get('preferredLanguage', defaultValue: ['English']) as List;
List likedRadio =
    Hive.box('settings').get('likedRadio', defaultValue: []) as List;
Map data = Hive.box('cache').get('homepage', defaultValue: {}) as Map;
List lists = ['recent', 'playlist', ...?data['collections'] as List?];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String name =
        Hive.box('settings').get('name', defaultValue: 'Guest') as String;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool rotated = MediaQuery.of(context).size.height < screenWidth;
    return Stack(
      children: [
        NestedScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          headerSliverBuilder: (
            BuildContext context,
            bool innerBoxScrolled,
          ) {
            return <Widget>[
              SliverAppBar(
                // expandedHeight: 135,
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
                // pinned: true,
                // toolbarHeight: 65,
                // floating: true,
                // automaticallyImplyLeading: false,
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
            ];
          },
          body: const HomeInfo(),
        ),
      ],
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     automaticallyImplyLeading: false,
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //     title: Row(
    //       children: [
    //         Image.asset(
    //           'assets/images/playsong_logo.png',
    //           width: 64,
    //         ),
    //         const SizedBox(
    //           width: 4,
    //         ),
    //         Text(
    //           'PlaySong',
    //           style: GoogleFonts.hind(
    //             fontWeight: FontWeight.w700,
    //             fontSize: 24,
    //           ),
    //         ),
    //       ],
    //     ),
    //     actions: [
    //       Padding(
    //         padding: const EdgeInsets.only(right: 18.0),
    //         child: Card(
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(
    //               1000.0,
    //             ),
    //           ),
    //           color: Colors.black54,
    //           child: Image.asset(
    //             'assets/images/lady_image.png',
    //             width: 30,
    //             height: 30,
    //           ),
    //         ),
    //       ),

    //     ],
    //   ),
    //   body: HomeInfo(),
    // );
  }
}
