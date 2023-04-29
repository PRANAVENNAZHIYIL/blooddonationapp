import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];
  final _formKey = GlobalKey<FormState>();
  String? selectedGroup;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  TextEditingController donorname = TextEditingController();
  TextEditingController donorphonenumber = TextEditingController();

  void updateDonor(docId) {
    final data = {
      'name': donorname.text,
      'phone': donorphonenumber.text,
      'group': selectedGroup
    };

    if (_formKey.currentState!.validate()) {
      donor.doc(docId).update(data).then((value) => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorname.text = args['name'];
    donorphonenumber.text = args['phone'];
    selectedGroup = args['group'];
    final docId = args['id'];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Donors"),
        backgroundColor: Colors.red,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: donorname,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }

                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black)),
                  hintText: "Donor Name",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: donorphonenumber,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  if (value.length != 10) {
                    return " phone number is 10 digit";
                  }

                  return null;
                },
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black)),
                  hintText: "Mobile Number",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                  value: selectedGroup,
                  validator: (value) {
                    if (value == null) {
                      return 'please select your blood group';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      label: Text(
                        "Select Your Blood Group",
                        style: TextStyle(color: Colors.black),
                      )),
                  items: bloodGroups
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (val) {
                    selectedGroup = val;
                  }),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                height: 40,
                minWidth: double.infinity,
                onPressed: () {
                  updateDonor(docId);
                  //addDonor();
                },
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  "Update",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
