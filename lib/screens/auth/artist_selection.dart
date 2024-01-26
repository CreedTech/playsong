import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_theme.dart';

class ArtistSelectionPage extends StatefulWidget {
  const ArtistSelectionPage({super.key});

  @override
  State<ArtistSelectionPage> createState() => _ArtistSelectionPageState();
}

class _ArtistSelectionPageState extends State<ArtistSelectionPage> {
  List<int> selectedIndexes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        // toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/playsong_logo.png',
                        width: 64,
                      ),
                      Text(
                        'Please select 5 preferences ',
                        style: GoogleFonts.hind(
                          // fontFamily: 'Milliard',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Artists and Genres',
                        style: GoogleFonts.hind(
                          // fontFamily: 'Milliard',
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: const Color(0xffC5C5C5),
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap:
                            true, // Important to wrap with a SizedBox or a parent with fixed height
                        physics: const BouncingScrollPhysics(),
                        children: List.generate(12, (index) {
                          bool isSelected = selectedIndexes.contains(index);
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedIndexes.remove(index);
                                } else {
                                  if (selectedIndexes.length < 5) {
                                    selectedIndexes.add(index);
                                  } else {
                                    // Display a message or handle maximum selection limit
                                  }
                                }
                              });
                            },
                            child: Container(
                              width: 42,
                              // height: 12,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.sp, vertical: 5.sp),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        padding: isSelected
                                            ? const EdgeInsets.all(1)
                                            : null,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? colorPrimary
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(200),
                                        ),
                                        child: Image.asset(
                                          'assets/images/music_default.png',
                                          scale: 4,
                                        ),
                                      ),
                                      if (isSelected)
                                        const Positioned(
                                          right: 0,
                                          child: CircleAvatar(
                                            backgroundColor: colorButton,
                                            radius: 10,
                                            child: Icon(
                                              Icons.check,
                                              color: colorPrimary,
                                              size: 10,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6.sp,
                                  ),
                                  Text(
                                    'Sunmisola Aderigbi',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.hind(
                                      // fontFamily: 'Milliard',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 153.sp,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xff141413),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(328, 52),
                        backgroundColor: (selectedIndexes.length < 5)
                            ? const Color(0xff665C00)
                            : Theme.of(context).primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            88,
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (selectedIndexes.length >= 5) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                            (route) => false,
                          );
                        }
                      },
                      child: Text(
                        'Done Selecting',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.hind(
                          // fontFamily: 'Milliard',
                          color: colorButton,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.sp,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(328, 52),
                        backgroundColor: colorButton,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            88,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          (route) => false,
                        );
                      },
                      child: Text(
                        'Skip',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.hind(
                          // fontFamily: 'Milliard',
                          color: colorPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
