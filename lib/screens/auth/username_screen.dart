import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_theme.dart';

class UsernamePage extends StatefulWidget {
  const UsernamePage({super.key});

  @override
  State<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  TextEditingController usernameController = TextEditingController();
  final usernameFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    validateUsername(usernameValue) {
      bool hasSpecial =
          usernameValue.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      if (usernameValue.isEmpty) {
        return 'username cannot be empty';
      }

      // if ((usernameController.text.trim().replaceAll(',', '')).length < 7) {
      //   return 'username must contain at least 7 characters';
      // }
      if (hasSpecial) {
        return 'username cannot include special character';
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
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Stack(
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Image.asset(
                          'assets/images/playsong_logo.png',
                          width: 64,
                        ),
                        Text(
                          'Input a Username',
                          style: GoogleFonts.hind(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Form(
                          key: usernameFormKey,
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            enableSuggestions: true,
                            cursorColor: Theme.of(context).primaryColor,
                            style: GoogleFonts.hind(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            controller: usernameController,
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
                              hintText: 'Choose new username',
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
                            validator: validateUsername,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    // const Spacer(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
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
                        Navigator.pushNamed(context, '/country');
                        // if (registerFormKey.currentState!.validate()) {
                        //   Navigator.popAndPushNamed(context, '/home');
                        // } else {
                        //   customErrorDialog(context, 'Invalid Email',
                        //       'Please enter valid email to finish creating an account');
                        // }
                      },
                      child: Text(
                        'Continue',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.hind(
                          color: colorButton,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
