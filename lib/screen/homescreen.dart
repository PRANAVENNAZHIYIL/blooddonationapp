import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screen/signin_screen.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  void deletedonor(docid) {
    donor.doc(docid).delete();
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              authService.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false);
            },
            icon: const Icon(Icons.exit_to_app)),
        title: const Text("Blood Donation APP"),
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, 'adduser');
        },
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.red,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: StreamBuilder(
          stream: donor.orderBy('name').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final DocumentSnapshot donorsnap = snapshot.data.docs[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10,
                                spreadRadius: 15)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 30,
                                child: Text(
                                  donorsnap['group'],
                                  style: const TextStyle(fontSize: 25),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                donorsnap['name'],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                donorsnap['phone'].toString(),
                                style: const TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                          IconButton(
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.pushNamed(context, 'updateuser',
                                    arguments: {
                                      'name': donorsnap['name'],
                                      'phone': donorsnap['phone'].toString(),
                                      'group': donorsnap['group'],
                                      'id': donorsnap.id
                                    });
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              color: Colors.red,
                              onPressed: () {
                                deletedonor(donorsnap.id);
                              },
                              icon: const Icon(Icons.delete))
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const Text("hiiii");
          }),
    );
  }
}
