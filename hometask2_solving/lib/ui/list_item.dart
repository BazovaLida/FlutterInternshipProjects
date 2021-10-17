import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hometask2_solving/model/contact.dart';
import 'package:hometask2_solving/model/contact_model.dart';

import 'contact_list.dart';
import 'edit_contact.dart';

class ContactsListItem extends StatelessWidget {
  const ContactsListItem({
    Key? key,
    required this.contact,
    required this.hasStar,
    required this.onStarTapped,
    required this.model
  }) : super(key: key);

  final Contact contact;
  final bool hasStar;
  final StarChangeCallback onStarTapped;
  final ContactModel model;

  // stores the first letter of the last name
  static String lastNameChar = "_";

  TextStyle myTextStyle([FontWeight weight = FontWeight.w300]) => TextStyle(
        fontWeight: weight,
        fontFamily: 'Montserrat',
      );

  // tap-able star icon widget. Calls [StarChangeCallback] on tap
  Widget starIcon() => IconButton(
        splashRadius: 20.0,
        alignment: Alignment.centerLeft,
        icon: Visibility(
          visible: hasStar,
          child: const Icon(Icons.star),
        ),
        color: Colors.lightBlueAccent,
        onPressed: () => onStarTapped(contact, hasStar),
      );

  @override
  Widget build(BuildContext context) {
    if (lastNameChar == contact.lastName[0]) {
      return contactTile(context);
    }

    // update [lastNameChar]
    lastNameChar = contact.lastName[0];
    // insert [lastNameChar] before the contact
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 32.0),
          alignment: Alignment.centerLeft,
          child: Text(
            lastNameChar,
            style: myTextStyle(FontWeight.w100),
          ),
        ),
        contactTile(context),
      ],
    );
  }

  Widget contactTile(BuildContext context) => GestureDetector(
        // Navigate to edit route when tapped.
        onTap: () async {
          // wait for edited contact
          final edited = await Navigator.push(context, MaterialPageRoute(
              builder: (context) => EditContact(contact: contact)));

          model.updateById(edited);
        },
        child: ListTile(
          leading: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            starIcon(),
            CircleAvatar(
              backgroundImage: AssetImage(contact.image),
            )
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
      );
}
