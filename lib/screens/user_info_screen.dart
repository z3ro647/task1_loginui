import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task_loginui/main.dart';
import 'package:task_loginui/utils/authentication.dart';

final colorGreen = HexColor("#09b976");

class CustomColors {
  static final Color firebaseNavy = Color(0xFF2C384A);
  static final Color firebaseOrange = Color(0xFFF57C00);
  static final Color firebaseAmber = Color(0xFFFFA000);
  static final Color firebaseYellow = Color(0xFFFFCA28);
  static final Color firebaseGrey = Color(0xFFECEFF1);
  static final Color googleBackground = Color(0xFF4285F4);
}

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({ Key? key, required User user }) : _user = user, super(key: key);

  final User _user;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late User _user;
  bool _isSigningOut = false;

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // iconTheme: IconThemeData(
        //   color: Colors.black,
        // ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 220.0,
            child: Image.asset('assets/images/reward.jpg'),
          ),
          SizedBox(height: 20.0,),
          SizedBox(
            height: 100.0,
            child: Image.network(_user.photoURL!),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: Center(child: Text('${_user.email!}')),
          ),
          SizedBox(
            height: 20.0,
          ),
          _isSigningOut
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 40.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: colorGreen),
                    onPressed: () async {
                      setState(() {
                        _isSigningOut = true;
                      });

                      await Authentication.signOut(context: context);

                      setState(() {
                        _isSigningOut = false;
                      });
                      //Navigator.of(context).pushReplacement(_routeToSignInScreen());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}