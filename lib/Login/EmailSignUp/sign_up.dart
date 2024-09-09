
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:yelle/Login/EmailSignUp/sign_up_service.dart';
import 'package:yelle/Login/intro_login_screen.dart';
import 'package:yelle/Login/login_state_class.dart';
import 'package:yelle/ReusableWidgets/custom_text_forms.dart';
import 'package:yelle/ReusableWidgets/gradient_button.dart';
import 'package:yelle/ReusableWidgets/text_form_validator.dart';
import 'package:yelle/home_screen.dart';
import '../../ReusableWidgets/sign_up_page_image_background.dart';
import '../../ReusableWidgets/sign_up_page_image_text.dart';
import '../../main.dart';

class SignUp extends StatefulWidget{
  const SignUp({super.key});

  @override
  SignUpState createState() => SignUpState();

}

class SignUpState extends State<SignUp>{

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();
  late SignUpService signUpProvider;

  @override
  void dispose(){
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();
    signUpProvider = context.watch<SignUpService>();
  }

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: Platform.isAndroid ? true : false,
      child: Scaffold(
          body: Stack(
            children: [
              const SignUpPageImageBackground(),
              const SignUpPageImageText(
                  mainHeading: "Sign Up",
                  subHeading:
                  "Please enter the below details to create an account."),

              Positioned.fill(
                top: screenHeight / 4.5,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
              child: Padding(
                padding:  const EdgeInsets.only(left: 20.0, top: 40),
                child: SingleChildScrollView(
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "First Name",
                          style: TextStyle(
                              fontFamily: 'Plus_Jakarta_Sans',
                              fontSize: screenWidth / 28.17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height:  10),
                       SizedBox(
                         width: screenWidth - 40,
                           child: CustomTextForms(
                               hideText: false,
                               hintText: 'Enter First Name', controller: firstNameController, icon: Icons.person, validator: TextFormValidator.validateName)),
                        const SizedBox(height:  20),
                        Text(
                          "Last Name",
                          style: TextStyle(
                              fontFamily: 'Plus_Jakarta_Sans',
                              fontSize: screenWidth / 28.17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height:  10),
                        SizedBox(
                          width: screenWidth - 40,
                            child: CustomTextForms(
                                hideText: false,
                                hintText: 'Enter Last Name', controller: lastNameController, icon: Icons.person, validator: TextFormValidator.validateName)),
                        const SizedBox(height:  20),
                        Text(
                          "Email Address",
                          style: TextStyle(
                              fontFamily: 'Plus_Jakarta_Sans',
                              fontSize: screenWidth / 28.17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const  SizedBox(height: 10),
                        SizedBox(
                            width: screenWidth - 40,
                            child: CustomTextForms(
                              hideText: false,
                              hintText: 'Enter email address',
                              controller: emailController,
                              icon: Icons.email,
                              validator: TextFormValidator.validateEmail,
                            )
                        ),
                        const  SizedBox(height: 20),
                        Text(
                          "Confirm Password",
                          style: TextStyle(
                              fontFamily: 'Plus_Jakarta_Sans',
                              fontSize: screenWidth / 28.17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const  SizedBox(height: 10),
                        SizedBox(
                            width: screenWidth - 40,
                            child:  CustomTextForms(
                              hideText: true,
                              hintText: 'Enter confirm password',
                              controller: passwordController,
                              icon: Icons.email,
                              validator: TextFormValidator.validatePassword,
                            )
                        ),
                        const SizedBox(height: 120),
                         Padding(
                          padding:  const EdgeInsets.only(left: 5.0),
                          child: InkWell(
                              onTap:  () async
                              {
                                    if(_signUpFormKey.currentState!.validate()) {

                                      await signUpProvider.startSigningUpProcess(
                                          firstNameController.text,
                                          lastNameController.text,
                                          emailController.text,
                                          passwordController.text);

                                      if (signUpProvider.state.state == LoginStateEnum.loggedIn
                                           && context.mounted) {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (
                                                context) => const HomeScreen()));
                                      }
                                      else if (signUpProvider.state.state == LoginStateEnum.error) {
                                        setState(() {
                                          Fluttertoast.showToast(
                                            msg: signUpProvider.state.errorMessage!,
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            textColor: Colors.white,
                                            backgroundColor: Colors.red,
                                            fontSize: 14.0,
                                          );
                                        });
                                      }
                                    }
                              },
                              child: signUpProvider.state.state == LoginStateEnum.loading ? const Center(child: CircularProgressIndicator(strokeWidth: 7, color: Colors.black,)) : const GradientButton(text: 'Sign Up',)
                        ),
                         ),
                        const SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                    fontFamily: 'Plus_Jakarta_Sans',
                                    fontSize: screenWidth / 28.17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              ShaderMask( shaderCallback: (bounds) => const LinearGradient(
                                colors: [
                                  Color(0xFFFE9900),  // Start color
                                  Color(0xFFFFBE00),  // End color
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                                child: InkWell(
                                  onTap: ()
                                  {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const IntroLoginScreen()));
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontFamily: 'Plus_Jakarta_Sans',
                                      fontSize: screenWidth / 28.17,
                                      color: Colors.white, // This color will be replaced by the gradient
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),)
                            ]
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ))
          ],
          ),
      ),
    );
  }
}
