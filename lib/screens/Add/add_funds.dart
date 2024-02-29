import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_theme.dart';

class AddFundsPage extends StatefulWidget {
  const AddFundsPage({super.key});

  @override
  State<AddFundsPage> createState() => _AddFundsPageState();
}

class _AddFundsPageState extends State<AddFundsPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final addFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    validatePass(passValue) {
      RegExp uppercaseRegex = RegExp(r'[A-Z]');
      RegExp lowercaseRegex = RegExp(r'[a-z]');
      RegExp digitsRegex = RegExp(r'[0-9]');
      RegExp specialCharRegex = RegExp(r'[#\$%&*?@]');
      if (passValue == null || passValue.isEmpty) {
        return 'Input a valid password';
      } else if (passValue.length < 8) {
        return "Password must be at least 8 characters long.";
      } else if (!uppercaseRegex.hasMatch(passValue)) {
        return "Password must contain at least one uppercase letter.";
      } else if (!lowercaseRegex.hasMatch(passValue)) {
        return "Password must contain at least one lowercase letter.";
      } else if (!digitsRegex.hasMatch(passValue)) {
        return "Password must contain at least one number.";
      } else if (!specialCharRegex.hasMatch(passValue)) {
        return "Password must contain at least one special character (#\$%&*?@).";
      } else {
        return null;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Add Funds',
          style: GoogleFonts.hind(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [
                        0.6,
                        0.9,
                      ],
                      colors: [
                        Color(0xff29ABE2),
                        Color(0xff93278F),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 26),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/images/chip.png',
                              width: 23,
                              height: 16,
                            ),
                            Image.asset(
                              'assets/images/card_type.png',
                              width: 48,
                              height: 12,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '**** **** **** 2345',
                              style: GoogleFonts.hind(
                                letterSpacing: 3,
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Card Holder name',
                                  style: GoogleFonts.hind(
                                    // letterSpacing: 3,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  'Noman Manzoor',
                                  style: GoogleFonts.hind(
                                    // letterSpacing: 3,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Expiry Date',
                                    style: GoogleFonts.hind(
                                      // letterSpacing: 3,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    '02/30',
                                    style: GoogleFonts.hind(
                                      // letterSpacing: 3,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Form(
                  key: addFormKey,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 3),
                            child: Text(
                              'Amount to add',
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                // fontFamily: "DefaultFontFamily",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            enableSuggestions: true,
                            cursorColor: Theme.of(context).primaryColor,
                            style: GoogleFonts.hind(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            controller: amountController,
                            textAlignVertical: TextAlignVertical.center,
                            // textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.number,
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
                                    color: colorPrimary, width: 2.0),
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
                              hintText: 'e.g 1000',
                              filled: true,
                              fillColor: colorButton,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 22),
                              hintStyle: GoogleFonts.hind(
                                color: Color(0xff4A4A4A),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // validator: validateUsername,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                     
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 3),
                            child: Text(
                              'Password',
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                // fontFamily: "DefaultFontFamily",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                           TextFormField(
                        controller: passwordController,
                        textAlignVertical: TextAlignVertical.center,
                        obscureText: true,
                        obscuringCharacter: '*',
                        enableSuggestions: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.text,
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
                                color: colorPrimary, width: 2.0),
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
                          hintText: 'Password',
                          filled: true,
                          fillColor: colorButton,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 22),
                          hintStyle:  GoogleFonts.hind(
                            color: Color(0xff4A4A4A),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        validator: validatePass,
                      ),
                     ],
                      ),
                    
                    ],
                  ),
                ),
                  const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(400, 50),
                          backgroundColor: Theme.of(context).primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              88,
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.pushNamed(context, '/username');
                          // if (registerFormKey.currentState!.validate()) {
                          //   Navigator.popAndPushNamed(context, '/home');
                          // } else {
                          //   customErrorDialog(context, 'Invalid Email',
                          //       'Please enter valid email to finish creating an account');
                          // }
                        },
                        child:  Text(
                          'Add Funds',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.hind(
                            color: colorButton,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
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
