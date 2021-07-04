
//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/signin_page.dart';
import 'package:herewego/services/auth_service.dart';
import 'package:herewego/services/prefs_service.dart';
import 'package:herewego/services/utils_service.dart';

import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  static final String id="signup_page";
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var fullnameController=TextEditingController();


  _doSignUp() {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String fullname = fullnameController.text.toString().trim();
    if(fullname.isEmpty||email.isEmpty||password.isEmpty) return;
    AuthService.signUpUser(context, fullname, email, password).then((firebaseUser) =>
    {
      _getFirebaseUser(firebaseUser),

    });
  }


    _getFirebaseUser(FirebaseUser firebaseUser) async{
      await Prefs.saveUserId(firebaseUser.uid);
      if(firebaseUser!=null){
        Navigator.pushReplacementNamed(context, HomePage.id);
      }else{
        Utils.fireToast("Check your informations");


      }



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller:fullnameController ,
              decoration: InputDecoration(
                hintText: "Fullname",
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller:emailController ,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
            SizedBox(height: 10,),

            Container(
              width: double.infinity,
              height: 45,
              child: FlatButton(
                onPressed: (){
                  _doSignUp;

                },
                color: Colors.blue,
                child: Text("Sign In",style: TextStyle(color: Colors.white),),
              ),

            ),
            Container(
              width: double.infinity,
              height: 45,
              child: FlatButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, SignInPage.id);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Already have an account ?",style: TextStyle(color: Colors.black),),
                    SizedBox(width: 10,),
                    Text("Sign In",style: TextStyle(color: Colors.black),),
                  ],
                ),
              ),
            )

          ],
        ),

      ),

    );
  }
}
