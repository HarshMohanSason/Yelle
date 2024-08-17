import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yelle/Login/otp_form.dart';
import 'package:yelle/main.dart';

class PhoneTextForm extends StatefulWidget {
  const PhoneTextForm({super.key});

  @override
  PhoneTextFormState createState() => PhoneTextFormState();
}

class PhoneTextFormState extends State<PhoneTextForm> {
  TextEditingController phoneTextFormController = TextEditingController(); //controller for the phoneNumberText
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: Platform.isAndroid ? true : false,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
            child: Center(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: screenWidth / 12,
                          ))),
                  const SizedBox(height: 20),
                  Text(
                    "Please enter your phone number",
                    style: TextStyle(
                        fontSize: screenWidth / 11,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 100),
                  Form(
                      key: _formKey,
                      child: phoneTextForm()),
                  const Spacer(),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: nextButton()),
                ],
              ),
            ),
          )),
    );
  }

  Widget phoneTextForm() {
    return SizedBox(
      width: screenWidth - 20,
      child: TextFormField(
          keyboardType: TextInputType.number,
          maxLength: 10,
          cursorColor: Colors.black,
          cursorWidth: 3,
          controller: phoneTextFormController,
          style: TextStyle(
              fontSize: screenWidth / 18,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: '+91',
            hintStyle: TextStyle(
              fontSize: screenWidth / 20,
              color:
                  Colors.grey, // Change the hint text color to your preference
            ),
            helperText: 'Enter your phone number',
            helperStyle: TextStyle(
              fontSize: screenWidth / 25,
              color: Colors
                  .grey, // Change the helper text color to your preference
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(
                    0.5), // Change the border color to your preference
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.5),
                // Change the focused border color to your preference
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.red,
                // Change the error border color to your preference
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.red,
                // Change the focused error border color to your preference
                width: 2,
              ),
            ),
          ),
          validator: (text) {
            final nonNumericRegExp =
                RegExp(r'^[0-9]+$'); //RegExp to match the phone number
            if (text!.isEmpty) {
              //return an error if the textForm is not empty
              return 'Phone number cannot be empty';
            }
            //check if the number isWithin 0-9.
            if (!nonNumericRegExp.hasMatch(text)) {
              return 'Phone number must contain only digits'; //
            }
            if (text.length <
                10) //Make sure the number is a total of 10 digits.
            {
              return 'Number should be a ten digit number';
            }
            return null;
          }),
    );
  }

  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        if(_formKey.currentState!.validate()) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OtpForm(
                        phoneNumber: phoneTextFormController.text,
                      )));
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: colorTheme,
        // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 8,
        // This adds a shadow
        shadowColor: Colors.black.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: SizedBox(
        width: screenWidth - 30,
        child: const Center(
          child: Text(
            'Next',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
