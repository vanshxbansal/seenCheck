import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:ojas/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:ojas/models/login_data.dart';




class Otp extends StatefulWidget {
  const Otp({super.key, required this.email});
  final String email;
  @override
  OtpState createState() => OtpState();
}


class OtpState extends State<Otp> {
  bool _isLoading = false; // Add this line to track loading state

  saveLoginData(String email, bool isActive) async {
    var box = Hive.box<LoginData>('loginBox');
    var loginData = LoginData(isActive: isActive, email: email);
    await box.put('login', loginData);
  }

  LoginData? getLoginData() {
    var box = Hive.box<LoginData>('loginBox');
    var loginData =  box.get('login');
    if (loginData != null) {
      print('Username: ${loginData.email}');
      print('Is Active: ${loginData.isActive}');
    } else {
      print('No login data found');
    }
    return loginData;
  }

  void clearLoginData() async {
    var box = Hive.box<LoginData>('loginBox');
    await box.delete('login');
  }

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  // Function to send the OTP email using the API
  Future<void> verifyEmail(BuildContext context, code) async {
    setState(() {
      _isLoading = true; // Show the loader when the button is pressed
    });

    const apiUrl = 'http://10.0.2.2:8000/api/verify-otp';
    final headers = {'Content-Type': 'application/json'};

    var body = jsonEncode({
      "email": widget.email,
      "otp": code,
    });

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        await saveLoginData(widget.email, true);
        getLoginData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP verification Successful!')),
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MyHomePage()),
              (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to verify OTP, please try again.')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again later.')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide the loader when the request completes
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Stack( // Use Stack widget to overlay the loader on top
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Verification',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter your OTP code number",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textFieldOTP(first: true, last: false, cont: controller1),
                            textFieldOTP(first: false, last: false, cont: controller2),
                            textFieldOTP(first: false, last: false, cont: controller3),
                            textFieldOTP(first: false, last: true, cont: controller4),
                          ],
                        ),
                        const SizedBox(height: 22),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading
                                ? null // Disable the button when loading
                                : () async {
                              String code = controller1.text +
                                  controller2.text +
                                  controller3.text +
                                  controller4.text;
                              await verifyEmail(context, code);
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(14.0),
                              child: const Text(
                                'Verify',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
            if (_isLoading) // Show the loader if _isLoading is true
              Center(
                child: Container(
                  color: Colors.black45, // Semi-transparent background
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget textFieldOTP({required bool first, required bool last, required TextEditingController cont}) {
    return SizedBox(
      height: 60,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: cont,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          autofocus: false,
          onChanged: (value) {
            if (value.length == 1 && !last) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && !first) {
              FocusScope.of(context).previousFocus();
            }
          },
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.purple),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
