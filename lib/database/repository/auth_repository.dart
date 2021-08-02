abstract class AuthRepositoryModel {
  dynamic login(var model);
  dynamic register(var model);
  dynamic logOut();
  dynamic checkCurrentUser();
  dynamic updatePassword(var model);
}
