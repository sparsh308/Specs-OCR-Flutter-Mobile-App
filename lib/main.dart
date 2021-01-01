import 'package:OcrSpecs/widget/text_recognition_widget.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:OcrSpecs/login.dart';
import 'helperfunction.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool userisloggedin = false;
  @override
  void initState() {
    // TODO: implement initState
    getloginState();
    super.initState();
  }

  getloginState() async {
    await HelperFunction.GetuserLoggedInSharedPreference().then((value) {
      setState(() {
        {
          if (value != null) {
            userisloggedin = value;
          } else {
            userisloggedin = false;
          }
        }
      });
    });
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print("error");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              theme: ThemeData(
                primaryColor: Color(0xfff6315F5),
                accentColor: Color(0xfff5B51D8),
              ),
              builder: BotToastInit(), //1. call BotToastInit
              navigatorObservers: [BotToastNavigatorObserver()],
              debugShowCheckedModeBanner: false,
              home: userisloggedin ? MainPage() : LoginPage());
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}
