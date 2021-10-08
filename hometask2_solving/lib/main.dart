import 'package:flutter/material.dart';

void main() {
  runApp(ContactsApp());
}

class ContactsApp extends StatelessWidget {
  // This widget is the root the application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "Contacts list",
        home: ContactsList(contacts: [
          Contact(
              lastName: "Pichai",
              firstName: "Sundar",
              companyName: "Google LLC"),
          Contact(
              lastName: "Zuckerberg",
              firstName: "Mark",
              companyName: "Facebook Inc."),
          Contact(
              lastName: "Jassy",
              firstName: "Andy",
              companyName: "Amazon.com, Inc."),
          Contact(
              lastName: "Nadella",
              firstName: "Satya",
              companyName: "Microsoft Corporation"),
          Contact(
              lastName: "Sarandos",
              firstName: "Ted",
              companyName: "Netflix, Inc."),
          Contact(
              lastName: "Musk", firstName: "Elon", companyName: "Tesla, Inc."),
          Contact(
              lastName: "Cook", firstName: "Tim", companyName: "Apple Inc."),
          Contact(
              lastName: "Shafirov",
              firstName: "Maxim",
              companyName: "JetBrains s.r.o."),
          Contact(
              lastName: "Friedman",
              firstName: "Nat",
              companyName: "GitHub, Inc."),
          Contact(
              lastName: "Krishna",
              firstName: "Arvind",
              companyName: "International Business Machines Corporation"),
          Contact(
              lastName: "Kim",
              firstName: "Hyun Suk",
              companyName: "Samsung Electronics Co., Ltd."),
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

  void _star(Contact contact, bool hasStar) {
    // updates the visual appearance of the app.
    setState(() {
      hasStar = !hasStar;

      if (hasStar) {
        _starred.add(contact);
      } else {
        _starred.remove(contact);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // this.con

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        //todo How does it work??
        children: widget.contacts.map((Contact contact) {
          return ContactsListItem(
            contact: contact,
            hasStar: _starred.contains(contact),
            onStarTapped: _star,
          );
        }).toList()
          ..sort((a, b) => a.contact.lastName
              .toLowerCase()
              .compareTo(b.contact.lastName.toLowerCase())),
      ),
    );
  }
}

//todo picture
class Contact {
  const Contact(
      {required this.lastName, this.firstName = "", this.companyName = ""});

  final String lastName;
  final String firstName;
  final String companyName;

  String get name => firstName + " " + lastName;
}

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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
        Container(
          child: IconButton(
            splashRadius: 20.0,
            alignment: Alignment.center,
            icon: Visibility(
              visible: hasStar,
              child: const Icon(Icons.star),
            ),
            color: Theme.of(context).accentColor,
            onPressed: () {
              onStarTapped(contact, hasStar);
            },
          ),
          margin: const EdgeInsets.only(right: 14),
        ),
        CircleAvatar(
          child: Text(contact.lastName[0]),
        ),
      ]),
      title: Text(
        contact.name,
        // todo style: _getTextStyle(context),
      ),
      subtitle: Text(
        contact.companyName,
      ),
    );
  }
}
