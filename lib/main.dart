import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ojas/home_page.dart';
import 'package:ojas/models/image_feed.dart';
import 'package:ojas/models/login_data.dart';
import 'package:ojas/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LoginDataAdapter());
  Hive.registerAdapter(ImageFeedAdapter());
  await Hive.openBox<ImageFeed>('imageFeed');
  await Hive.openBox<LoginData>('loginBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> isUserActive() async {
    var box = await Hive.openBox<LoginData>('loginBox');
    var loginData = box.get('login');
    if (loginData != null) {
      print('Username: ${loginData.email}');
      print('Is Active: ${loginData.isActive}');
      return loginData.isActive;
    } else {
      print('No login data found');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Katyayni",
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: isUserActive(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text('Error loading login data')),
            );
          } else if (snapshot.hasData) {
            bool isActive = snapshot.data!;
            return isActive ? const MyHomePage() : const Welcome();
          } else {
            return const Welcome();
          }
        },
      ),
    );
  }
}
