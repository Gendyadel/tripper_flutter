import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tripper_flutter/models/auth/user_model.dart';
import 'package:tripper_flutter/models/property/property_model.dart';

class FireStoreService {
  final CollectionReference _propertyCollectionReference =
      FirebaseFirestore.instance.collection('products');

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<List<QueryDocumentSnapshot>> getProperties() async {
    var value = await _propertyCollectionReference.get();
    return value.docs;
  }

  Future<DocumentSnapshot<Object>> getSpecificProperty({
    String propertyID,
  }) async {
    //_propertyCollectionReference.doc(propertyID).get();
    var value = await _db.doc('products/$propertyID').get();
    return value;
  }

  Future<List<QueryDocumentSnapshot>> getFavourites(
      {@required String userId}) async {
    var value = await _db.collection('users/$userId/favourites').get();
    return value.docs;
  }

  Future editFavouritesInFirestore({
    String userId,
    String propertyId,
    bool isFavourite,
  }) async {
    return await _userCollectionReference
        .doc('$userId/favourites/$propertyId')
        .set({'isFavourite': isFavourite});

    //'users/$userId/favourites/productID/isFav'
    //doc('users/$userId/favourites/productID/isFav')

    // var value = await _db
    //     .collection('users')
    //     .doc(userId)
    //     .collection('favourites')
    //     .get();
    // return value;
  }
}
