import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:phone_authentication/login_phone.dart';

class CountryCodePicker extends StatefulWidget {
  const CountryCodePicker({Key? key}) : super(key: key);

  @override
  State<CountryCodePicker> createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  String countryCode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(countryCode.toString()),
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
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "${"+" + countryCode}",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
