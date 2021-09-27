import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task_loginui/database/sql_helper.dart';

final colorGreen = HexColor("#09b976");

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            height: 350.0,
            child: Image.asset('assets/images/reward.jpg'),
          ),
          Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomWidget(
                      labeltext: 'Name',
                      hinttext: 'Enter your name',
                      icon: Icons.person,
                      controller: name),
                  CustomWidget(
                      labeltext: 'Email',
                      hinttext: 'Enter your Email',
                      icon: Icons.email,
                      controller: email),
                  CustomWidget(
                      labeltext: 'Mobile Number',
                      hinttext: 'Enter your Mobile Number',
                      icon: Icons.phone_android,
                      controller: mobile),
                  CustomWidget(
                      labeltext: 'Password',
                      hinttext: 'Enter your Password',
                      icon: Icons.lock,
                      controller: password),
                  CustomWidget(
                      labeltext: 'Confirm Password',
                      hinttext: 'Enter your Confirm Password',
                      icon: Icons.person,
                      controller: confirmpassword),
                ],
              ),
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
                  if(_formKey.currentState!.validate()) {
                    print('Everything OK');
                  }
                },
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                  primary: colorGreen,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?"),
              Builder(
                  builder: (context) => TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: colorGreen),
                      ))),
            ],
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
      child: TextFormField(
        controller: controller,
        style: TextStyle(
            color: colorGreen, fontWeight: FontWeight.bold, fontSize: 20.0),
        decoration: InputDecoration(
            labelText: labeltext,
            labelStyle: TextStyle(color: Colors.grey),
            hintText: hinttext,
            hintStyle: TextStyle(color: colorGreen),
            prefixIcon: Icon(
              icon,
              color: colorGreen,
            ),
            border: InputBorder.none),
        validator: (value) {
          if (labeltext == 'Name') {
            if (value == null || value.isEmpty) {
              return 'Name can not be empty';
            } else if (value.length < 5) {
              return 'Name is short';
            }
            return null;
          } else if (labeltext == 'Email') {
            if (value == null || value.isEmpty) {
              return 'Email can not be empty';
            } else if (!value.contains('@')) {
              return 'Invalid Email';
            }
          } else if (labeltext == 'Mobile Number') {
            if(value == null || value.isEmpty) {
              return 'Mobile number can not be empty';
            }
            return null;
          } else if (labeltext == 'Password') {
            if(value == null || value.isEmpty) {
              return 'Password can not be empty';
            }
            return null;
          } else if (labeltext == 'Confirm Password') {
            if(value == null || value.isEmpty) {
              return 'Confirm Password can not be empty';
            }
            return null;
          }
        },
      ),
    );
  }
}

Future<void> checkMobile(String txtName, String txtEmail, String txtMobile,
    String txtPassword, String txtConfirmpassword) async {
  List<Map<String, dynamic>> _users = [];
  // Check mobile number
  final data = await SQLHelper.searchMobile(txtMobile);
  _users = data;
  int l = _users.length;
  if (l == 1) {
    print('Mobile already exist!');
  } else {
    // Insert a new users to the database
    await SQLHelper.createItem(txtName, txtEmail, txtMobile, txtPassword);
    print('Account created');
    txtName = '';
    txtEmail = '';
    txtMobile = '';
    txtPassword = '';
    txtConfirmpassword = '';
  }
}

Future<void> formValidate(String txtName, String txtEmail, String txtMobile,
    String txtPassword, String txtConfirmpassword) async {
  if (txtName.isEmpty) {
    print('Name can not be empty');
  } else if (txtName.length < 5) {
    print('Name is Short');
  } else if (txtEmail.isEmpty) {
    print('Email can not be empty');
  } else if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(txtEmail) ==
      false) {
    print('Enter Valid Email');
  } else if (txtMobile.isEmpty) {
    print('Mobile number can not be empty');
  } else if (txtMobile.length < 10) {
    print('Enter Valid Mobile Number');
  } else if (txtPassword.isEmpty || txtConfirmpassword.isEmpty) {
    print('Password and confirm password can not be empty');
  } else if (!txtPassword.endsWith(txtConfirmpassword)) {
    print('Enter same password in password and confirm password');
  } else {
    checkMobile(txtName, txtEmail, txtMobile, txtPassword, txtConfirmpassword);
  }
}
