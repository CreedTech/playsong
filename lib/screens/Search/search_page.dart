import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:playsong/models/song_item.dart';
import 'package:playsong/theme/app_theme.dart';
import 'package:sizer/sizer.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../../models/user_list.dart';

enum Options { music, archive }

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<SongItem> _products = [];
  Options _selectedSegment = Options.music;
  List<Users> _users = [];
  bool onSubmitted = false;
  bool bottomEnabled = false;
  // final general = General.instance;
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

  // Future<List<SongItem>> search(String text) async {
  //   try {
  //     var client = http.Client();

  //     final response = await client
  //         .get(Uri.parse('https://dummyjson.com/products/search?q=$text'));

  //     // print(UserList.fromJson(json.decode(response.body)).users!);
  //     if (response.statusCode == 200) {
  //       var products = (json.decode(response.body)['products'] as List)
  //           .map((product) => SongItem.fromJson(product))
  //           .toList();

  //       return products;
  //       // return Packages.fromJson(json.decode(response.body)).products!;
  //     } else {
  //       throw Exception('Something Goes Wrong');
  //     }
  //   } catch (e) {
  //     throw Exception('$e');
  //   }
  // }

  // Widget createSuggestionList() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //         child: Text(
  //           'Recent Searches',
  //           textAlign: TextAlign.start,
  //         ),
  //       ),
  //       ListView.builder(
  //         shrinkWrap: true,
  //         padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
  //         physics: const NeverScrollableScrollPhysics(),
  //         itemBuilder: (context, index) => GestureDetector(
  //           onTap: () => setState(() {
  //             onSubmitted = true;
  //           }),
  //           child: Column(
  //             children: [
  //               ListTile(
  //                 // minLeadingWidth: 1,
  //                 horizontalTitleGap: 1,
  //                 dense: true,
  //                 // contentPadding: EdgeInsets.zero,
  //                 leading: Icon(Icons.access_time),
  //                 title: Text(
  //                   "${_products[index].title}",
  //                   textAlign: TextAlign.left,
  //                 ),
  //                 trailing: Icon(CupertinoIcons.arrow_up_right),
  //               ),
  //             ],
  //           ),
  //         ),
  //         itemCount: _products.length,
  //       ),
  //     ],
  //   );
  // }

  // Widget createSearchList() {
  //   return ListView.separated(
  //     shrinkWrap: true,
  //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemBuilder: (context, index) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         Container(
  //           height: 100,
  //           margin: const EdgeInsets.only(top: 8),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             color: Color(0xFFFCFCFC),
  //             // border: Border.all(
  //             //   color: const Color(0xFFE1E1E1),
  //             // ),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Color(0xFFFCFCFC).withOpacity(0.5),
  //                 spreadRadius: 0,
  //                 blurRadius: 1,
  //               ),
  //             ],
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(
  //               horizontal: 10,
  //               vertical: 10,
  //             ),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Column(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'Macbook Pro 2022',
  //                       style: TextStyle(
  //                         color: colorBlack,
  //                         fontSize: 16.sp,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                     Text(
  //                       'R763489247523',
  //                       style: TextStyle(
  //                         // color: colorGray,
  //                         fontSize: 12.sp,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                     Align(
  //                       alignment: Alignment.center,
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           Image.asset(
  //                             'assets/icons/paid.png',
  //                             width: 20.w,
  //                             alignment: Alignment.center,
  //                           ),
  //                           SizedBox(
  //                             width: 5.w,
  //                           ),
  //                           Text(
  //                             'Paid',
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(
  //                               fontSize: 14.sp,
  //                               fontWeight: FontWeight.w400,
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Column(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   children: [
  //                     Text(
  //                       'In Transit',
  //                       style: TextStyle(
  //                         // color: colorGray,
  //                         fontSize: 12.sp,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         Image.asset(
  //                           'assets/icons/box.png',
  //                           width: 14.w,
  //                           alignment: Alignment.center,
  //                         ),
  //                         SizedBox(
  //                           width: 5.w,
  //                         ),
  //                         Text(
  //                           '3.24 kg',
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(
  //                               fontSize: 14.sp, fontWeight: FontWeight.w400),
  //                         )
  //                       ],
  //                     ),
  //                     Text(
  //                       'June 20, 2023',
  //                       style: TextStyle(
  //                         color: colorBlack,
  //                         fontSize: 14.sp,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //     separatorBuilder: (c, i) => Divider(
  //       color: Colors.grey.withOpacity(0.25),
  //       height: 50,
  //     ),
  //     itemCount: _products.length,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // NestedScrollView(
        //   physics: const BouncingScrollPhysics(),
        //   controller: _scrollController,
        //   headerSliverBuilder: (
        //     BuildContext context,
        //     bool innerBoxScrolled,
        //   ) {
        //     return <Widget>[
        //       SliverAppBar(
        //         // expandedHeight: 135,
        //         automaticallyImplyLeading: false,
        //         title: Row(
        //           children: [
        //             Image.asset(
        //               'assets/images/playsong_logo.png',
        //               width: 64,
        //             ),
        //             const SizedBox(
        //               width: 4,
        //             ),
        //             Text(
        //               'Search',
        //               style: GoogleFonts.hind(
        //                 fontWeight: FontWeight.w700,
        //                 fontSize: 24,
        //               ),
        //             ),
        //           ],
        //         ),
        //         backgroundColor: Colors.transparent,
        //         elevation: 0,
        //         // pinned: true,
        //         // toolbarHeight: 65,
        //         // floating: true,
        //         // automaticallyImplyLeading: false,
        //         actions: [
        //           Padding(
        //             padding: const EdgeInsets.only(right: 18.0),
        //             child: Card(
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(
        //                   1000.0,
        //                 ),
        //               ),
        //               color: Colors.black54,
        //               child: Image.asset(
        //                 'assets/images/lady_image.png',
        //                 width: 30,
        //                 height: 30,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ];
        //   },
        //   body: SuperScaffold(
        //     // scrollController: ScrollController(),
        //     appBar: SuperAppBar(
        //       backgroundColor: Colors.black.withOpacity(0.95),
        //       automaticallyImplyLeading: false,
        //       // title: Text(
        //       //   "Search",
        //       //   style: TextStyle(
        //       //     color: Theme.of(context).textTheme.bodyMedium!.color,
        //       //   ),
        //       // ),
        //       largeTitle: SuperLargeTitle(
        //         largeTitle: "",
        //         // actions: [
        //         //   const Icon(
        //         //     CupertinoIcons.profile_circled,
        //         //     size: 35,
        //         //     color: Colors.redAccent,
        //         //   ),
        //         // ],
        //       ),
        //       searchBar: SuperSearchBar(
        //         resultColor: Colors.black,
        //         onFocused: (hasfocus) async {
        //           await Future.delayed(
        //               hasfocus
        //                   ? const Duration(milliseconds: 400)
        //                   : Duration.zero,
        //               () => bottomEnabled = hasfocus);
        //           setState(() {});
        //         },
        //         onChanged: (text) {
        //           print(text);
        //           search(text).then((value) {
        //             _users = value;
        //             onSubmitted = false;
        //             setState(() {});
        //           });
        //         },
        //         onSubmitted: (text) {
        //           search(text).then((value) {
        //             _users = value;
        //             onSubmitted = true;
        //             setState(() {});
        //           });
        //         },
        //         searchResult: SingleChildScrollView(
        //           child: Column(children: [
        //             const SizedBox(
        //               height: 5,
        //             ),
        //             !onSubmitted ? createSuggestionList() : const SizedBox(),
        //             _users.isNotEmpty
        //                 ? Divider(
        //                     indent: 15,
        //                     endIndent: 15,
        //                     color: Colors.grey.withOpacity(0.25),
        //                     height: 20,
        //                   )
        //                 : const SizedBox(),
        //             createResultList(),
        //           ]),
        //         ),
        //       ),
        //       bottom: SuperAppBarBottom(
        //         enabled: bottomEnabled,
        //         height: 35,
        //         child: Stack(
        //           children: [
        //             // AnimatedContainer(
        //             //   transform: Matrix4.translationValues(
        //             //       0, !onSubmitted ? 0 : -20, 0),
        //             //   duration: const Duration(milliseconds: 200),
        //             //   width: MediaQuery.of(context).size.width,
        //             //   padding: const EdgeInsets.symmetric(
        //             //       horizontal: 15.0, vertical: 0),
        //             //   child: AnimatedOpacity(
        //             //     opacity: !onSubmitted ? 1 : 0,
        //             //     duration: const Duration(milliseconds: 200),
        //             //     child: _headerResult(),
        //             //   ),
        //             // ),
        //             AnimatedContainer(
        //               transform: Matrix4.translationValues(
        //                   0, onSubmitted ? 0 : -20, 0),
        //               duration: const Duration(milliseconds: 200),
        //               child: AnimatedOpacity(
        //                 opacity: onSubmitted ? 1 : 0,
        //                 duration: const Duration(milliseconds: 200),
        //                 child: HeaderOnSubmitResult(),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     body: SingleChildScrollView(
        //       child: Column(
        //         children: [
        //           const Padding(
        //             padding: EdgeInsets.only(
        //                 left: 15.0, right: 15.0, top: 10.0, bottom: 15),
        //             child: Row(
        //               children: [
        //                 Text(
        //                   "Browse Categories",
        //                   // style: General.instance.getSubtitle(context),
        //                   textAlign: TextAlign.left,
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(15.0),
        //             child: GridView.count(
        //               padding: EdgeInsets.zero,
        //               shrinkWrap: true,
        //               crossAxisSpacing: 20,
        //               childAspectRatio: 1.5,
        //               mainAxisSpacing: 20,
        //               physics: const NeverScrollableScrollPhysics(),
        //               crossAxisCount: 2,
        //               children: List.generate(100, (index) {
        //                 return SizedBox(
        //                   width: double.infinity,
        //                   height: 125,
        //                   child: Stack(
        //                     children: [
        //                       SizedBox(
        //                         width: double.infinity,
        //                         height: 125,
        //                         child: ClipRRect(
        //                           borderRadius: BorderRadius.circular(20),
        //                           child: Image.asset(
        //                             "assets/apple_music_${index % 6}.jpeg",
        //                             fit: BoxFit.cover,
        //                           ),
        //                         ),
        //                       ),
        //                       const Align(
        //                         alignment: Alignment.bottomLeft,
        //                         child: Padding(
        //                           padding: EdgeInsets.all(8.0),
        //                           child: Text(
        //                             "Apple Music",
        //                             style: TextStyle(
        //                                 fontWeight: FontWeight.w700),
        //                           ),
        //                         ),
        //                       )
        //                     ],
        //                   ),
        //                 );
        //               }),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
     
        //   // body: const HomeInfo(),
        // ),
        
      ],
    );
  }

// }
  Future<List<Users>> search(String text) async {
    try {
      var client = http.Client();

      final response = await client
          .get(Uri.parse('https://dummyjson.com/users/search?q=$text'));

      // print(UserList.fromJson(json.decode(response.body)).users!);
      if (response.statusCode == 200) {
        return UserList.fromJson(json.decode(response.body)).users!;
      } else {
        throw Exception('Something Goes Wrong');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Widget createResultList() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 55,
            width: 55,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                _users[index].image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${_users[index].firstName} ${_users[index].lastName}"),
                const SizedBox(
                  height: 5,
                ),
                const Opacity(
                  opacity: 0.5,
                  child: Text(
                    "Artist",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            CupertinoIcons.chevron_forward,
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
      separatorBuilder: (c, i) => Divider(
        color: Colors.grey.withOpacity(0.25),
      ),
      itemCount: _users.length,
    );
  }

  Widget createSuggestionList() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.search,
            color: CupertinoColors.systemPink,
          ),
          const SizedBox(
            width: 15,
          ),
          Text("${_users[index].firstName} ${_users[index].lastName}")
        ],
      ),
      separatorBuilder: (c, i) => Divider(
        color: Colors.grey.withOpacity(0.25),
        height: 20,
      ),
      itemCount: _users.length > 3 ? 3 : _users.length,
    );
  }

  Widget _headerResult() {
    return CupertinoSlidingSegmentedControl<Options>(
      backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
      thumbColor: CupertinoColors.systemGrey2,
      // This represents the currently selected segmented control.
      groupValue: _selectedSegment,

      // Callback that sets the selected segmented control.
      onValueChanged: (Options? value) {
        if (value != null) {
          setState(() {
            _selectedSegment = value;
          });
        }
      },
      children: const <Options, Widget>{
        Options.music: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Apple Music',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
        Options.archive: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Archive',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
      },
    );
  }
}

class HeaderOnSubmitResult extends StatelessWidget {
  HeaderOnSubmitResult({super.key});

  final List<String> _some = [
    "Best Matches",
    "Artists",
    "Albums",
    "Songs",
    "Lists",
    "Podcasts",
    "Stations",
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _some.length,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
          decoration: BoxDecoration(
            color: selectedIndex == index
                ? CupertinoColors.systemPink
                : Colors.transparent,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Center(
            child: Text(
              _some[index],
            ),
          ),
        );
      },
    );
  }
}
