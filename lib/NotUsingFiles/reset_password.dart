
import 'package:flutter/material.dart';
import 'package:yelle/ReusableWidgets/custom_text_forms.dart';
import 'package:yelle/ReusableWidgets/gradient_button.dart';
import 'package:yelle/ReusableWidgets/text_form_validator.dart';
import 'package:yelle/main.dart';
import '../ReusableWidgets/sign_up_page_image_background.dart';
import '../ReusableWidgets/sign_up_page_image_text.dart';

class ResetPassword extends StatefulWidget{
  const ResetPassword({super.key});


  @override
  ResetPasswordState createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword>{
  @override

  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
            const SignUpPageImageBackground(),
            const  SignUpPageImageText(
              mainHeading: "Reset Password",
              subHeading:
              "Please reset your password by entering your new password"),
            Positioned.fill(
              top: screenHeight/4.5, child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
            child: Padding(
              padding:  const EdgeInsets.only(left: 20.0, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New Password",
                    style: TextStyle(
                        fontFamily: 'Plus_Jakarta_Sans',
                        fontSize: screenWidth / 28.17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                 const SizedBox(height: 10),
                 SizedBox(
                     width: screenWidth - 40,
                     child: const CustomTextForms(
                         hideText: false,
                         hintText: 'Enter new password',
                         icon: Icons.lock,
                         validator: TextFormValidator.validateEmail)),
                  const SizedBox(height: 50),
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: GradientButton(text: 'Reset'),
                  )
                ],
              ),
            ),),
            )
        ],
      ),
    );
  }
}