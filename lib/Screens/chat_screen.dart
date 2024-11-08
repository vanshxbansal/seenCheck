import 'dart:async';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
  TabController(length: 2, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Inbox",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Material(
                color: Colors.deepPurple.shade300,
                borderOnForeground: true,
                child: TabBar(
                  indicatorWeight: 4,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.white,
                  tabs: const [
                    Tab(
                      child: Text(
                        "Chat",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Archived",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ],
                  controller: _tabController,
                  onTap: (n) async {
                    setState(() {
                      _tabController.index = _tabController.index;
                    });
                    if (n == 0) {
                      //
                    }
                    if (n == 1) {
                      //
                    }
                  },
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
                          child: ListTile(
                            trailing: Text("15 mins ago"),
                            tileColor: Colors.white,
                            leading: Icon(Icons.account_circle),
                            title: Text(
                              "Vansh",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
                          child: ListTile(
                            trailing: Text("20 mins ago"),
                            tileColor: Colors.white,
                            leading: Icon(Icons.account_circle),
                            title: Text(
                              "Shivam",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListView(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
                          child: ListTile(
                            trailing: Text(
                              "20 mins ago",
                              style: TextStyle(fontSize: 8),
                            ),
                            tileColor: Colors.white,
                            leading: Icon(Icons.account_circle),
                            title: Text(
                              "Ojas",
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}