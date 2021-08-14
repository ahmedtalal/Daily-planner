import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_planner/database/repository/db_repository.dart';
import 'package:daily_planner/models/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskOperations extends FirebaseRepositoryModel {
  final _user = FirebaseAuth.instance.currentUser!;
  CollectionReference _collRef = FirebaseFirestore.instance.collection("Tasks");
  CollectionReference _collRef1 =
      FirebaseFirestore.instance.collection("Archives");
  @override
  addData(model) async {
    bool result = false;
    DocumentReference docRef =
        _collRef.doc(_user.uid).collection("list").doc(model.taskId);
    Map<String, dynamic> data = TaskModel.toJson(model);
    await docRef.set(data).whenComplete(() {
      result = true;
    });
    return result;
  }

  @override
  deleteData(model) async {
    bool result = false;
    DocumentReference docRef =
        _collRef.doc(_user.uid).collection("list").doc(model);
    await docRef.delete().whenComplete(() {
      result = true;
    });
    return result;
  }

  @override
  getAllData(model) {
    return _collRef.doc(_user.uid).collection("list").snapshots();
  }

  @override
  getSpecialData(model) {
    // TODO: implement getSpecialData
    throw UnimplementedError();
  }

  @override
  updateData(model) async {
    var result = false;
    DocumentReference docRef =
        _collRef.doc(_user.uid).collection("list").doc(model.taskId);
    Map<String, dynamic> data = TaskModel.toJson(model);
    await docRef.update(data).whenComplete(() {
      result = true;
    });
    return result;
  }

  addArchiveTask(model) async {
    bool result = false;
    DocumentReference docRef =
        _collRef1.doc(_user.uid).collection("list").doc(model.taskId);
    Map<String, dynamic> data = TaskModel.toJson(model);
    await docRef.set(data).whenComplete(() {
      result = true;
    });
    return result;
  }

  deleteArchiveTask(model) async {
    bool result = false;
    DocumentReference docRef =
        _collRef1.doc(_user.uid).collection("list").doc(model);
    await docRef.delete().whenComplete(() {
      result = true;
    });
    return result;
  }

  getAllArchiveData(model) {
    return _collRef1.doc(_user.uid).collection("list").snapshots();
  }
}
