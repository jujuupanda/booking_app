part of 'repositories.dart';

class LoginRepo {
  late String token;
  late String error;
  late String role;
  late String user;

  login(String username, String password) async {
    token = "";
    error = "";
    role = "";
    user = "";
    final db = FirebaseFirestore.instance;

    try {
      QuerySnapshot resultUser = await db
          .collection("users")
          .where("username", isEqualTo: username)
          .get();
      if (resultUser.docs.isNotEmpty) {
        final doc = resultUser.docs.first;
        if (doc["password"] == password) {
          token = "12341234";
          role = doc["role"];
          user = doc["username"];
        } else {
          error = "Password anda salah!";
        }
      } else {
        error = "Pengguna tidak ditemukan!";
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
