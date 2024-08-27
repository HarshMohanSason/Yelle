import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:yelle/Login/password_reset_service.dart';
import 'package:yelle/ReusableWidgets/gradient_button.dart';
import 'package:yelle/ReusableWidgets/sign_up_page_image_background.dart';
import 'package:yelle/ReusableWidgets/sign_up_page_image_text.dart';
import '../ReusableWidgets/custom_text_forms.dart';
import '../ReusableWidgets/text_form_validator.dart';
import '../main.dart';

class ForgotPassowrdUi extends StatefulWidget {
  const ForgotPassowrdUi({super.key});

  @override
  ForgotPasswordUiState createState() => ForgotPasswordUiState();
}

class ForgotPasswordUiState extends State<ForgotPassowrdUi> {
  TextEditingController emailController = TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();
  late final PasswordResetService passwordResetServiceProvider;

  @override
  void dispose()
  {
    emailController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();
    passwordResetServiceProvider = context.watch<PasswordResetService>();
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: Platform.isAndroid ? true : false,
      child: Scaffold(
          body: Stack(children: [
        const SignUpPageImageBackground(),
        const SignUpPageImageText(
            mainHeading: "Forgot Password",
            subHeading:
                "Please enter your email address and we will send you a one-time password(OTP)."),
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
              child: Form(
                key: _signUpFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          controller: emailController,
                          hideText: false,
                          hintText: 'Enter email address',
                          icon: Icons.email,
                          validator: TextFormValidator.validateEmail,
                        )
                    ),
                 const SizedBox(height: 50),
                 Padding(
                   padding: const EdgeInsets.only(left: 5),
                     child: InkWell(
                       onTap: () async{

                         if(_signUpFormKey.currentState!.validate())
                           {
                             await passwordResetServiceProvider.sendOTPToEmailAddress(emailController.text);
                             if(passwordResetServiceProvider.isSent && context.mounted)
                               {
                                 setState(() {
                                   Fluttertoast.showToast(
                                     msg: 'A link was sent to your email, once reset, please return back to the login page',
                                     toastLength: Toast.LENGTH_LONG,
                                     gravity: ToastGravity.CENTER,
                                     textColor: Colors.white,
                                     backgroundColor: Colors.green,
                                     fontSize: 14.0,
                                   );
                                 });
                               }
                             else if(passwordResetServiceProvider.errorMessage != null)
                               {
                                 setState(() {
                                   Fluttertoast.showToast(
                                     msg: passwordResetServiceProvider.errorMessage!,
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
                         child:  passwordResetServiceProvider.isLoading ? const Center(child: CircularProgressIndicator(strokeWidth: 7, color: Colors.black,)) : const GradientButton(text: 'Send'))),
                 const Spacer(),
                    Padding(
                      padding: const  EdgeInsets.only(bottom : 40),
                      child: Center(
                        child: InkWell(
                          onTap: ()
                          {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Back to login",
                            style: TextStyle(
                                fontFamily: 'Plus_Jakarta_Sans',
                                fontSize: screenWidth / 28.17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),)
        )
      ])
      ),
    );
  }
}
