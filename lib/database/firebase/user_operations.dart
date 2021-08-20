import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_planner/database/repository/db_repository.dart';
import 'package:daily_planner/models/user_model.dart';

class UserOperations extends FirebaseRepositoryModel {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  addData(model) async {
    var result = false;
    CollectionReference collRef = _firestore.collection("Users");
    DocumentReference docRef = collRef.doc(model.id);
    Map<String, dynamic> data = UserModel.toJson(model);
    await docRef.set(data).whenComplete(() {
      result = true;
    });
    print(result);
    return result;
  }

  @override
  deleteData(model) async {
    bool result = false;
    CollectionReference collRef = _firestore.collection("Users");
    DocumentReference docRef = collRef.doc(model);
    await docRef.delete().whenComplete(() {
      result = true;
    });
    return result;
  }

  @override
  getAllData(model) {
    return _firestore.collection("Users").snapshots();
  }

  @override
  getSpecialData(model) {
    CollectionReference collRef = _firestore.collection("Users");
    DocumentReference docRef = collRef.doc(model);
    return docRef.snapshots();
  }

  @override
  updateData(model) async {
    var result = false;
    CollectionReference collRef = _firestore.collection("Users");
    DocumentReference docRef = collRef.doc(model.id);
    Map<String, dynamic> data = UserModel.toJson(model);
    await docRef.update(data).whenComplete(() {
      result = true;
    });
    return result;
  }
}
