import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String profileImage;
  final String? birthDate;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profileImage,
    this.birthDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      profileImage: json['image'],
      birthDate: json['birthDate'],
    );
  }

  String get fullName => "$firstName $lastName";
}

class UserProvider extends ChangeNotifier{
  List<User> _users = [];
  List<User> _favorites = [];

  List<User> get users => _users;
  List<User> get favorites => _favorites;

  Future<void> fetchUsers() async {
    if (_users.isEmpty) { // Only fetch if the list is empty
      final response = await get(Uri.parse('https://dummyjson.com/users'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['users'] as List;
        _users = data.map((user) => User.fromJson(user)).toList();
        notifyListeners(); // Notify listeners after fetching users
      } else {
        throw Exception('Failed to load users');
      }
    }
  }

  void toggleFavorite(User user) async {
    if (_favorites.contains(user)) {
      _favorites.remove(user);
    } else {
      _favorites.add(user);
    }
    notifyListeners();
  }
}