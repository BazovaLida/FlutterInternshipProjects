import 'package:flutter/material.dart';

void main() => runApp(ContactsApp());

class ContactsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "Contacts list",
        home: ContactsList(contacts: [
          Contact(
              name: "Sundar Pichai",
              companyName: "Google LLC",
              image: "avatars/SundarPichai.jpg"),
          Contact(
              name: "Mark Zuckerberg",
              companyName: "Facebook Inc.",
              image: "avatars/MarkZuckerberg.jpg"),
          Contact(
              name: "Andy Jassy",
              companyName: "Amazon.com, Inc.",
              image: "avatars/AndyJassy.jpg"),
          Contact(
              name: "Satya Nadella",
              companyName: "Microsoft Corporation",
              image: "avatars/SatyaNadella.jpg"),
          Contact(
              name: "Ted Sarandos",
              companyName: "Netflix, Inc.",
              image: "avatars/TedSarandos.jpg"),
          Contact(
              name: "Elon Musk",
              companyName: "Tesla, Inc.",
              image: "avatars/ElonMusk.jpg"),
          Contact(
              name: "Tim Cook",
              companyName: "Apple Inc.",
              image: "avatars/TimCook.jpg"),
          Contact(
              name: "Maxim Shafirov",
              companyName: "JetBrains s.r.o.",
              image: "avatars/MaximShafirov.jpg"),
          Contact(
              name: "Nat Friedman",
              companyName: "GitHub, Inc.",
              image: "avatars/NatFriedman.jpg"),
          Contact(
              name: "Arvind Krishna",
              companyName: "International Business Machines Corporation",
              image: "avatars/ArvindKrishna.jpg"),
          Contact(
              name: "Hyun Suk Kim",
              companyName: "Samsung Electronics Co., Ltd.",
              image: "avatars/HyunSukKim.jpg"),
        ]));
  }
}

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key, required this.contacts}) : super(key: key);

  final List<Contact> contacts;

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final Set<Contact> _starred = <Contact>{};

  void _tapStar(Contact contact, bool hasStar) {
    // updates star presence and list starred contact
    setState(() {
      hasStar = !hasStar;
      hasStar ? _starred.add(contact) : _starred.remove(contact);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: widget.contacts.map((Contact contact) {
          return ContactsListItem(
            contact: contact,
            hasStar: _starred.contains(contact),
            onStarTapped: _tapStar,
          );
        }).toList()
        // Sorting list in alphabet order
          ..sort((a, b) => a.contact.lastName
              .toLowerCase()
              .compareTo(b.contact.lastName.toLowerCase())),
      ),
    );
  }
}

class Contact {
  const Contact({required this.name, this.companyName = "", this.image = ""});

  final String name;
  final String companyName;
  final String image;

  // returns last name if contact has not blank name
  // or returns space holder if it's not
  String get lastName =>
      name.trim().isEmpty ? "_" : name.split(" ").last;
}

// definition of callback function
typedef StarChangeCallback = Function(Contact contact, bool hasStar);

class ContactsListItem extends StatelessWidget {
  const ContactsListItem({
    Key? key,
    required this.contact,
    required this.hasStar,
    required this.onStarTapped,
  }) : super(key: key);

  final Contact contact;
  final bool hasStar;
  final StarChangeCallback onStarTapped;

  // stores the first letter of the last name
  static String lastNameChar = "_";

  // decides weather [lastNameChar] should be inserted, or not
  Widget navChar({required bool presence}) {
    if (presence) {
      lastNameChar = contact.lastName[0];
      return Container(
        padding: EdgeInsets.only(left: 32.0),
        alignment: Alignment.centerLeft,
        child: Text(
          lastNameChar,
          style: myTextStyle(FontWeight.w100),
        ),
      );
    }
    return Container();
  }

  TextStyle myTextStyle([FontWeight weight = FontWeight.w300]) => TextStyle(
        fontWeight: weight,
        fontFamily: 'Montserrat',
      );

  // tap-able star icon widget. Calls [StarChangeCallback] on tap
  Widget starIcon() => IconButton(
        splashRadius: 20.0,
        alignment: Alignment.center,
        icon: Visibility(
          visible: hasStar,
          child: const Icon(Icons.star),
        ),
        color: Colors.lightBlueAccent,
        onPressed: () {
          onStarTapped(contact, hasStar);
        },
      );


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        navChar(presence: lastNameChar != contact.lastName[0]),
        ListTile(
          leading: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            starIcon(),
            const SizedBox(
              width: 8,
            ),
            CircleAvatar(
              backgroundImage: AssetImage(contact.image),
            ),
          ]),
          title: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              contact.name,
              style: myTextStyle(FontWeight.bold),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              contact.companyName,
              style: myTextStyle(),
            ),
          ),
        ),
      ],
    );
  }
}
