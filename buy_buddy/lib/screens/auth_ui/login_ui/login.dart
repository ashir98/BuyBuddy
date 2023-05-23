import 'package:buy_buddy/constants/constants.dart';
import 'package:buy_buddy/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:buy_buddy/screens/home/home.dart';
import 'package:buy_buddy/widgets/primary_btn.dart';
import 'package:buy_buddy/widgets/top_titles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/routes.dart';
import '../signup_ui/signup.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool isVisible = false;
class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Toptitles(
                  primary: "Login",
                  secondary: "Welcome back to BuyBuddy",
                ),
      
                const SizedBox(height: 25,),
      
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email'
                  ),
      
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  controller: passwordController,
                  obscureText: !isVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: "Password",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: Icon(isVisible? Icons.visibility_off_rounded:Icons.visibility_rounded),
                    )
                  ),
      
                ),
      
                const SizedBox(height: 15,),
      
      
                PrimaryButton(
                  onPressed: ()async{
                    bool isValidated= loginValidation(emailController.text, passwordController.text);
                    if(isValidated){
                     bool isLogined = await FireBaseAuthHelper.instance.login(emailController.text, passwordController.text, context);
                     if(isLogined){
                      Routes.pushAndRemoveUntill(HomeScreen(), context);
                      showMessage("User logged in");
                     }
                    }

                  },
                   title: "Login"
                ),
      
                const SizedBox(height: 15,),
      
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont have an account?",style: TextStyle(fontSize: size.width*0.045),),
                    CupertinoButton(
                      onPressed: (){
                        Routes.push(const SignUpScreen(), context);
                      }, 
                      child: const Text("SignUp")
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}