import 'package:chat_call_app/model/contactModel.dart';
import 'package:chat_call_app/utils/textstyle.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  final Contact contact;

  const UserDetailsScreen({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 211, 119),
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
        title: Text(
          'User Details',
          style: AppTextStyle.ContactHeADING,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage('assets/user.png'),
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Card.outlined(
              color: Colors.amberAccent,
              child: ListTile(
                title: Center(
                  child: Text(
                    'Name: ${contact.name}',
                    style: AppTextStyle.ContactText,
                  ),
                ),
                subtitle: Center(
                  child: Text(
                    'Phone Number: ${contact.phoneNumber}',
                    style: AppTextStyle.ContactText,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
