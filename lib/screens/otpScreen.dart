import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_loginui/utils/phoneVarification.dart';

FirebaseAuth _auth=FirebaseAuth.instance;

class OTPScreen extends StatefulWidget {
  const OTPScreen({ Key? key }) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpNumber = TextEditingController();

  signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredentail =
          await _auth.signInWithCredential(phoneAuthCredential);
          if(authCredentail.user!=null){
            // Go to page link
            print('object');
          }
    } on FirebaseAuthException catch (e) {

      throw e;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 80, left: 20),
        child: Column(
          children: [
            Form(
              child: TextFormField(
                controller: otpNumber,
                decoration: InputDecoration(labelText: 'Enter OTP'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                  onPressed: () async{
                    PhoneAuthCredential phoneAuthCredential =
                      await  PhoneAuthProvider.credential(
                            verificationId: verificationId1,
                            smsCode: otpNumber.text);

                    await signInWithPhoneAuthCredential(phoneAuthCredential);
                  },
                  child: Text('Submit')),
            ),
          ],
        ),
      ),
    );
  }
}
