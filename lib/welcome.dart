
import 'package:flutter/material.dart';
import 'package:ojas/register.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  WelcomeState createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              // Image.asset(
              //   'assets/images/illustration-1.png',
              //   width: 240,
              // ),
              const SizedBox(
                height: 18,
              ),
              const  Text(
                "Let's get started",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Never a better time than now to start.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 38,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Register()),
                    );
                  },
                  style: ButtonStyle(
                    foregroundColor:
                    WidgetStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                    WidgetStateProperty.all<Color>(Colors.purple),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      'Create Account',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 22,
              // ),
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     onPressed: _handleSignIn,
              //     style: ButtonStyle(
              //       foregroundColor: WidgetStateProperty.all<Color>(Colors.purple),
              //       backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
              //       shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              //         RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(24.0),
              //         ),
              //       ),
              //     ),
              //     child: Padding(
              //       padding: EdgeInsets.all(14.0),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Image.network(
              //             'https://developers.google.com/identity/images/g-logo.png', // Google logo URL
              //             height: 24, // Adjust the size as needed
              //           ),
              //           const SizedBox(width: 10),
              //           const Text(
              //             'Sign in with Google',
              //             style: TextStyle(fontSize: 16),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}