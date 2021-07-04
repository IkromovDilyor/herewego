

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/signup_page.dart';
import 'package:herewego/services/auth_service.dart';
import 'package:herewego/services/prefs_service.dart';
import 'package:herewego/services/utils_service.dart';

class SignInPage extends StatefulWidget {
  static final String id="signin_page";
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  _doSignIn() {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    if (email.isEmpty || password.isEmpty) return
      AuthService.signInUser(context, email, password).then((firebaseUser) =>
      {
        _getFirebaseUser(firebaseUser),

      });
  }
    _getFirebaseUser(FirebaseUser firebaseUser) async{
      await Prefs.saveUserId(firebaseUser.uid);
      if(firebaseUser!=null){
        Navigator.pushReplacementNamed(context, HomePage.id);
      }else{
        Utils.fireToast("Check your email or password");


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
                  _doSignIn();

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
                  Navigator.pushReplacementNamed(context, SignUpPage.id);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Don't have an account ?",style: TextStyle(color: Colors.black),),
                    SizedBox(width: 10,),
                    Text("Sign Up",style: TextStyle(color: Colors.black),),
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
