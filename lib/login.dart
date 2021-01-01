import 'package:bot_toast/bot_toast.dart';
import 'package:OcrSpecs/fadeanimation.dart';
import 'package:OcrSpecs/auth.dart';
import 'package:OcrSpecs/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'helperfunction.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();

  signinwithgoogle() {
    authMethods.signInWithGoogle().then((value) {
      print(value);
      HelperFunction.saveuserLoggedInSharedPreference(true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      FadeAnimation(
                        1.5,
                        Text("Welcome",
                            style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w600))),
                      ),
                      FadeAnimation(
                        1.5,
                        Text("to",
                            style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600))),
                      ),
                      FadeAnimation(
                        1.5,
                        Text("SpecsOCR Scanner",
                            style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        1.6,
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, right: 40),
                          child: Image.asset(
                            "assets/3d-glasses.png",
                            height: 100,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        1.5,
                        Text("Photo to Text Conversion with OCR",
                            style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        1.6,
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, right: 40),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            elevation: 0.3,
                            height: 50,
                            onPressed: () {
                              signinwithgoogle();
                            },
                            color: Colors.white,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/google.png',
                                    height: 35,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Sign in with Google",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                        1.6,
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, right: 40),
                          child: Image.asset(
                            "assets/translate.png",
                            height: 100,
                          ),
                        ),
                      ),
                      FadeAnimation(
                        1.5,
                        Text("With Google Translate",
                            style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600))),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
