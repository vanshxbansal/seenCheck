import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  // For making API requests
import 'dart:convert';
import 'package:hive/hive.dart';  // For accessing Hive
import 'package:ojas/constant.dart';  // To encode data to JSON
import 'package:ojas/models/login_data.dart';  // Assuming your LoginData model is here

class PartyScreen extends StatefulWidget {
  const PartyScreen({Key? key}) : super(key: key);

  @override
  State<PartyScreen> createState() => _PartyScreenState();
}

class _PartyScreenState extends State<PartyScreen> {
  TextEditingController partyNameController = TextEditingController();
  TextEditingController partyDescriptionController = TextEditingController();
  TextEditingController partyLocationController = TextEditingController();
  TextEditingController partyDateController = TextEditingController();
  TextEditingController partyTimeController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    partyNameController.dispose();
    partyDescriptionController.dispose();
    partyLocationController.dispose();
    partyDateController.dispose();
    partyTimeController.dispose();
    super.dispose();
  }

  // Retrieve the email from Hive
  Future<String?> getEmailFromHive() async {
    var box = await Hive.openBox<LoginData>('loginBox');
    LoginData? loginData = box.get('login');
    return loginData?.email; // Return email if it exists
  }

  // Function to upload party info via API request
  Future<void> uploadPartyInfo() async {
    // Set loading to true when API request starts
    setState(() {
      isLoading = true;
    });

    // Get the email from Hive
    String? email = await getEmailFromHive();
    if (email == null) {
      setState(() {
        isLoading = false;
      });
      print("User email not found.");
      return;
    }

    // API endpoint (adjust this to match your backend endpoint)
    String apiUrl = api_url + '/create-party';
    print(apiUrl);

    // Data to be sent to the API
    Map<String, dynamic> partyData = {
      'party_name': partyNameController.text,
      'party_description': partyDescriptionController.text,
      'party_location': partyLocationController.text,
      'party_date': partyDateController.text,
      'party_time': partyTimeController.text,
      'email': email,  // Send the email along with the party data
    };

    // Sending a POST request to the API
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(partyData),  // Encoding data to JSON
      );

      // After the request completes, set loading to false
      setState(() {
        isLoading = false;
      });

      // Check if the request was successful (status code 200-299)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = jsonDecode(response.body);
        print('Party Created Successfully: $responseData');

        // Navigate back (pop the current screen)
        Navigator.pop(context);

        // Optionally, show a success message (Snackbar or Dialog)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Party created successfully!')),
        );
      } else {
        print('Failed to create party. Status code: ${response.statusCode}');
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create party. Please try again.')),
        );
      }
    } catch (e) {
      print('Error during API request: $e');

      // After the error, set loading to false
      setState(() {
        isLoading = false;
      });

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error during the request. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Party Info',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),

                // Party Name Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: partyNameController,
                    decoration: const InputDecoration(
                      labelText: 'Party Name',
                      hintText: 'Birthday Bash',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Party Description Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: partyDescriptionController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Party Description',
                      hintText: 'A fun-filled evening with friends and family',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Party Location Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: partyLocationController,
                    decoration: const InputDecoration(
                      labelText: 'Party Location',
                      hintText: 'New York City, Central Park',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Party Date Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: partyDateController,
                    decoration: const InputDecoration(
                      labelText: 'Party Date (YYYY-MM-DD)',
                      hintText: '2024-12-31',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Party Time Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: partyTimeController,
                    decoration: const InputDecoration(
                      labelText: 'Party Time (HH:mm)',
                      hintText: '18:00',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Submit Button
                ElevatedButton(
                  onPressed: isLoading ? null : uploadPartyInfo,  // Disable button if loading
                  child: isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text('Submit Party Info', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(color: Colors.white),
                    backgroundColor: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
