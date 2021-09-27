import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task_loginui/screens/user_info_screen.dart';
import 'package:task_loginui/utils/authentication.dart';

final colorGreen = HexColor("#09b976");

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({ Key? key }) : super(key: key);

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSignInIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
      child: _isSignInIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            )
          : ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isSignInIn = true;
                });

                User? user =
                    await Authentication.signInWithGoogle(context: context);

                setState(() {
                  _isSignInIn = false;
                });

                if (user != null) {
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (context) => UserInfoScreen(
                  //       user: user,
                  //     )
                  //   )
                  // );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserInfoScreen(user: user)));
                }
              },
              child: SizedBox(
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Image(
                      //   image: AssetImage("assets/google_logo.png"),
                      //   height: 35.0,
                      // ),
                      Padding(
                        //padding: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          'Sign in with Google',
                          // style: TextStyle(
                          //     fontSize: 20,
                          //     color: Colors.black54,
                          //     fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(primary: colorGreen),
            ),
    );
  }
}