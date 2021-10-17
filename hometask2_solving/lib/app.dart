
import 'package:flutter/material.dart';
import 'package:hometask2_solving/ui/contact_list.dart';
import 'package:provider/provider.dart';

import 'model/contact_model.dart';

class ContactsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "Contacts list",
      home: ChangeNotifierProvider(
        create: (context) => ContactModel(),
        child: ContactListScreen(),
      ),
    );
  }
}
