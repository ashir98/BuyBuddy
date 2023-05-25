
import 'package:buy_buddy/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:buy_buddy/screens/welcome/welcome.dart';
import 'package:buy_buddy/screens/home/home.dart';
import 'package:buy_buddy/themes/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BuyBuddy());
}


class BuyBuddy extends StatelessWidget {
  const BuyBuddy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BuyBuddy",
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FireBaseAuthHelper.instance.getAuthChange,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return const HomeScreen();
          }
          else{
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}