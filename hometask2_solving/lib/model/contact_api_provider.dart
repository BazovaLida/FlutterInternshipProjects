// import 'dart:convert';
//
// import 'package:http/http.dart' show get;
//
// import 'contact_model.dart';
//
// class ContactApiProvider {
//   final ContactModel model;
//
//   ContactApiProvider(this.model);
//
//   void fetchContactList() async {
//     print("entered");
//     final response = await get(
//         Uri.parse("https://forbes400.herokuapp.com/api/forbes400?limit=30"));
//     print(response.body.toString());
//     if (response.statusCode == 200) {
//       // If the call to the server was successful, parse the JSON
//       return model.initWithJson(json.decode(response.body));
//     } else {
//       // If that call was not successful, throw an error.
//       throw Exception('Failed to load post');
//     }
//   }
// }
