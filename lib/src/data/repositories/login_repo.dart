part of 'repositories.dart';

class LoginRepo {
  late String token;
  late String error;

  login(String username, String password) async {
    token = "";
    error = "";
    final db = FirebaseFirestore.instance;

    try {
      QuerySnapshot user = await db
          .collection("users")
          .where("username", isEqualTo: username)
          .get();
      if (user.docs.isNotEmpty) {
        final doc = user.docs.first;
        if (doc["password"] == password) {
          token = "12341234";
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
