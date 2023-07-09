
import 'package:buy_buddy/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:buy_buddy/provider/app_provider.dart';
import 'package:buy_buddy/screens/custom_navbar/custom_navbar.dart';
import 'package:buy_buddy/screens/splash_screen/splash_screen.dart';
import 'package:buy_buddy/screens/welcome/welcome.dart';
import 'package:buy_buddy/themes/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BuyBuddy());
}


class BuyBuddy extends StatelessWidget {
  const BuyBuddy({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: "BuyBuddy",
        theme: lightTheme(),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FireBaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Splash(screen: CustomBottomNavBar());
            }
            else{
              return Splash(screen: WelcomeScreen());
            }
          },
        ),
      ),
    );
  }
}