import 'package:flutter/material.dart';

class PartyInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Party Info'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // Header Section
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Winter is coming - The ultimate fireside farmhouse party',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Fri, Nov 27 | 7:00 PM to 7:00 AM',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Yenkapally, Hyderabad',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Host Profile Section
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage('https://example.com/host-profile-image.jpg'),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vanshxbansal',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '0+ Parties hosted',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Filling Fast Indicator
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'FILLING FAST',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.yellow,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    '7-15 people in the party',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            // About Section
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Join me for a 12-hour celebration of warmth, fun, and unforgettable moments. Escape to the countryside for a day filled with everything you need to relax and rewind. Warm up by the bonfire, sing your heart out at our karaoke session, and dive into a variety of games and activities that will keep the energy high. Savor delicious dinner and snacks till winter surrounded by good company. As the night unfolds, dance away to specially curated guest playlists that perfect playlist to set the mood. Don\'t miss this chance to make memories in a beautiful farmhouse retreat, where laughter and joy will last till day and night! PS - BYOB',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            // What's Included Section
            // Container(
            //   padding: EdgeInsets.all(16),
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           Icon(Icons.local_drink, size: 24),
            //           SizedBox(width: 16),
            //           Text(
            //             'Beverages Served Limited',
            //             style: TextStyle(
            //               fontSize: 14,
            //               color: Colors.grey,
            //             ),
            //           ),
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           Icon(Icons.local_drink, size: 24),
            //           SizedBox(width: 16),
            //           Text(
            //             'BYOB if you wish to drink more',
            //             style: TextStyle(
            //               fontSize: 14,
            //               color: Colors.grey,
            //             ),
            //           ),
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           Icon(Icons.fastfood, size: 24),
            //           SizedBox(width: 16),
            //           Text(
            //             'Food Allowed to order/get your own food',
            //             style: TextStyle(
            //               fontSize: 14,
            //               color: Colors.grey,
            //             ),
            //           ),
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           Icon(Icons.pets, size: 24),
            //           SizedBox(width: 16),
            //           Text(
            //             'No Pets at home',
            //             style: TextStyle(
            //               fontSize: 14,
            //               color: Colors.grey,
            //             ),
            //           ),
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           Icon(Icons.child_care, size: 24),
            //           SizedBox(width: 16),
            //           Text(
            //             'Guest Kids are not Allowed',
            //             style: TextStyle(
            //               fontSize: 14,
            //               color: Colors.grey,
            //             ),
            //           ),
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           Icon(Icons.elevator, size: 24),
            //           SizedBox(width: 16),
            //           Text(
            //             'Elevator Not Available',
            //             style: TextStyle(
            //               fontSize: 14,
            //               color: Colors.grey,
            //             ),
            //           ),
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           Icon(Icons.local_parking, size: 24),
            //           SizedBox(width: 16),
            //           Text(
            //             'Parking Available',
            //             style: TextStyle(
            //               fontSize: 14,
            //               color: Colors.grey,
            //             ),
            //           ),
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           Icon(Icons.music_note, size: 24),
            //           SizedBox(width: 16),
            //           Text(
            //             'Music Available',
            //             style: TextStyle(
            //               fontSize: 14,
            //               color: Colors.grey,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}