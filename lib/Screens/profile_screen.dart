
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ojas/models/image_feed.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // bool isEditing = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController workController = TextEditingController();
  TextEditingController educationController = TextEditingController();
// var userPhotos;
  List<String> userPhotos = [];
  @override
  // List<String> imageNames = [];  // Declare a list to hold the image names.

  void initState() {
    super.initState();

    var box = Hive.box<ImageFeed>('imageFeed');
    print(box);

    // Retrieve all ImageFeed objects from the box and add the image names to the list.
    for (var imageFeed in box.values) {
      userPhotos.add('http://192.168.1.9:8000/media/images/'+imageFeed.imageName);  // Add each image name to the list
    }

    print('Image names: $userPhotos');  // Print the list of image names

    nameController.text = 'Ojas Mehrotra';
    bioController.text = 'Flutter Developer Senior';
    emailController.text = 'ojas@example.com';
    phoneController.text = '+91 123 456 7890';
    locationController.text = 'New Delhi';
    workController.text = 'Avalon Information Systems Pvt Ltd';
    educationController.text = 'B.Tech in Computer Science';
  }


  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    workController.dispose();
    educationController.dispose();
    super.dispose();
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
        size: 18,
        color: trailingIconColor,
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Profile',
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
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1720637466~exp=1720641066~hmac=4d8d4e739ec80aa6acc8f8cd5aa967859ee542d7acca56dc3e88b50ae6c7be62&w=740"),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  nameController.text,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  bioController.text,
                  style: const TextStyle(fontSize: 18, color: Colors.blue),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Divider(),
                ),
                SizedBox(height: 25,),
                // Instagram-like photo grid section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // 3 images per row
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: userPhotos.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          userPhotos[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
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