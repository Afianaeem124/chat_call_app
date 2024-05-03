import 'package:chat_call_app/database/dbhelper.dart';
import 'package:chat_call_app/model/contactModel.dart';
import 'package:chat_call_app/utils/textstyle.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({super.key});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  late List<Contact> _filteredContacts;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Contact>>(
              future: _databaseHelper.getAllContacts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Card(
                    child: Center(
                      child: Column(children: [
                        Text(snapshot.data!.first.name.toString()),
                        Text(snapshot.data!.first.phoneNumber.toString()),
                        Text(snapshot.data!.first.id.toString()),
                      ]),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
