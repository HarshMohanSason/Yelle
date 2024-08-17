
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:yelle/home_screen.dart';
import '../main.dart';

class OtpForm extends StatefulWidget{

  final String phoneNumber;
  const OtpForm({super.key,required this.phoneNumber});

  @override
  OtpFormState createState() => OtpFormState();

}

class OtpFormState extends State<OtpForm>{
  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: Platform.isAndroid ? true : false,
      child:  Scaffold(
      backgroundColor: colorTheme,
        body: Padding(
          padding: const  EdgeInsets.only(top: 50, left: 10, right: 10),
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
                 const SizedBox(height: 40),
            Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  text: 'Enter your code',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold, // Default text color
                    fontSize: screenHeight / 24, // Default text size
                  ),
                ),
                        ),
            ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                text: '+91 ${widget.phoneNumber}',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Default text color
                  fontSize: screenHeight / 35, // Default text size
                ),
              ),
            ),
          ),

                const SizedBox(height: 100),
                _pinInputUI(context),
              ],
            ),
          ),
        ),

      ),
    );
  }

  Widget _pinInputUI(BuildContext context) {
    return SizedBox(
      width: screenWidth - 20,
      child: Pinput(
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          //controller: otpTextController,
          length: 6,
          // Length for the OTP being entered
          defaultPinTheme: PinTheme(
            width: 100,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                  21), // Adjust the border radius as needed
            ),
            textStyle: TextStyle(
              fontSize: screenWidth / 15,
              color: Colors.black, // White text color for better visibility
              fontWeight: FontWeight.bold,
            ),
          ),
          errorTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          onCompleted: (value) async {

            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
          },
          validator: (value) {
            final nonNumericRegExp = RegExp(r'^[0-9]');
            if (value!.isEmpty == true) {
              return 'OTP cannot be empty';
            }
            //check if the number isWithin 0-9 and is lowercase
            else if (!nonNumericRegExp.hasMatch(value)) {
              return 'OTP can only contain digits'
                  ; //return error if it doesn't match the REGEXP
            } else if (value.length < 6) {
              return 'OTP should be 6 digit number';
            }
            return null;
          }),
    );
  }

}