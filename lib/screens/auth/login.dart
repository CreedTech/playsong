import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final registerFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    validateMail(emailValue) {
      if (emailValue == null || emailValue.isEmpty) {
        return 'Please enter an email address.';
      }
      if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
          .hasMatch(emailValue)) {
        return 'Please enter a valid email address.';
      }

      return null;
    }

    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 70,
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Image.asset(
                  'assets/images/playsong_logo.png',
                  width: 64,
                ),
                Text(
                  'Log in to PlaySong',
                  style: GoogleFonts.hind(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  key: registerFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        enableSuggestions: true,
                        cursorColor: Theme.of(context).primaryColor,
                        style: GoogleFonts.hind(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        controller: emailController,
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
                          hintText: 'Email Address or Username',
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
                        // validator: validateMail,
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 226),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: colorButton,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              'assets/icons/google.png',
                              width: 31,
                              height: 31,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: colorButton,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              'assets/icons/facebook.png',
                              width: 31,
                              height: 31,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: colorButton,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              'assets/icons/apple.png',
                              width: 31,
                              height: 31,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: colorButton,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              'assets/icons/twitter.png',
                              width: 31,
                              height: 31,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
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
                          Navigator.pushNamed(context, '/home');
                          // if (registerFormKey.currentState!.validate()) {
                          //   Navigator.popAndPushNamed(context, '/home');
                          // } else {
                          //   customErrorDialog(context, 'Invalid Email',
                          //       'Please enter valid email to finish creating an account');
                          // }
                        },
                        child: Text(
                          'Log in',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
