import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ojas/Screens/chat_screen.dart';
import 'package:ojas/Screens/profile_screen.dart';
import 'package:ojas/widgets/widgets/floating_actionButton.dart';
import 'package:ojas/widgets/widgets/icon_buttons_bt_appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ojas/widgets/widgets/input_field.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final headers = {
    'X-CSCAPI-KEY': 'YOUR_API_KEY',
  };

  Future<void> getStatus() async {
    final request = http.Request(
        'GET', Uri.parse('https://api.countrystatecity.in/v1/countries'));
    request.headers.addAll(headers);

    try {
      final http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  BottomAppBar bottomAppBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.deepPurple,
      child: SizedBox(
        height: 100.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(
              builder: (BuildContext context) {
                return BuildIconButtonsForBottomAppBar(
                  iconData: Icons.settings,
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            BuildIconButtonsForBottomAppBar(iconData: Icons.search, onTap: () {}),
            const Spacer(),
            BuildIconButtonsForBottomAppBar(iconData: Icons.chat, onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ChatScreen()),
              );
            }),
            BuildIconButtonsForBottomAppBar(iconData: Icons.account_circle_sharp, onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            }),
          ],
        ),
      ),
    );
  }

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
                const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent
                ),
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
                    Text('profile name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
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

                // trailingIconColor: Colors.red,
              ),
              const SizedBox(height: 30),
              const ListTile(
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "T&Cs and Privacy Policy",
                    style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
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
        ),
        body: Container(),
        bottomNavigationBar: bottomAppBar(context),
        floatingActionButton:  CustomFloatingActionButton(
          onPressed: () async {
            await getStatus();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}