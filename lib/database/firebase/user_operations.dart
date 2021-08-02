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
  deleteData(model) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  getAllData(model) {
    // TODO: implement getAllData
    throw UnimplementedError();
  }

  @override
  getSpecialData(model) {
    // TODO: implement getSpecialData
    throw UnimplementedError();
  }

  @override
  updateData(model) {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
