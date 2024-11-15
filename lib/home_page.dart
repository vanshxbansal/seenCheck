
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:ojas/Screens/chat_screen.dart';
import 'package:ojas/Screens/post_screen.dart';
import 'package:ojas/Screens/profile_screen.dart';
import 'package:ojas/models/login_data.dart';
import 'package:ojas/settings.dart';
import 'package:ojas/welcome.dart';
import 'package:ojas/widgets/widgets/floating_actionButton.dart';
import 'package:ojas/widgets/widgets/icon_buttons_bt_appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final headers = {
    'X-CSCAPI-KEY': 'YOUR_API_KEY',
  };

  final List<String> userPhotos = [
    'https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*',
    'https://plus.unsplash.com/premium_photo-1663127305918-a789d0f6bf21?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Y3V0ZSUyMGRvZ3xlbnwwfHwwfHx8MA%3D%3D',
    'https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*',
    'https://plus.unsplash.com/premium_photo-1663127305918-a789d0f6bf21?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Y3V0ZSUyMGRvZ3xlbnwwfHwwfHx8MA%3D%3D',

    'https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*',
    'https://plus.unsplash.com/premium_photo-1663127305918-a789d0f6bf21?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Y3V0ZSUyMGRvZ3xlbnwwfHwwfHx8MA%3D%3D',
    'https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*',
    'https://plus.unsplash.com/premium_photo-1663127305918-a789d0f6bf21?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Y3V0ZSUyMGRvZ3xlbnwwfHwwfHx8MA%3D%3D',
  ];

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

  Widget actionButton({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onPressed,
  }) {
    return Row(
      children: [
        IconButton(
          icon: Icon(icon, color: color),
          onPressed: onPressed!,
        ),
        Text(
          label,
          style: TextStyle(color: color),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: CustomDrawer(),
          body: Column(
            children: [
              // Container(
              //   color: Colors.deepPurple,
              //   height: 100,
              //   padding: EdgeInsets.symmetric(vertical: 2),
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: userPhotos.length,
              //     itemBuilder: (context, index) {
              //       final imageUrl = userPhotos[index];
              //       return Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //         child: CircleAvatar(
              //           radius: 30,
              //           backgroundImage: NetworkImage(imageUrl),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: userPhotos.length,
              //     itemBuilder: (context, index) {
              //       final imageUrl = userPhotos[index];
              //       return Card(
              //         color: Colors.deepPurple,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.zero,
              //         ),
              //         margin: EdgeInsets.symmetric(vertical: 8),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Image.network(imageUrl, fit: BoxFit.cover),
              //             Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Text(
              //                 'Description of post $index',
              //                 style: TextStyle(fontSize: 12, color: Colors.white),
              //               ),
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   actionButton(
              //                     icon: Icons.thumb_up_alt_sharp,
              //                     label: 'Like',
              //                     color: Colors.white,
              //                     onPressed: () {
              //                     },
              //                   ),
              //                   actionButton(
              //                     icon: Icons.comment_outlined,
              //                     label: 'Comment',
              //                     color: Colors.white,
              //                     onPressed: () {
              //                     },
              //                   ),
              //                   actionButton(
              //                     icon: Icons.share_outlined,
              //                     label: 'Share',
              //                     color: Colors.white,
              //                     onPressed: () {
              //                     },
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
          bottomNavigationBar: bottomAppBar(context),
          floatingActionButton: CustomFloatingActionButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostScreen()),
              );
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }

}