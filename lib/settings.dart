import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ojas/constant.dart';
import 'package:ojas/models/login_data.dart';
import 'package:hive/hive.dart';
import 'package:ojas/welcome.dart';
import 'package:http/http.dart' as http;

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  var userData; // This will store the user data fetched from the API
  String userFullName = "Profile Name"; // Default value until data is fetched

  @override
  void initState() {
    super.initState();
    // Fetch user data from Hive and API
    fetchUserDataFromHive();
  }

  // Fetch user data from Hive
  Future<void> fetchUserDataFromHive() async {
    var box = Hive.box<LoginData>('loginBox');
    var loginData = box.get('login');
    if (loginData != null && loginData.email != null) {
      // Get the email from loginData and fetch user data
      String email = loginData.email;
      fetchUserData(email);
    } else {
      print('No login data found or email is missing');
    }
  }

  // Fetch user data from API using the email
  Future<void> fetchUserData(String email) async {
    var apiUrl = api_url + '/user-data/?email=$email'; // API URL with email

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        setState(() {
          userData = data;
          // Set the user's full name (first name + last name)
          userFullName = '${data['first_name']} ${data['last_name']}';
        });
      } else {
        print('Failed to load user data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  // Build the ListTile widget for the drawer
  Widget buildListTile({
    required String title,
    required String subtitle,
    Color titleColor = Colors.black,
    Color subtitleColor = Colors.grey,
    IconData? trailingIcon,
    Color trailingIconColor = Colors.black,
    Function()? onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: titleColor, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: subtitleColor, fontSize: 12),
      ),
      trailing: Icon(
        trailingIcon,
        size: 16,
        color: trailingIconColor,
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: 100,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1720637466~exp=1720641066~hmac=4d8d4e739ec80aa6acc8f8cd5aa967859ee542d7acca56dc3e88b50ae6c7be62&w=740"),
                    ),
                  ),
                ),
                Text(
                  userFullName, // Display the full name here
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          buildListTile(
            title: "Account Settings",
            subtitle: "Notifications Passwords and more.",
            trailingIcon: Icons.arrow_forward_ios_sharp,
          ),
          const Divider(indent: 18.0, endIndent: 18.0),
          buildListTile(
            title: "Help & Support",
            subtitle: "Language and Text icon size.",
            trailingIcon: Icons.arrow_forward_ios_sharp,
          ),
          const Divider(indent: 18.0, endIndent: 18.0),
          buildListTile(
            title: "Log Out",
            subtitle: "",
            titleColor: Colors.red,
            onTap: () async {
              var box = Hive.box<LoginData>('loginBox');
              var loginData = box.get('login');
              loginData!.isActive = false;
              await box.put('login', loginData);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Welcome()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
          const SizedBox(height: 30),
          const ListTile(
            subtitle: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "T&Cs and Privacy Policy",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            title: Row(
              children: [
                Icon(FontAwesomeIcons.facebook),
                SizedBox(width: 25),
                Icon(FontAwesomeIcons.twitter),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
