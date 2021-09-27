import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task_loginui/utils/phoneVarification.dart';
import 'package:task_loginui/weatherscreen.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

final colorGreen = HexColor("#09b976");

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpNumber = TextEditingController();

  phoneCredential() async {
    PhoneAuthCredential phoneAuthCredential =
        await PhoneAuthProvider.credential(
            verificationId: verificationId1, smsCode: otpNumber.text);

    await signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredentail =
          await _auth.signInWithCredential(phoneAuthCredential);
      if (authCredentail.user != null) {
        // Go to page link
        print('object');
        Get.to(WeatherApi());
      }
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 220.0,
            child: Image.asset('assets/images/reward.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Form(
              child: TextFormField(
                controller: otpNumber,
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                  hintText: 'OTP Number'
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: colorGreen
              ),
              onPressed: () {
                phoneCredential();
              },
              child: Text('Enter'),
            ),
          )
        ],
      ),
    );
  }
}
