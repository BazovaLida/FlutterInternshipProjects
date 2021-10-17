import 'package:flutter/material.dart';
import 'package:hometask2_solving/model/contact.dart';

class EditContact extends StatefulWidget {
  final Contact contact;

  const EditContact({Key? key, required this.contact}) : super(key: key);

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [
      TextEditingController(text: widget.contact.name),
      TextEditingController(text: widget.contact.number),
      TextEditingController(text: widget.contact.companyName),
      TextEditingController(text: widget.contact.bio),
    ];
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          title: Container(
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, save the information
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Contact saved')),
                  );
                  Navigator.pop(context, Contact(
                        id: widget.contact.id,
                        image: widget.contact.image,
                        name: controllers[0].text,
                        number: controllers[1].text,
                        companyName: controllers[2].text,
                        bio: controllers[3].text,
                      ));
                }
              },
              child: const Text('Save'),
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 8.0),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: PhysicalModel(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  elevation: 10.0,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(widget.contact.image),
                    radius: 80,
                  ),
                ),
              ),
              _customField(
                  title: "Name",
                  withStar: true,
                  currValidator: maxTextController(70, false),
                  currController: controllers[0]),
              _customField(
                  title: "Phone number",
                  keyboardType: TextInputType.phone,
                  withStar: true,
                  currValidator: phoneNumberController,
                  currController: controllers[1]),
              _customField(
                  title: "Company name", currController: controllers[2]),
              _customField(
                  title: "Bio (notes)",
                  currController: controllers[3],
                  currValidator: maxTextController(110, true)),
            ]),
          ),
        ),
      ),
    );
  }

  final _formKey = new GlobalKey<FormState>();

  Widget _customField(
      {required String title,
      bool withStar = false,
      String example = "",
      currValidator = null,
      required currController,
      TextInputType keyboardType = TextInputType.text}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text(title, style: _fieldTextStyle()),
        Text(withStar ? '*' : "", style: _fieldTextStyle(Colors.red)),
        Expanded(
          child: Text(example,
              style: _fieldTextStyle(),
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.right),
        )
      ]),
      Padding(
        padding: EdgeInsets.only(top: 8, bottom: 25),
        child: TextFormField(
          keyboardType: keyboardType,
          controller: currController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          validator: currValidator,
        ),
      ),
    ]);
  }

  String? phoneNumberController(String? val) {
    if (val != null) {
      val = val.replaceAll(RegExp(r'\s'), '');
      var l = val.length;
      if (!val.startsWith('+38')) {
        return 'Number should start with "+38"';
      } else if (val.length != 13 ||
          !RegExp(r"^\+38[0-9]{10}$").hasMatch(val)) {
        return 'Enter 10 digits after "+38", please';
      }
    }
    return null;
  }

  maxTextController(int maximum, bool canBeEmpty) => (String? val) {
        if (val == null) {
          if (!canBeEmpty) {
            return "Cannot be empty!";
          }
        } else if (val.isEmpty && !canBeEmpty) {
          return "Cannot be empty!";
        } else if (val.length > maximum) {
          return "Field length should be max of " +
              maximum.toString() +
              " symbols";
        }
      };

  TextStyle _fieldTextStyle([color = Colors.grey]) => TextStyle(color: color);
}
