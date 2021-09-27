import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_loginui/screens/otpScreen.dart';

var verificationId1;

FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> verifyPhoneNumber(String phone) async {
  
  //print('Mobile number is $phone');

  await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {
        // auth.signInWithPhoneNumber(credential.toString()).then((value) =>
        // print('you are sign in with number')
        // );
      },
      verificationFailed: (FirebaseException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        if (verificationId1 != null) {
          print('Verification ID: $verificationId');
          print('Verification1 ID: $verificationId1');
          Get.to(OTPScreen());
        }
      },
      timeout: Duration(seconds: 120),
      codeAutoRetrievalTimeout: (String verificationId) {});
}
