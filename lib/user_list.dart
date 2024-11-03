import 'package:flutter/material.dart';
import 'user.dart';
import 'user_details.dart';
class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late Future<void> _userFuture;
  final UserProvider _userProvider = UserProvider();

  @override
  void initState() {
    super.initState();
    _userFuture = _userProvider.fetchUsers();
  }

  void _toggleFavorite(User user) {
    setState(() {
      _userProvider.toggleFavorite(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text(
          "User List",
          style: TextStyle(fontSize: 28.0,),
        ),
      ),
      body: FutureBuilder(
        future: _userFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading users'));
          } else {
            return ListView.builder(
              itemCount: _userProvider.users.length,
              itemBuilder: (ctx, index) {
                final user = _userProvider.users[index];
                final isFavorite = _userProvider.favorites.contains(user);
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
                    onPressed: () => _toggleFavorite(user),
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