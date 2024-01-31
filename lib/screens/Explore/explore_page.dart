import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ExploreScreen.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
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
                      'Explore',
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
          body: ExploreScreen(),
          // body: const HomeInfo(),
        ),
      ],
    );
  }
}
