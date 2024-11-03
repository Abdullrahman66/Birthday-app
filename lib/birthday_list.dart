import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user.dart'; // Import User class

class BirthdayList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context); // Access UserProvider

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: const Text(
          "Upcoming Birthdays",
          style: TextStyle(fontSize: 28.0),
        ),
      ),
      body: ListView.builder(
        itemCount: userProvider.favorites.length,
        itemBuilder: (context, index) {
          final user = userProvider.favorites[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.profileImage),
            ),
            title: Text(user.fullName),
            subtitle: Text('Birthday: ${user.birthDate ?? "N/A"}'), // Display birthday date
          );
        },
      ),
    );
  }
}
