
// ignore_for_file: use_build_context_synchronously

import 'package:buy_buddy/constants/constants.dart';
import 'package:buy_buddy/constants/routes.dart';
import 'package:buy_buddy/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:buy_buddy/widgets/primary_btn.dart';
import 'package:buy_buddy/widgets/top_titles.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login_ui/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isVisible = false;
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
                  primary: "SignUp",
                  secondary: "Welcome back to BuyBuddy",
                ),
      
                const SizedBox(height: 25,),
                
      
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    labelText: 'Name'
                  ),
      
                ),
                const SizedBox(height: 15,),

                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone_outlined),
                    labelText: 'Phone'
                  ),
      
                ),  
                const SizedBox(height: 15,),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: 'Email'
                  ),
      
                ),                   
                const SizedBox(height: 15,),
                TextFormField(
                  controller: passwordController,
                  obscureText: !isVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    labelText: "Create password",
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

                    bool isValidated = signUpValidation(emailController.text, passwordController.text, nameController.text, phoneController.text);
                    if(isValidated){
                      bool isSignedUp = await FireBaseAuthHelper.instance.signUp(emailController.text, passwordController.text, context);
                      if(isSignedUp){
                        Routes.push(const LoginScreen(), context);
                        showMessage("Account created sucessfully!");
                      }
                    }
                  },
                   title: "Create an account"
                ),
      
                const SizedBox(height: 15,),
      
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",style: TextStyle(fontSize: size.width*0.045),),
                    CupertinoButton(
                      onPressed: (){
                        Routes.pushAndRemoveUntill(const LoginScreen(), context);
                      }, 
                      child: const Text("Login")
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