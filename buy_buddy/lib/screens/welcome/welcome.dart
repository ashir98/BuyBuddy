
import 'package:buy_buddy/utils/app_colors.dart';
import 'package:buy_buddy/utils/asset_images.dart';
import 'package:buy_buddy/utils/constants.dart';
import 'package:buy_buddy/utils/routes.dart';


import 'package:flutter/material.dart';

import '../auth_screens/login_ui/login.dart';
import '../auth_screens/signup_ui/signup.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding:   const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Center(
                child: Image.asset(
                  AssetImages().appLogo,
                  width: size.width * 0.8,
                ),
              ),
            ),

            Text("Welcome to BuyBuddy!",style: TextStyle(fontSize: size.width*0.08, fontWeight: FontWeight.w600),),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Text(
              AppConstants.aboutApp,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: size.width*0.045,
                color: AppColor.subTitleColor
              ),
            ),


           const SizedBox(height: 70,),

            SizedBox(
              height: 50,
              width: size.width,
              child: ElevatedButton(
                onPressed: () {
                  Routes.push(const LoginScreen(), context);
                },
                
                child: const Text("Login",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
            ),


            const SizedBox(height: 10,),
            
            SizedBox(
              height: 50,
              width: size.width,
              child: OutlinedButton(
                onPressed: () { 
                  Routes.push(const SignUpScreen(), context);  
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColor.scaffoldColor,
                  side: BorderSide(color: AppColor.secondaryColor, width: 1.5)
                ),
                child: Text("SignUp",style: TextStyle(color: AppColor.secondaryColor, fontWeight: FontWeight.bold),),
              ),
            )




          ],
        ),
      ),
    );
  }
}