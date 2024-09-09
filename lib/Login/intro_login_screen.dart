import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:yelle/Login/EmailLogin/email_login_service.dart';
import 'package:yelle/Login/EmailLogin/forgot_passowrd_ui.dart';
import 'package:yelle/Login/GoogleLogin/google_login_service.dart';
import 'package:yelle/Login/login_state_class.dart';
import 'package:yelle/Login/EmailSignUp/sign_up.dart';
import 'package:yelle/ReusableWidgets/custom_text_forms.dart';
import 'package:yelle/ReusableWidgets/sign_up_page_image_background.dart';
import 'package:yelle/ReusableWidgets/sign_up_page_image_text.dart';
import 'package:yelle/ReusableWidgets/text_form_validator.dart';
import 'package:yelle/main.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../ReusableWidgets/gradient_button.dart';
import '../home_screen.dart';

class IntroLoginScreen extends StatefulWidget {
  const IntroLoginScreen({super.key});

  @override
  IntroLoginScreenState createState() => IntroLoginScreenState();
}

class IntroLoginScreenState extends State<IntroLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late EmailLoginService emailLoginServiceProvider;
  late GoogleSignInProvider googleSignInProvider;
  final _signUpFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    emailLoginServiceProvider = context.watch<EmailLoginService>();
    googleSignInProvider = context.watch<GoogleSignInProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            const SignUpPageImageBackground(),
            const SignUpPageImageText(
                mainHeading: "Welcome Back!",
                subHeading: "Please fill below details to continue."),
            Positioned.fill(
              top: screenHeight / 5, // Adjust this based on image height
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 40),
                  child: SingleChildScrollView(
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
                          const SizedBox(height: 10),
                          SizedBox(
                              width: screenWidth - 40,
                              child: CustomTextForms(
                                controller: emailController,
                                hideText: false,
                                hintText: 'Enter email address',
                                icon: Icons.email,
                                validator: TextFormValidator.validateEmail,
                              )),
                          const SizedBox(height: 20),
                          Text(
                            "Password",
                            style: TextStyle(
                                fontFamily: 'Plus_Jakarta_Sans',
                                fontSize: screenWidth / 28.17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: screenWidth - 40,
                            child: CustomTextForms(
                              controller: passwordController,
                              hideText: true,
                              hintText: 'Enter password',
                              icon: Icons.lock,
                              validator: TextFormValidator.validatePassword,
                            ),
                          ),
                          const SizedBox(height: 50),
                          InkWell(
                              onTap: () async {
                                if (_signUpFormKey.currentState!.validate()) {
                                  setState(() {});
                                  await emailLoginServiceProvider
                                      .startEmailLoginProcess(
                                          emailController.text,
                                          passwordController.text);

                                  if (emailLoginServiceProvider.state.state ==
                                          LoginStateEnum.loggedIn &&
                                      context.mounted) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()));
                                  } else if (emailLoginServiceProvider
                                          .state.state ==
                                      LoginStateEnum.error) {
                                    setState(() {
                                      Fluttertoast.showToast(
                                        msg: emailLoginServiceProvider
                                            .state.errorMessage!,
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
                              child: emailLoginServiceProvider.state.state ==
                                      LoginStateEnum.loading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      strokeWidth: 7,
                                      color: Colors.black,
                                    ))
                                  : const Center(
                                      child: GradientButton(
                                      text: 'Login',
                                    ))),
                          const SizedBox(height: 50),
                          Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPassowrdUi()));
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    fontFamily: 'Plus_Jakarta_Sans',
                                    fontSize: screenWidth / 24.17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: const Divider(
                                    color: Colors.grey,
                                    thickness: 1.0,
                                  ),
                                ),
                              ),
                              const Text(
                                'OR',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: const Divider(
                                    color: Colors.grey,
                                    thickness: 1.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: googleSignInProvider.state.state ==
                                    LoginStateEnum.loading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                    strokeWidth: 7,
                                    color: Colors.black,
                                  ))
                                : SignInButton(
                                    Buttons.Google,
                                    onPressed: () async {
                                      await googleSignInProvider
                                          .startSignInWithGoogle();

                                      if (googleSignInProvider.state.state ==
                                              LoginStateEnum.loggedIn &&
                                          context.mounted) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomeScreen()));
                                      } else if (googleSignInProvider
                                                  .state.state ==
                                              LoginStateEnum.loggedIn &&
                                          context.mounted) {
                                        Fluttertoast.showToast(
                                          msg: googleSignInProvider
                                              .state.errorMessage!,
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          textColor: Colors.white,
                                          backgroundColor: Colors.red,
                                          fontSize: 14.0,
                                        );
                                      } else {
                                        //set the state to regular if any other state is there
                                        setState(() {});
                                      }
                                    },
                                  ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: SignInButton(
                              Buttons.AppleDark,
                              onPressed: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=> const OtpVerificationForm(emailAddress: "harshsason2000@gmail.com")));
                              },
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                      fontFamily: 'Plus_Jakarta_Sans',
                                      fontSize: screenWidth / 28.17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                ShaderMask(
                                  shaderCallback: (bounds) =>
                                      const LinearGradient(
                                    colors: [
                                      Color(0xFFFE9900), // Start color
                                      Color(0xFFFFBE00), // End color
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ).createShader(bounds),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUp()));
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontFamily: 'Plus_Jakarta_Sans',
                                        fontSize: screenWidth / 28.17,
                                        color: Colors.white,
                                        // This color will be replaced by the gradient
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ])
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
