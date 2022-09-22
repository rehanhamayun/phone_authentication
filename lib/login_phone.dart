import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phone_authentication/verify_code.dart';

class SignInWithPhoneNumber extends StatefulWidget {
  const SignInWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<SignInWithPhoneNumber> createState() => _SignInWithPhoneNumberState();
}

class _SignInWithPhoneNumberState extends State<SignInWithPhoneNumber> {
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
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "+92 xxx xxxxxxx",
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
