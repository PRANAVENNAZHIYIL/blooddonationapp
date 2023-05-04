import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  //refrence for our collection
  final CollectionReference donor =
      FirebaseFirestore.instance.collection("donor");

  // saving the userdata
  Future savingUserData(String fullName, String email) async {
    return await donor.doc(uid).set({
      "fullName": fullName,
      "email": email,
    });
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot = await donor.where("email", isEqualTo: email).get();
    return snapshot;
  }
}
