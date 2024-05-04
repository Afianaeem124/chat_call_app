// import 'package:chat_call_app/main.dart';
// import 'package:chat_call_app/model/contactModel.dart';
// import 'package:chat_call_app/screens/home.dart';
// import 'package:flutter/material.dart';

// class FavoriteScreen extends StatelessWidget {
//   final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorites'),
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context)
//                   .push(MaterialPageRoute(builder: (context) => MyApp()));
//             },
//             icon: Icon(Icons.arrow_back_ios)),
//       ),
//       body: FutureBuilder<List<Contact>>(
//         future: _databaseHelper.getAllContacts(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final favoriteContacts =
//                 snapshot.data!.where((contact) => contact.isFavorite).toList();
//             if (favoriteContacts.isEmpty) {
//               return Center(child: Text('No favorite contacts'));
//             } else {
//               return ListView.builder(
//                 itemCount: favoriteContacts.length,
//                 itemBuilder: (context, index) {
//                   final contact = favoriteContacts[index];
//                   return ListTile(
//                     title: Text(contact.name),
//                     subtitle: Text(contact.phoneNumber),
//                   );
//                 },
//               );
//             }
//           }
//         },
//       ),
//     );
//   }
// }
