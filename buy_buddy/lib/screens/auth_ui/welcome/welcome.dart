
import 'package:buy_buddy/constants/asset_images.dart';
import 'package:buy_buddy/constants/routes.dart';
import 'package:buy_buddy/widgets/primary_btn.dart';
import 'package:buy_buddy/widgets/top_titles.dart';

import 'package:flutter/material.dart';

import '../login_ui/login.dart';
import '../signup_ui/signup.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:   const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Toptitles(
                primary: "Welcome",
                secondary: "Selling only the best things online",
              ),

              const SizedBox(height: 25,),

              Center(
                child: Image.asset(
                  AssetImages().welcomeImage,
                  width: size.width*0.8,
                ),
              ),
              const SizedBox(height: 100,),

              PrimaryButton(
                onPressed: () {
                  Routes.push(const LoginScreen(), context);
                },
                title: "Login",
              ),


              const SizedBox(height: 10,),
              
              PrimaryButton(
                onPressed: () { 
                  Routes.push(const SignUpScreen(), context);  
                },
                title: "SignUp",
              )




            ],
          ),
        ),
      ),
    );
  }
}