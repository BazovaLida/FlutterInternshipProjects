import 'package:flutter/material.dart';

import 'contact.dart';

class ContactModel extends ChangeNotifier {
  /// Internal, private state of the contact list.
  late final List<Contact> _contacts;

  ContactModel() {
    this._contacts = [
      Contact(
        id: 0,
          name: "Sundar Pichai",
          companyName: "Google LLC",
          image: "avatars/SundarPichai.jpg"),
      Contact(
          id: 1,
          name: "Mark Zuckerberg",
          companyName: "Facebook Inc.",
          image: "avatars/MarkZuckerberg.jpg"),
      Contact(
          id: 2,
          name: "Andy Jassy",
          companyName: "Amazon.com, Inc.",
          image: "avatars/AndyJassy.jpg"),
      Contact(
          id: 3,
          name: "Satya Nadella",
          companyName: "Microsoft Corporation",
          image: "avatars/SatyaNadella.jpg"),
      Contact(
          id: 4,
          name: "Ted Sarandos",
          companyName: "Netflix, Inc.",
          image: "avatars/TedSarandos.jpg"),
      Contact(
          id: 5,
          name: "Elon Musk",
          companyName: "Tesla, Inc.",
          image: "avatars/ElonMusk.jpg"),
      Contact(
          id: 6,
          name: "Tim Cook",
          companyName: "Apple Inc.",
          image: "avatars/TimCook.jpg"),
      Contact(
          id: 7,
          name: "Maxim Shafirov",
          companyName: "JetBrains s.r.o.",
          image: "avatars/MaximShafirov.jpg"),
      Contact(
          id: 8,
          name: "Nat Friedman",
          companyName: "GitHub, Inc.",
          image: "avatars/NatFriedman.jpg"),
      Contact(
          id: 9,
          name: "Arvind Krishna",
          companyName: "International Business Machines Corporation",
          image: "avatars/ArvindKrishna.jpg"),
      Contact(
          id: 10,
          name: "Hyun Suk Kim",
          companyName: "Samsung Electronics Co., Ltd.",
          image: "avatars/HyunSukKim.jpg"),
    ];
  }

  // // set an information from json
  // void initWithJson(List<dynamic> parsedJson) {
  //   parsedJson.forEach((el) {
  //     var c = Contact(
  //         name: el["person"]["personName"],
  //         companyName: el["financialAssets"][0]["companyName"],
  //         image: el["person"]["squareImage"]
  //     );
  //     _contacts.add(Contact(
  //       name: el["person"]["personName"],
  //       companyName: el["financialAssets"][0]["companyName"],
  //       image: el["person"]["squareImage"]
  //     ));
  //   });
  //   // This call tells the widgets that are listening to this model to rebuild.
  //   notifyListeners();
  // }

  /// An unmodifiable view of the contacts in the list.
  List<Contact> get contacts {
    _contacts.sort(
        // Sorting list in alphabet order
        (a, b) => a.lastName.toLowerCase().compareTo(b.lastName.toLowerCase()));
    return _contacts;
  }

  /// Replace element in [_contacts] by id
  void updateById(Contact updated) {
    _contacts.removeWhere((element) => element.id == updated.id);
    _contacts.add(updated);
    notifyListeners();
  }

  void add(Contact newContact){
    _contacts.add(newContact);
    notifyListeners();
  }

  void remove(Contact contact){
    _contacts.remove(contact);
    notifyListeners();
  }
}
