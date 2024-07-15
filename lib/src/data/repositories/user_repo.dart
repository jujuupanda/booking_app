part of 'repositories.dart';

class UserRepo {
  late String statusCode;

  getUser(String username) async {
    statusCode = "";
    try {
      QuerySnapshot resultUser = await Repositories()
          .db
          .collection("users")
          .where("username", isEqualTo: username)
          .get();
      if (resultUser.docs.isNotEmpty) {
        statusCode = "200";
        final user = resultUser.docs.first;
        final userModel = UserModel.fromJson(user.data());
        return userModel;
      } else {
        statusCode = "200";
        return;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
