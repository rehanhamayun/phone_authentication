import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_authentication/home_screen.dart';

class VerifyPhone extends StatefulWidget {
  final String verificationId;

  VerifyPhone({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Phone Number"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: "6 digit code",
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                loading = true;
              });
              final credential = PhoneAuthProvider.credential(
                verificationId: widget.verificationId,
                smsCode: phoneNumberController.text.toString(),
              );

              try {
                await auth.signInWithCredential(credential);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Homepage()));
              } catch (e) {
                setState(() {
                  loading = false;
                });
                CupertinoAlertDialog(
                  title: Text("Invalid code"),
                  content: Text("Input valid code"),
                );
              }
            },
            child: Text("Verify"),
          )
        ],
      ),
    );
  }
}
