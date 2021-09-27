import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task_loginui/screens/listdata.dart';
import 'package:task_loginui/screens/listusers.dart';
import 'package:task_loginui/screens/registerscreen.dart';
import 'package:task_loginui/utils/authentication.dart';
import 'package:task_loginui/utils/phoneVarification.dart';
import 'package:task_loginui/weatherscreen.dart';
import 'package:task_loginui/widgets/google_sign_in_button.dart';

final colorGreen = HexColor("#09b976");

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late String verificationId;

  final _formKey = GlobalKey<FormState>();

  TextEditingController mobileNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  void onSubmit(){
    if(_formKey.currentState!.validate())
      verifyPhoneNumber(mobileNumber.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          // Image Container
          Container(
            height: 220.0,
            child: Image.asset('assets/images/reward.jpg'),
          ),
          SizedBox(
            height: 50.0,
          ),
          Form(
            key: _formKey,
            child: CustomWidget(
              labeltext: 'Mobile Number',
              hinttext: 'Enter Mobile Number',
              icon: Icons.phone_android,
              controller: mobileNumber,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  //   verifyPhoneNumber(mobileNumber.text);
                  // }
                  onSubmit();
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  primary: colorGreen,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          FutureBuilder(
              future: Authentication.initializeFirebase(context: context),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error initializing Firebase');
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return GoogleSignInButton();
                }
                return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.orange,
                ));
              }),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account yet?"),
              Builder(
                  builder: (context) => TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: colorGreen),
                      ))),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
            child: Builder(
              builder: (context) => ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: colorGreen),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListData()));
                  },
                  child: Text('List')),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
            child: Builder(
              builder: (context) => ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListUsers()));
                  },
                  child: Text('Users List')),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
            child: Builder(
              builder: (context) => ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WeatherApi()));
                  },
                  child: Text('API Data')),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  const CustomWidget(
      {Key? key,
      required this.labeltext,
      required this.hinttext,
      required this.icon,
      required this.controller})
      : super(key: key);

  final String labeltext;
  final String hinttext;
  final IconData icon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 2.0,
        shadowColor: Colors.blue,
        child: TextFormField(
            controller: controller,
            style: TextStyle(
                color: colorGreen, fontWeight: FontWeight.bold, fontSize: 20.0),
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: labeltext,
              labelStyle: TextStyle(
                  color: Colors.grey[400], fontWeight: FontWeight.bold),
              hintText: hinttext,
              prefixIcon: Icon(
                icon,
                color: colorGreen,
              ),
              hintStyle: TextStyle(
                color: colorGreen,
              ),
              filled: true,
              fillColor: Colors.white70,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (labeltext == 'Mobile Number') {
                if (value == null || value.isEmpty) {
                  return 'Mobile Number is Empty';
                }
                return null;
              } else if (labeltext == 'Password') {
                if (value == null || value.isEmpty) {
                  return 'Password is Empty';
                }
                return null;
              }
            }),
      ),
    );
  }
}
