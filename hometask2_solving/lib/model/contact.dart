class Contact {
  const Contact(
      {required this.id,
        required this.name,
      this.companyName = "",
      this.image = "",
      this.number = "+38 012 345 67 89",
      this.bio = ""});

  final int id;
  final String name;
  final String number;
  final String companyName;
  final String image;
  final String bio;

  // returns last name if contact has not blank name
  // or returns space holder if it's not
  String get lastName => name.trim().isEmpty ? "_" : name.split(" ").last;
}
