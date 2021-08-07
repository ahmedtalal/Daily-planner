import 'package:daily_planner/database/firebase/user_operations.dart';
import 'package:daily_planner/database/repository/auth_repository.dart';
import 'package:daily_planner/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthOperations extends AuthRepositoryModel {
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserOperations _userOperations = UserOperations();
  @override
  checkCurrentUser() {
    bool result = false;
    final user = _auth.currentUser;
    // ignore: unnecessary_null_comparison
    if (user != null) {
      result = true;
    } else {
      result = false;
    }
    print(result);
    return result;
  }

  @override
  logOut() async {
    await _auth.signOut();
  }

  @override
  login(model) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
        email: model.email, password: model.password);
    return userCredential;
  }

  @override
  register(model) async {
    var result = false;
    late String userId;
    final newUser = await _auth.createUserWithEmailAndPassword(
        email: model.email, password: model.password);
    // ignore: unnecessary_null_comparison
    if (newUser != null) {
      userId = newUser.user!.uid;
      print(userId);
      UserModel userModel = UserModel.anotherObj(
        id: userId,
        name: model.name,
        email: model.email,
        image: model.image,
      );
      print("object");
      result = await _userOperations.addData(userModel);
    }
    return result;
  }

  @override
  updatePassword(model) async {
    User user = _auth.currentUser!;
    await user.updatePassword(model);
  }
}
