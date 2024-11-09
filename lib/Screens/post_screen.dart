import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http;
import 'package:ojas/models/image_feed.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  XFile? _image;
  Box<ImageFeed>? imageFeedBox;
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    print(pickedFile);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
        _uploadImage(File(_image!.path));
      } else {
        print('No image selected.');
      }
    });
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage(File imageFile) async {
    final url = Uri.parse('http://192.168.1.41:8000/api/user-posts');
    final request = http.MultipartRequest('POST', url);

    try {
      // Add image file
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
      // Add title field
      request.fields['title'] = 'Sample Title';

      // Send the request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        print('Image uploaded successfully!');

        // Add to Hive box after successful upload
        final imageName = imageFile.path.split('/').last; // Get the image name from the file path
        imageFeedBox = Hive.box<ImageFeed>('imageFeed');
        imageFeedBox?.add(ImageFeed(imageName: imageName, title: 'Sample Title'));

        print('Image added to feed list in Hive.');
      } else {
        print('Image upload failed with status: ${response.statusCode}');
        print('Response body: $responseBody');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  // Function to submit the post (Upload logic can be added)
  void _submitPost() {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please add a photo to your post!')),
      );
    } else if (_descriptionController.text.isNotEmpty) {
      print('Post submitted with image and description');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please add a description!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Create Post',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _pickImage,
                child: Icon(Icons.camera_alt, size: 30, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Write a description...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _image == null ? null : _submitPost,
              child: Text(
                'Post',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
