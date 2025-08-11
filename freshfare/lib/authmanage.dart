import 'package:firebase_auth/firebase_auth.dart';

class Authmanage {
  Future signup(String userEmail,String userPass)async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userEmail, password: userPass);
  }

   Future login(String userEmail, String userPass) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPass,
      );
      return true; // login success
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Wrong password.";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}
