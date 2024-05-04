import 'package:chat_call_app/model/contactModel.dart';
import 'package:chat_call_app/screens/usersDetail.dart';
import 'package:chat_call_app/utils/colors.dart';
import 'package:chat_call_app/utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:path/path.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  final TextEditingController _searchController = TextEditingController();
  late List<Contact> _contacts;
  late List<Contact> _filteredContacts;

  @override
  void initState() {
    super.initState();
    _loadContacts();
    _searchController.addListener(_onSearchTextChanged);
  }

  void _loadContacts() async {
    _contacts = await _databaseHelper.getAllContacts();
    _filteredContacts = List.from(_contacts);
    setState(() {});
  }

  void _onSearchTextChanged() {
    String searchText = _searchController.text.toLowerCase();
    _filteredContacts = _contacts.where((contact) {
      return contact.name.toLowerCase().contains(searchText) ||
          contact.phoneNumber.toLowerCase().contains(searchText);
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundWhite,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/BG.jpg'), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 350, // Convert from Fixed (377.48px)px to double
                height: 70.03, // Convert from Fixed (70.03px)px to double

                padding: EdgeInsets.symmetric(
                    horizontal: 30), // Convert from padding in px to EdgeInsets
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  border: Border.all(
                      width: 1.09,
                      color: AppColor
                          .LightGrey), // Convert from border in px to Border
                ),
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search Contacts',
                    labelStyle: AppTextStyle.ContactText,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColor.blackk,
                    ),
                    border: InputBorder
                        .none, // Remove default border from input field
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Contact>>(
                future: _databaseHelper.getAllContacts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: _filteredContacts.length,
                      itemBuilder: (context, index) {
                        final contact = _filteredContacts[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Card(
                            color: Colors.amberAccent,
                            child: ListTile(
                              title: Text(
                                contact.name,
                                style: AppTextStyle.ContactText,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.phone_outlined),
                                    onPressed: () async {
                                      _callNumber(contact.phoneNumber);
                                    },
                                  ),
                                  PopupMenuButton(
                                      elevation: 3,
                                      iconColor: Color(0xff5B5B5B),
                                      color: AppColor.bluetone,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                              color: AppColor.LightGrey)),
                                      itemBuilder: (context) => [
                                            ////////////EDIT
                                            PopupMenuItem(
                                                value: 1,
                                                child: ListTile(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    _editContact(
                                                        context, contact);
                                                  },
                                                  title: Text('Edit'),
                                                  trailing: Icon(Icons.edit),
                                                )),
                                            ////////////DELETE
                                            PopupMenuItem(
                                                value: 2,
                                                child: ListTile(
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    await _databaseHelper
                                                        .deleteContact(
                                                            contact.id!);
                                                    _loadContacts(); // Reload contacts after deletion
                                                  },
                                                  title: Text('Delete'),
                                                  trailing: Icon(Icons
                                                      .delete_forever_outlined),
                                                )),
                                          ]),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserDetailsScreen(
                                            contact: contact)));
                              },
                            ),
                          ),
                        );
                      },
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.bluetone,
        onPressed: () async {
          final contact = await _showAddContactDialog(context);
          if (contact != null) {
            await _databaseHelper.insertContact(contact);
            _loadContacts(); // Reload contacts after adding
          }
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void addContact(BuildContext context) async {
    try {
      String? name = await _showInputDialog(context, 'Enter Name');
      String? phoneNumber =
          await _showInputDialog(context, 'Enter Phone Number');
      if (name != null && phoneNumber != null) {
        Contact contact = Contact(name: name, phoneNumber: phoneNumber);
        await _databaseHelper.insertContact(contact);
        setState(() {});
      }
    } catch (e, stackTrace) {
      print('Error adding contact: $e');
      print(stackTrace);
    }
  }

  Future<Contact?> _showAddContactDialog(BuildContext context) async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    return await showDialog<Contact>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            'Add Contact',
            style: AppTextStyle.dialoghead,
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Avoid unnecessary scrolling
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: AppTextStyle.Contactsubs,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: AppTextStyle.Contactsubs,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: AppTextStyle.dialogblue,
              ),
            ),
            TextButton(
              onPressed: () {
                final name = nameController.text;
                final phoneNumber = phoneNumberController.text;
                if (name.isNotEmpty && phoneNumber.isNotEmpty) {
                  Navigator.pop(
                      context, Contact(name: name, phoneNumber: phoneNumber));
                } else {
                  // Handle empty fields (optional)
                }
              },
              child: Text(
                'OK',
                style: AppTextStyle.dialogblue,
              ),
            ),
          ],
        );
      },
    );
  }

  void _editContact(BuildContext context, contact) async {
    String? newName = await _showInputDialog(context, 'Edit Name',
        initialValue: contact.name);
    String? newPhoneNumber = await _showInputDialog(
        context, 'Edit Phone Number',
        initialValue: contact.phoneNumber);
    if (newName != null && newPhoneNumber != null) {
      contact.name = newName;
      contact.phoneNumber = newPhoneNumber;
      await _databaseHelper.updateContact(contact);
      setState(() {});
    }
  }

  Future<String?> _showInputDialog(BuildContext context, String title,
      {String? initialValue}) async {
    TextEditingController controller =
        TextEditingController(text: initialValue);
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            onChanged: (value) {
              // Update the text field value
              controller.text = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Phone number copied to clipboard')),
    );
  }

  void _callNumber(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching phone call: $e');
      // Handle the error gracefully, maybe display a message to the user
    }
  }
}

class DatabaseHelper {
  DatabaseHelper._(); // Private constructor to prevent instantiation

  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;
  static const String dbName = 'contacts.db';
  static const String tableName = 'contacts';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, dbName);
    return await openDatabase(databasePath,
        version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phoneNumber TEXT
      )
    ''');
  }

  Future<int> insertContact(Contact contact) async {
    final db = await database;
    return await db.insert(tableName, contact.toMap());
  }

  Future<int> deleteContact(int id) async {
    final db = await database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    final db = await database;
    return await db.update(tableName, contact.toMap(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  Future<List<Contact>> getAllContacts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Contact(
        id: maps[i]['id'],
        name: maps[i]['name'],
        phoneNumber: maps[i]['phoneNumber'],
      );
    });
  }
}
