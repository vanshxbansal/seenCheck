import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ojas/constant.dart';
import 'package:ojas/models/login_data.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this);

  // List to store party data fetched from API
  List<dynamic> parties = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Function to fetch parties by email
  Future<void> fetchPartiesByEmail(String email) async {
    setState(() {
      isLoading = true;
      errorMessage = null;  // Reset error message
    });

    String apiUrl = api_url + '/parties-by-email/?email=$email';  // Update with the correct API URL

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          parties = data;  // Store the party data
        });
      } else {
        setState(() {
          errorMessage = "Failed to load parties.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching data: $e";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Fetch email from Hive and call fetchPartiesByEmail
  Future<void> getEmailAndFetchParties() async {
    var box = await Hive.openBox<LoginData>('loginBox');
    LoginData? loginData = box.get('login');
    String? email = loginData?.email;

    if (email != null) {
      // If email is found, fetch parties
      await fetchPartiesByEmail(email);
    } else {
      setState(() {
        errorMessage = "Email not found in the Hive box.";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getEmailAndFetchParties();  // Fetch the email and then load the parties
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PARTY HALL",
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
                        "MY PARTIES",
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
                      // You can trigger a refresh or handle any state change here
                    }
                    if (n == 1) {
                      // Handle Archived tab actions
                    }
                  },
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Chat Tab - ListView to show parties
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : errorMessage != null
                        ? Center(child: Text(errorMessage!))
                        : ListView.builder(
                      itemCount: parties.length,
                      itemBuilder: (context, index) {
                        var party = parties[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                          child: ListTile(
                            trailing: Text("Just now"),  // Update with actual party time if available
                            tileColor: Colors.white,
                            leading: const Icon(Icons.account_circle),
                            title: Text(
                              party['party_name'] ?? 'No Name',  // Assuming party_name is in the response
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      },
                    ),
                    // Archived Tab
                    ListView(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
                          child: ListTile(
                            trailing: Text("20 mins ago", style: TextStyle(fontSize: 8)),
                            tileColor: Colors.white,
                            leading: Icon(Icons.account_circle),
                            title: Text("Ojas", style: TextStyle(color: Colors.black, fontSize: 14)),
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
