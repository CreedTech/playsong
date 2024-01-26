import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playsong/theme/app_theme.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 112, left: 16, right: 16),
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/playsong_logo.png',
                  width: 64,
                ),
                 Text(
                  'PlaySong',
                  style: GoogleFonts.hind(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    'Your gateway to melody',
                    style: GoogleFonts.hind(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 65,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (var i = 0; i <= 5; i++)
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 5,
                                      ),
                                      child: Icon(
                                        Icons.star,
                                        color: colorPrimary,
                                        size: 12,
                                      ),
                                    ),
                                ],
                              ),
                               Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  'All-in-one music hub: Purchase songs, manage your personalized wallet with easy fund sharing, download favorite tunes and albums, and effortlessly search and filter songs and lyrics.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.hind(
                                    fontWeight: FontWeight.w400,
                                    // height: 1.3,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 233),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(400, 50),
                          backgroundColor: colorPrimary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              88,
                            ),
                          ),
                        ),
                        onPressed: () {
                           Navigator.of(context).pushNamed('/welcome');
                        },
                        child:  Text(
                          'Create free account',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.hind(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(400, 50),
                          backgroundColor: colorButton,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              88,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).popAndPushNamed('/home');
                        },
                        child:  Text(
                          'Log in',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.hind(
                            color: colorPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
