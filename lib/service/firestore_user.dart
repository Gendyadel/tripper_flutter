import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tripper_flutter/models/auth/user_model.dart';

class FirestoreUser {
  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUserToFirestore(
      {UserModel userModel,
      Function emitError,
      VoidCallback emitSuccess}) async {
    return await _userCollectionReference
        .doc(userModel.uid)
        .set(userModel.toJson());
  }
}
