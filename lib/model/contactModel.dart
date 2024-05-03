class Contact {
  int? id;
  String name;
  String phoneNumber;
  bool isFavorite; // New property

  Contact({
    this.id,
    required this.name,
    required this.phoneNumber,
    this.isFavorite = false, // Default value for isFavorite
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'isFavorite':
          isFavorite ? 1 : 0, // Convert boolean to integer for storage
    };
  }

  // Convert a map to a Contact object
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      isFavorite: map['isFavorite'] == 1, // Convert integer to boolean
    );
  }
}
