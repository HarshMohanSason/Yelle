
import 'package:flutter/material.dart';
import 'package:yelle/ReusableWidgets/text_form_validator.dart';
import '../ReusableWidgets/gradient_button.dart';
import '../ReusableWidgets/sign_up_page_image_background.dart';
import '../ReusableWidgets/sign_up_page_image_text.dart';
import '../main.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationForm extends StatefulWidget{
  const OtpVerificationForm({super.key, required this.emailAddress});

  final String emailAddress;
  @override
  OtpVerificationFormState createState() => OtpVerificationFormState();

}

class OtpVerificationFormState extends State<OtpVerificationForm>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
           const SignUpPageImageBackground(),
           SignUpPageImageText(
              mainHeading: "OTP Verification",
              subHeading:
              "Please enter the one time password(OTP) that is sent to ${widget.emailAddress}"),
           Positioned.fill(
               top: screenHeight / 4.5, // Adjust this based on image height
               child:
           Container(
               decoration: const BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.vertical(
                   top: Radius.circular(20),
                 ),
               ),
             child:  Padding(
               padding: const EdgeInsets.only(left: 20.0, top: 40),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   _pinInputUI(),
                   const SizedBox(height: 50),
                   const Padding(
                     padding: EdgeInsets.only(left: 5),
                     child: GradientButton(text: 'Submit'),
                   ),
                   const SizedBox(height: 40),
                    Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [

                       Text("Resend OTP in", style: TextStyle(
                         fontFamily: 'Plus_Jakarta_Sans',
                         fontSize: screenWidth/26.875
                       ),),
                       const Text("   Timer")

                     ],
                   )

                 ],
               ),
             ),
           ))
        ],
      ),
    );
  }

  Widget _pinInputUI() {
      return SizedBox(
        width: screenWidth - 40,
        child: Pinput(
            //pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            //controller: otpTextController,
            length: 6,
            // Length for the OTP being entered
            defaultPinTheme: PinTheme(
              width: 100,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(
                    12), // Adjust the border radius as needed
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
            validator: TextFormValidator.validateOTP,
        ) );
    }
}