class Contact {
  int? id;
  String name;
  String phoneNumber;
  //String emailAddress; // Add emailAddress field

  Contact({
    this.id,
    required this.name,
    required this.phoneNumber,
    // required this.emailAddress, // Add emailAddress to constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      //'emailAddress': emailAddress, // Include emailAddress in the map
    };
  }
}
