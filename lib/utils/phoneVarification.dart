import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:task_loginui/screens/otpScreen.dart';

var verificationId1;

final Future<FirebaseApp> initialization=Firebase.initializeApp();
FirebaseAuth auth=FirebaseAuth.instance;

Future<void> verifyPhoneNumber(String phone)async{

  await auth.verifyPhoneNumber(
    phoneNumber: phone,
    verificationCompleted: (PhoneAuthCredential credential){
        
    },
   verificationFailed: (FirebaseException e){
     if(e.code=='invalid-phone-number'){
       print('The provided phone number is not valid');
     }
   },
    codeSent: (String verificationId,int? resendToken)async{

      verificationId1=await verificationId;
      if(verificationId1!=null){
        print('verificationid');
        print(verificationId);
              Get.to(OTPScreen());
      }
    
      
    },
    timeout: Duration(seconds: 120),
   codeAutoRetrievalTimeout:(String verificationId){

   }
   );
  
}