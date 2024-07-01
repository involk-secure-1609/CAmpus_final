import 'package:campuscollaborate/constants/routing_constants.dart';
import 'package:campuscollaborate/locator.dart';
import 'package:campuscollaborate/models/user_info.dart';
import 'package:campuscollaborate/services/authentication_services.dart';
import 'package:campuscollaborate/services/user_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthenticationServices authenticationServices=AuthenticationServices();
  final UserServices userServices=UserServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 120),
            Container(
              alignment: Alignment.topCenter,
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Campus',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'Collab',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(234, 140, 56, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              alignment: Alignment.topCenter,
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Share ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'Your ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'Work',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(234, 140, 56, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'with ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'the ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'World',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(234, 140, 56, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: 100, // Adjust the size of the circle
              height: 100, // Adjust the size of the circle
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: const Center(
                child: Text(
                  'Your Text',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.topCenter,
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'LOGIN',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: ()async{
                await authenticationServices.loginAuthenticate();
              },
              child: Container(
                width: 300,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(85, 85, 85, 1),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mail_outlined,
                      color: Color.fromRGBO(224, 140, 56, 1),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Login with Outlook',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Container(
            //   alignment: Alignment.topCenter,
            //   child: RichText(
            //     text: const TextSpan(
            //       children: [
            //         TextSpan(
            //           text: 'OR',
            //           style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.w500,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 10),
            // Container(
            //   alignment: Alignment.topCenter,
            //   child: RichText(
            //     text: TextSpan(
            //       children: [
            //         const TextSpan(
            //           text: 'Continue ',
            //           style: TextStyle(
            //             fontSize: 15,
            //             fontWeight: FontWeight.w400,
            //             color: Colors.white,
            //           ),
            //         ),
            //         const TextSpan(
            //           text: 'As ',
            //           style: TextStyle(
            //             fontSize: 15,
            //             fontWeight: FontWeight.w400,
            //             color: Colors.white,
            //           ),
            //         ),
            //         // TextSpan(
            //         //     text: 'Guest',
            //         //     style: const TextStyle(
            //         //       fontSize: 15,
            //         //       fontWeight: FontWeight.w400,
            //         //       decoration: TextDecoration.underline,
            //         //       color: Color.fromRGBO(234, 140, 56, 1),
            //         //     ),
            //         //     recognizer: TapGestureRecognizer()
            //         //       ..onTap = () {
            //         //         print('Privacy Policy"');
            //         //       }),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
