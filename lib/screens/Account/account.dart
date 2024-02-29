import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_theme.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Account',
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
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.close,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              child: ListTile(
                // shape: ShapeBorder,
                leading: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      1000.0,
                    ),
                  ),
                  color: Colors.black54,
                  child: Image.asset(
                    'assets/images/lady_image.png',
                    width: 48,
                    height: 48,
                  ),
                ),
                title: Text(
                  'Glow',
                  style: GoogleFonts.hind(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'View Profile',
                  style: GoogleFonts.hind(
                    color: const Color(0xffC4C4C4),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
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
            padding:
                const EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 21),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/icons/account_banner.png'),
                  fit: BoxFit.cover,
                ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/icons/wallet_white.png',
                        width: 30,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Playsong Wallet',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.hind(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '#12,000.00',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.hind(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 27,
                    height: 27,
                    // padding: const EdgeInsets.symmetric(
                    //     horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: const Icon(
                      Icons.arrow_outward_sharp,
                      color: colorBlack,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            color: Color(0xff424242),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  child: ListTile(
                    // shape: ShapeBorder,
                    leading: Container(
                      width: 27,
                      height: 27,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: Image.asset(
                        'assets/icons/history.png',
                        width: 18,
                      ),
                    ),
                    title: Text(
                      'History',
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
                    leading: Container(
                      width: 27,
                      height: 27,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: Image.asset(
                        'assets/icons/recap.png',
                        width: 18,
                      ),
                    ),
                    title: Text(
                      'Recap',
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
                    leading: Container(
                      width: 27,
                      height: 27,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: Image.asset(
                        'assets/icons/settings.png',
                        width: 18,
                      ),
                    ),
                    title: Text(
                      'Settings',
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
                    leading: Container(
                      width: 27,
                      height: 27,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: Image.asset(
                        'assets/icons/help.png',
                        width: 18,
                      ),
                    ),
                    title: Text(
                      'Help & Feedback',
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
                    leading: Container(
                      width: 27,
                      height: 27,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: Image.asset(
                        'assets/icons/delete.png',
                        width: 18,
                      ),
                    ),
                    title: Text(
                      'Delete Account',
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
        ],
      ),
    );
  }
}
