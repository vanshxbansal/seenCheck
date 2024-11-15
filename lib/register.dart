import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ojas/constant.dart';
import 'package:ojas/otp_screen.dart';
import 'package:http/http.dart' as http;
import 'package:ojas/widgets/Animated_circle.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _sendOtpEmail(String email, String firstName, String lastName, String phone) async {
    setState(() {
      _isLoading = true;
    });

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phone,
      'recipient': email,  // Changed 'email' to 'recipient'
      'subject': 'Your OTP Code',
      'message': 'Your OTP is: 1234',
    });

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP sent to your email!')),
        );
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Otp(email: _emailController.text)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send OTP, please try again.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again later.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: SingleChildScrollView(  // Wrap the whole body in a SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, size: 32, color: Colors.black54),
                ),
                // const SizedBox(height: 30),
                Center(child: AnimatedGradientCircle()),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Registration',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Add your details, and we'll send you a verification code to get started!",
                  style: TextStyle(fontSize: 14, color: Colors.black45),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField('First Name', _firstNameController, TextInputType.text),
                      const SizedBox(height: 16),
                      _buildTextField('Last Name', _lastNameController, TextInputType.text),
                      const SizedBox(height: 16),
                      _buildTextField('Phone Number', _phoneController, TextInputType.phone),
                      const SizedBox(height: 16),
                      _buildTextField('Email', _emailController, TextInputType.emailAddress),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            String email = _emailController.text.trim();
                            String firstName = _firstNameController.text.trim();
                            String lastName = _lastNameController.text.trim();
                            String phone = _phoneController.text.trim();

                            if (_isValidEmail(email)) {
                              _sendOtpEmail(email, firstName, lastName, phone);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter a valid email address'),
                                  backgroundColor: Colors.black,
                                ),
                              );
                            }
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 14)),
                            backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                            'Send OTP',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, TextInputType keyboardType) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepPurple),
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: Icon(keyboardType == TextInputType.phone ? Icons.phone : Icons.person, color: Colors.deepPurple),
      ),
    );
  }
}
