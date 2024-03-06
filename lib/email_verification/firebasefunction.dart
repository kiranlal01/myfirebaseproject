import 'package:firebase_auth/firebase_auth.dart';

class FireBaseHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;

  get user => auth.currentUser;

  //User Signup
  Future<String?> registerUser({required String email,required String pass}) async {
    try {
      await  auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      print(e);
    }

  }

  Future<String?> loginUser({required String email,required String pass}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pass
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return e.message;
    }
  }

  Future<void> logout() async{
    await auth.signOut();
  }
}