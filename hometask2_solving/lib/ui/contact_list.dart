import 'package:flutter/material.dart';
import 'package:hometask2_solving/model/contact.dart';
import 'package:hometask2_solving/model/contact_model.dart';
import 'package:provider/provider.dart';
import 'list_item.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({
    Key? key,
  }) : super(key: key);


  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final Set<Contact> _starred = <Contact>{};

  // updates star presence and list starred contact
  void _tapStar(Contact contact, bool hasStar) {
    setState(() {
      hasStar ? _starred.remove(contact): _starred.add(contact);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ContactModel>(
        builder: (context, model, child) {
          return /*model.contacts.isNotEmpty
              ?*/ ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  children: model.contacts.map((Contact contact) {
                    return ContactsListItem(
                      contact: contact,
                      hasStar: _starred.contains(contact),
                      onStarTapped: _tapStar,
                      model: model
                    );
                  }).toList())
              /*: Center(
                  child: Column(children: [
                  Text("Failed to load data from API.\n Check your internet connection"),
                  CircularProgressIndicator()
                ]))*/;
        },
      ),
    );
  }
}


// definition of callback function
typedef StarChangeCallback = Function(Contact contact, bool hasStar);
