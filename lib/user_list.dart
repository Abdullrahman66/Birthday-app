import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import 'user.dart';
import 'user_details.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context); // Access UserProvider

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: const Text(
          "User List",
          style: TextStyle(fontSize: 28.0),
        ),
      ),
      body: FutureBuilder(
        future: userProvider.fetchUsers(), // Fetch users
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading users'));
          } else {
            return ListView.builder(
              itemCount: userProvider.users.length,
              itemBuilder: (ctx, index) {
                final user = userProvider.users[index];
                final isFavorite = userProvider.favorites.contains(user);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.profileImage),
                  ),
                  title: Text(user.fullName),
                  subtitle: Text(user.email),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      userProvider.toggleFavorite(user); // Toggle favorite
                    },
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserDetailScreen(user: user),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
