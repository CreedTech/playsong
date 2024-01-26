import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../constants/country_codes.dart';
import '../../custom_widgets/gradient_containers.dart';

import '../../theme/app_theme.dart';

class CountrySelectionPage extends StatefulWidget {
  const CountrySelectionPage({super.key});

  @override
  State<CountrySelectionPage> createState() => _CountrySelectionPageState();
}

class _CountrySelectionPageState extends State<CountrySelectionPage> {
  TextEditingController countryController = TextEditingController();
  final countryFormKey = GlobalKey<FormState>();
  String _selectedCountryCode = 'AF';
  String countryName = 'Choose Your Country';
  List<String> languages = [
    'English',
    'Hindi',
    'Punjabi',
    'Tamil',
    'Telugu',
    'Marathi',
    'Gujarati',
    'Bengali',
    'Kannada',
    'Bhojpuri',
    'Malayalam',
    'Urdu',
    'Haryanvi',
    'Rajasthani',
    'Odia',
    'Assamese',
  ];
  List<bool> isSelected = [true, false];
  List preferredLanguage = Hive.box('settings')
      .get('preferredLanguage', defaultValue: ['English'])?.toList() as List;
  String region =
      Hive.box('settings').get('region', defaultValue: 'Nigeria') as String;

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
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
                      'Choose your Country',
                      style: GoogleFonts.hind(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * 0.15,
                            // ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Form(
                                      key: countryFormKey,
                                      child: TextFormField(
                                        onTap: () {
                                          showModalBottomSheet(
                                            isDismissible: true,
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (BuildContext context) {
                                              List<String> countryCodes =
                                                  CountryCodes.countries
                                                      .map((country) =>
                                                          country['code']!)
                                                      .toList();
                                              List<String> countries =
                                                  CountryCodes.countries
                                                      .map((country) =>
                                                          country['name']!)
                                                      .toList();

                                              return BottomGradientContainer(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                child: ListView.builder(
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                    0,
                                                    10,
                                                    0,
                                                    10,
                                                  ),
                                                  itemCount: countries.length,
                                                  itemBuilder: (context, idx) {
                                                    return ListTileTheme(
                                                      selectedColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .secondary,
                                                      child: ListTile(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 25.0,
                                                          right: 25.0,
                                                        ),
                                                        title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CountryFlag
                                                                .fromCountryCode(
                                                              countryCodes[idx],
                                                              width: 18,
                                                              height: 18,
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.4,
                                                              child: Text(
                                                                countries[idx],
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        leading: Radio<String>(
                                                          value: countries[idx],
                                                          groupValue: region,
                                                          onChanged:
                                                              (String? value) {
                                                            region = value!;
                                                            Hive.box('settings')
                                                                .put('region',
                                                                    region);
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {
                                                              _selectedCountryCode =
                                                                  countryCodes[
                                                                      idx];
                                                              countryName =
                                                                  countries[
                                                                      idx];
                                                            });
                                                            print(
                                                                _selectedCountryCode);
                                                          },
                                                        ),
                                                        selected: region ==
                                                            countries[idx],
                                                        onTap: () {
                                                          region =
                                                              countries[idx];
                                                          Hive.box('settings')
                                                              .put(
                                                            'region',
                                                            region,
                                                          );
                                                          Navigator.pop(
                                                            context,
                                                          );

                                                          setState(() {});
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        readOnly: true,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        enableSuggestions: true,
                                        cursorColor:
                                            Theme.of(context).primaryColor,
                                        style: GoogleFonts.hind(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),

                                        controller: countryController,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        // textCapitalization: TextCapitalization.sentences,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: const BorderSide(
                                              color: Color(0xff1E1E1E),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: const BorderSide(
                                              color: Color(0xff1E1E1E),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: const BorderSide(
                                              color: Color(0xff1E1E1E),
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 2.0,
                                            ), // Change color to yellow
                                          ),
                                          prefixIcon: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              decoration: BoxDecoration(
                                                color: const Color(0xff242424),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child:
                                                  CountryFlag.fromCountryCode(
                                                _selectedCountryCode,
                                                width: 30,
                                                height: 30,
                                                borderRadius: 5,
                                              ),
                                            ),
                                          ),
                                          suffixIcon: const Icon(Icons
                                              .keyboard_arrow_down_outlined),
                                          hintText: countryName,
                                          labelStyle: GoogleFonts.hind(
                                            // fontFamily: 'Milliard',
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff4A4A4A),
                                          ),
                                          filled: true,
                                          fillColor: colorButton,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 24, vertical: 22),
                                          hintStyle:  GoogleFonts.hind(
                                            color: Color(0xff4A4A4A),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/select_artist',
                                  (route) => false,
                                );
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
                                  // fontFamily: 'Milliard',
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
