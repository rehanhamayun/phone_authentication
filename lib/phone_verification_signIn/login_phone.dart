import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:phone_authentication/phone_verification_signIn/verify_code.dart';

String selectedCountry = "";

class SignInWithPhoneNumber extends StatefulWidget {
  const SignInWithPhoneNumber({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInWithPhoneNumber> createState() => _SignInWithPhoneNumberState();
}

class _SignInWithPhoneNumberState extends State<SignInWithPhoneNumber> {
  String countryCode = "";
  @override
  //
  final phoneNumberController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  //
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignIn with Phone Number"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: TextButton(
                onPressed: () {
                  showCountryPicker(
                      context: context,
                      showPhoneCode: true,
                      countryListTheme: CountryListThemeData(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(10)),
                          inputDecoration: InputDecoration(
                            hintText: 'Start typing to sear',
                            labelText: 'Search ',
                          )),
                      favorite: ['PK'],
                      onSelect: (Country value) {
                        print(value.countryCode.toString());
                        print("+" + value.phoneCode.toString());

                        countryCode = value.phoneCode.toString();

                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInWithPhoneNumber()));
                      });
                },
                child: Text('Tap')),
          ),
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: " ${"+" + countryCode}",
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.purple,
            ),
            onPressed: () {
              setState(() {
                loading = true;
              });
              auth.verifyPhoneNumber(
                  phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_) {
                    setState(() {
                      loading = false;
                    });
                  },
                  verificationFailed: (e) {
                    setState(() {
                      loading = false;
                    });
                    e.toString();
                  },
                  codeSent: (String verificationId, int? token) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyPhone(
                                  verificationId: verificationId,
                                )));
                    setState(() {
                      loading = false;
                    });
                  },
                  codeAutoRetrievalTimeout: (e) {
                    e.toString();
                    setState(() {
                      loading = false;
                    });
                  });
            },
            child: Text("Login"),
          )
        ],
      ),
    );
  }
}
